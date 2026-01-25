import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:mokrabela/components/dialogs/add_child_dialog.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/screens/common/settings_screen.dart';
import 'package:mokrabela/screens/parent/parent_home_tab.dart';
import 'package:mokrabela/screens/parent/parent_stats_tab.dart';
import 'package:mokrabela/screens/parent/parent_profile_tab.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/parent_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

/// Parent Dashboard Main Scaffold with Floating Bottom Navigation
class ParentMainScaffold extends StatefulWidget {
  const ParentMainScaffold({super.key});

  @override
  State<ParentMainScaffold> createState() => _ParentMainScaffoldState();
}

class _ParentMainScaffoldState extends State<ParentMainScaffold>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final ParentService _parentService = ParentService();

  late TabController _tabController;
  int _currentIndex = 0;
  String? _selectedChildId;
  List<UserModel> _children = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    final user = _authService.currentUser;
    if (user != null) {
      _parentService.getChildrenStream(user.uid).listen((children) {
        if (mounted) {
          setState(() {
            _children = children;
            if (_selectedChildId == null && children.isNotEmpty) {
              _selectedChildId = children.first.uid;
            }
          });
        }
      });
    }
  }

  void _onChildSelected(String? childId) {
    setState(() {
      _selectedChildId = childId;
    });
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
            // Top bar with child selector and settings (ALWAYS VISIBLE)
            _buildTopBar(l10n),
            // Main content with floating bottom bar
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
                  children: [
                    ParentHomeTab(selectedChildId: _selectedChildId),
                    ParentStatsTab(selectedChildId: _selectedChildId),
                    ParentProfileTab(selectedChildId: _selectedChildId),
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

  Widget _buildTopBar(AppLocalizations l10n) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 226, 240, 243), // Soft teal
              Color.fromARGB(255, 187, 222, 230), // Soft teal
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Child Selector - LEFT ALIGNED
            Expanded(
              child: GestureDetector(
                onTap: _children.isEmpty
                    ? () {
                        // Show add child dialog
                        AddChildDialog.show(context);
                      }
                    : null,
                child: _children.isEmpty
                    ? // Empty state - tappable card
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(1.5.w),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                size: 18.sp,
                                color: AppTheme.primary,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Add Your First Child',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.deepBlue,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                SizedBox(height: 0.2.h),
                                Text(
                                  'Tap to get started',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : // With children - dropdown
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(1.5.w),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.child_care_rounded,
                                size: 18.sp,
                                color: AppTheme.primary,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Flexible(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedChildId,
                                  isExpanded: false,
                                  icon: Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppTheme.primary,
                                      size: 22.sp,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.deepBlue,
                                    letterSpacing: -0.3,
                                    fontFamily: 'Outfit',
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  dropdownColor: Colors.white,
                                  elevation: 4,
                                  menuMaxHeight: 40.h,
                                  items: [
                                    // Existing children
                                    ..._children.map((child) {
                                      return DropdownMenuItem<String>(
                                        value: child.uid,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 0.5.h,
                                          ),
                                          child: Text(
                                            child.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }),
                                    // Separator
                                    if (_children.isNotEmpty)
                                      const DropdownMenuItem<String>(
                                        value: 'separator',
                                        enabled: false,
                                        child: Divider(height: 1),
                                      ),
                                    // Add Child Option
                                    DropdownMenuItem<String>(
                                      value: 'add_child',
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.5.h,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_rounded,
                                              size: 16.sp,
                                              color: AppTheme.primary,
                                            ),
                                            SizedBox(width: 3.w),
                                            Text(
                                              'Add Child',
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    if (value == 'add_child') {
                                      AddChildDialog.show(context);
                                    } else if (value != 'separator') {
                                      _onChildSelected(value);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
            SizedBox(width: 3.w),
            // Settings button
            GestureDetector(
              onTap: () async {
                final user = _authService.currentUser;
                if (user == null) return;

                final currentLocale = Localizations.localeOf(context);
                final navigator = Navigator.of(context);

                final userDetails = await _authService.getUserDetails(user.uid);

                if (mounted) {
                  navigator.push(
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                        currentLocale: currentLocale,
                        onLanguageChanged: (Locale locale) {},
                        userName: userDetails?.name ?? 'Parent',
                      ),
                    ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.all(3.5.w),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.indigoAccent.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 24.sp,
                  color: Colors.indigoAccent.withValues(alpha: 0.8),
                ),
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
                          ? Icons.bar_chart_rounded
                          : Icons.bar_chart_outlined,
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
                            187,
                            222,
                            230,
                          ).withValues(alpha: 0.2)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _currentIndex == 2
                          ? Icons.person_rounded
                          : Icons.person_outline_rounded,
                      size: 26.sp,
                      color: _currentIndex == 2
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _parentService.dispose();
    super.dispose();
  }
}
