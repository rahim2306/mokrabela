import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/components/teacher/classroom_card.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/classroom_model.dart';
import 'package:mokrabela/screens/common/settings_screen.dart';
import 'package:mokrabela/screens/teacher/class_detail_screen.dart';
import 'package:mokrabela/services/teacher_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TeacherService _teacherService = TeacherService();

  @override
  Widget build(BuildContext context) {
    // Basic localization for MVP till we add specific keys
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 5.h), // Top padding for status bar area
            // Sticky-like Top Bar
            Padding(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Classrooms', // TODO: Localize
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.deepBlue,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.bug_report,
                            color: Colors.blueAccent,
                          ),
                          tooltip: 'Debug: Create Test Class',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Create Debug Class?'),
                                content: const Text(
                                  'This will create a new class containing ALL students in the database.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Create'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await _teacherService.createDebugClassroom();
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Debug Class Created!'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, color: AppTheme.deepBlue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(
                                  currentLocale: Localizations.localeOf(
                                    context,
                                  ),
                                  onLanguageChanged: (locale) {},
                                  userName: 'Teacher',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Main Content
            Expanded(
              child: StreamBuilder<List<ClassroomModel>>(
                stream: _teacherService.getMyClassrooms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final classrooms = snapshot.data ?? [];

                  if (classrooms.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 50.sp,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "No Classrooms Assigned",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 4.w,
                      mainAxisSpacing: 4.w,
                    ),
                    itemCount: classrooms.length,
                    itemBuilder: (context, index) {
                      final classroom = classrooms[index];
                      return ClassroomCard(
                        classroom: classroom,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ClassDetailScreen(classroom: classroom),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
