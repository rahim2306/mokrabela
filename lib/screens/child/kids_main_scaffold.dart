import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/screens/child/kids_hub_screen.dart';
import 'package:mokrabela/screens/child/kids_achievements_screen.dart';
import 'package:mokrabela/screens/child/kids_protocol_screen.dart';
import 'package:mokrabela/screens/common/settings_screen.dart';
import 'package:mokrabela/components/bars/floating_top_bar.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:sizer/sizer.dart';

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
  int _currentIndex = 0;
  bool _isWatchConnected = false;
  String _firstName = 'Friend';

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleWatchConnection() {
    setState(() {
      _isWatchConnected = !_isWatchConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFA), // Off-white at top
              Color.fromARGB(
                255,
                187,
                222,
                230,
              ), // Soft teal/mint in middle (greeting area)
              Color(0xFFFAFAFA), // Off-white at bottom
            ],
            stops: [0.0, 0.1, 0.9], // Color concentrated in upper-middle area
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            // Persistent floating top bar with progress, watch status, and settings
            FloatingTopBar(
              isWatchConnected: _isWatchConnected,
              onWatchTap: _toggleWatchConnection,
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
                );
              },
              completedTasks: 2, // TODO: Get from state/database
              totalTasks: 5,
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
                iconHeight: 35,
                iconWidth: 35,
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
