import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/screens/child/kids_hub_screen.dart';
import 'package:mokrabela/screens/child/kids_achievements_screen.dart';
import 'package:mokrabela/screens/child/kids_protocol_screen.dart';
import 'package:mokrabela/screens/common/settings_screen.dart';
import 'package:mokrabela/components/bars/floating_top_bar.dart';
import 'package:mokrabela/components/popups/protocol_status_popup.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/realtime_sync_service.dart';
import 'package:mokrabela/screens/settings/watch_connection_screen.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:mokrabela/theme/app_theme.dart';

/// Main scaffold for kids with floating bottom navigation
class KidsMainScaffold extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  final Locale currentLocale;

  const KidsMainScaffold({
    super.key,
    required this.onLanguageChange,
    required this.currentLocale,
  });

  @override
  State<KidsMainScaffold> createState() => _KidsMainScaffoldState();
}

class _KidsMainScaffoldState extends State<KidsMainScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AuthService _authService = AuthService();
  StreamSubscription? _progressSubscription;
  int _currentIndex = 0;
  final bool _isWatchConnected = false;
  String _firstName = 'Friend';
  final List<int> _completedSquares = [];
  int _calmMinutes = 0;
  int _dailyGoalMinutes = 30; // Default
  StreamSubscription? _calmTimeSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    _loadUserName();
    _initCalmTimeTracking();
    RealtimeSyncService().startSync();
  }

  void _initCalmTimeTracking() {
    final user = _authService.currentUser;
    if (user != null) {
      // 1. Fetch daily goal setting
      _fetchDailyGoal(user.uid);

      // 2. Listen to today's sessions to calculate calm time
      final todayStr = DateTime.now().toIso8601String().split('T')[0];

      // We listen to sessions collection directly for today's sessions
      // Or we can use dailyProtocols if we trust it's updated correctly
      // Let's use dailyProtocols since we have an index for it now and it stores totalFocusTime
      _calmTimeSubscription = FirebaseFirestore.instance
          .collection('dailyProtocols')
          .doc('${user.uid}_$todayStr')
          .snapshots()
          .listen((snapshot) {
            if (snapshot.exists && snapshot.data() != null) {
              final data = snapshot.data()!;
              final seconds = data['totalFocusTime'] as int? ?? 0;
              if (mounted) {
                setState(() {
                  _calmMinutes = (seconds / 60).floor();
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  _calmMinutes = 0;
                });
              }
            }
          });
    }
  }

  Future<void> _fetchDailyGoal(String uid) async {
    final userDetails = await _authService.getUserDetails(uid);
    if (userDetails != null && mounted) {
      setState(() {
        _dailyGoalMinutes = userDetails.appSettings.dailyCalmGoalMinutes;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressSubscription?.cancel();
    _calmTimeSubscription?.cancel();
    RealtimeSyncService().stopSync();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final user = _authService.currentUser;
    if (user != null) {
      final userModel = await _authService.getUserDetails(user.uid);
      if (userModel != null && userModel.name.isNotEmpty) {
        setState(() {
          // Extract first name from "firstname lastname" format
          final nameParts = userModel.name.trim().split(' ');
          if (nameParts.isNotEmpty) {
            final firstName = nameParts[0];
            // Capitalize first letter
            _firstName = firstName.isEmpty
                ? 'Friend'
                : firstName[0].toUpperCase() +
                      firstName.substring(1).toLowerCase();
          }
        });
      }
    }
  }

  void _showProtocolStatus() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.1),
      builder: (context) =>
          ProtocolStatusPopup(completedSquares: _completedSquares),
    );
  }

  void _showWatchConnectionDialog(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WatchConnectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            // Persistent floating top bar with progress, watch status, and settings
            FloatingTopBar(
              isWatchConnected: _isWatchConnected,
              onWatchTap: () => _showWatchConnectionDialog(context),
              onSettingsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      onLanguageChanged: widget.onLanguageChange,
                      currentLocale: widget.currentLocale,
                      userName: _firstName,
                    ),
                  ),
                ).then((_) {
                  // Reload goal when returning from settings
                  final user = _authService.currentUser;
                  if (user != null) _fetchDailyGoal(user.uid);
                });
              },
              onProgressTap: _showProtocolStatus,
              // New Calm Time Props
              completedTasks: _calmMinutes,
              totalTasks: _dailyGoalMinutes,
              // We are reusing the existing props but we should rename them in FloatingTopBar next
            ),
            // Main content with bottom bar
            Expanded(
              child: BottomBar(
                fit: StackFit.expand,
                borderRadius: BorderRadius.circular(50),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                showIcon: true,
                width: MediaQuery.of(context).size.width * 0.8,
                barColor: Colors.white,
                start: 2,
                end: 0,
                offset: 10,
                barAlignment: Alignment.bottomCenter,
                iconHeight: 4.h,
                iconWidth: 4.h,
                reverse: false,
                hideOnScroll: false,
                scrollOpposite: false,
                onBottomBarHidden: () {},
                onBottomBarShown: () {},
                body: (context, controller) => TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    KidsHubScreen(),
                    KidsAchievementsScreen(),
                    KidsProtocolScreen(),
                  ],
                ),
                child: _buildFloatingNavBar(l10n),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingNavBar(AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            border: Border.all(
              color: const Color.fromARGB(
                255,
                187,
                222,
                230,
              ).withValues(alpha: 0.3),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: const BoxDecoration(),
            labelColor: const Color.fromARGB(255, 187, 222, 230),
            unselectedLabelColor: Colors.grey,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                icon: Container(
                  decoration: BoxDecoration(
                    color: _currentIndex == 0
                        ? const Color.fromARGB(
                            255,
                            187,
                            222,
                            230,
                          ).withValues(alpha: 0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _currentIndex == 0
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                      size: 26.sp,
                      color: _currentIndex == 0
                          ? const Color.fromARGB(
                              255,
                              17,
                              83,
                              98,
                            ).withValues(alpha: 0.9)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  decoration: BoxDecoration(
                    color: _currentIndex == 1
                        ? const Color.fromARGB(
                            255,
                            187,
                            222,
                            230,
                          ).withValues(alpha: 0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _currentIndex == 1
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 26.sp,
                      color: _currentIndex == 1
                          ? const Color.fromARGB(
                              255,
                              17,
                              83,
                              98,
                            ).withValues(alpha: 0.9)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  decoration: BoxDecoration(
                    color: _currentIndex == 2
                        ? const Color.fromARGB(
                            255,
                            17,
                            83,
                            98,
                          ).withValues(alpha: 0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.grid_goldenratio_rounded,
                      size: 26.sp,
                      color: _currentIndex == 2
                          ? const Color.fromARGB(
                              255,
                              5,
                              35,
                              42,
                            ).withValues(alpha: 0.9)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
