import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/models/classroom_model.dart';
import 'package:mokrabela/models/user_model.dart';
import 'package:mokrabela/screens/teacher/student_progress_screen.dart';
import 'package:mokrabela/services/teacher_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class ClassDetailScreen extends StatefulWidget {
  final ClassroomModel classroom;

  const ClassDetailScreen({super.key, required this.classroom});

  @override
  State<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  final TeacherService _teacherService = TeacherService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.kidsBackgroundGradient,
        ),
        child: Column(
          children: [
            SizedBox(height: 5.h), // Top padding for status bar
            // Sticky-like Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                    // Back Button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18.sp,
                          color: AppTheme.deepBlue,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // Title
                    Expanded(
                      child: Text(
                        widget.classroom.name,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.deepBlue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Main Content
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                stream: _teacherService.getStudentsByClassroom(
                  widget.classroom.id,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final students = snapshot.data ?? [];

                  if (students.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_off_rounded,
                              size: 40.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "No Students in this Class",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 1.h,
                    ),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return _buildStudentTile(student);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLaunchDialog(context),
        backgroundColor: AppTheme.primary,
        icon: Icon(Icons.rocket_launch_rounded, color: Colors.white),
        label: Text(
          "Launch Activity",
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _showLaunchDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Launch Group Activity",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "Select an activity to start for the whole class.",
              style: TextStyle(fontSize: 12.sp, color: AppTheme.textSecondary),
            ),
            SizedBox(height: 3.h),
            _buildActivityOption(
              context,
              title: "Ocean Breath",
              subtitle: "Calming breathing exercise (10s)",
              icon: Icons.waves,
              color: Colors.blueAccent,
              onTap: () => _launchActivity("breathing", "ocean_breath"),
            ),
            _buildActivityOption(
              context,
              title: "STOP Technique",
              subtitle: "Emergency grounding (6s)",
              icon: Icons.pan_tool_rounded,
              color: Colors.redAccent,
              onTap: () => _launchActivity("stop_technique", "stop_technique"),
            ),
            _buildActivityOption(
              context,
              title: "Focus Time",
              subtitle: "Silent focus timer (Coming Soon)",
              icon: Icons.timer,
              color: Colors.purpleAccent,
              isComingSoon: true,
              onTap: () {},
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: GoogleFonts.spaceGrotesk(
          fontWeight: FontWeight.bold,
          color: isComingSoon ? Colors.grey : AppTheme.deepBlue,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: isComingSoon
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Soon",
                style: TextStyle(fontSize: 10.sp, color: Colors.grey),
              ),
            )
          : Icon(Icons.arrow_forward_ios, size: 12.sp, color: Colors.grey),
    );
  }

  Future<void> _launchActivity(String type, String contentId) async {
    Navigator.pop(context); // Close dialog
    try {
      await _teacherService.launchClassActivity(
        classroomId: widget.classroom.id,
        type: type,
        contentId: contentId,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("🚀 Activity Launched!"),
            backgroundColor: AppTheme.successGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to launch: $e"),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    }
  }

  Widget _buildStudentTile(UserModel student) {
    return StreamBuilder<Map<String, dynamic>?>(
      stream: _teacherService.getStudentLiveState(student.uid),
      builder: (context, snapshot) {
        final liveData = snapshot.data;
        // MAPPING: hyperactivityIndex -> Stress/Traffic Light
        // < 30: Low/Calm (Green)
        // 30-70: Medium/Active (Orange)
        // > 70: High/Stress (Red)
        final score =
            (liveData?['hyperactivityIndex'] as num?)?.toDouble() ?? 0.0;
        final lastUpdate = liveData?['lastUpdate'];
        final isOnline =
            liveData != null &&
            lastUpdate != null &&
            DateTime.now()
                    .difference(
                      DateTime.fromMillisecondsSinceEpoch(
                        lastUpdate is int ? lastUpdate : 0,
                      ),
                    )
                    .inMinutes <
                5;

        Color statusColor;
        String statusText;

        if (!isOnline) {
          statusColor = Colors.grey;
          statusText = "Offline";
        } else if (score < 30) {
          statusColor = AppTheme.successGreen;
          statusText = "Calm";
        } else if (score < 70) {
          statusColor = AppTheme.warningYellow;
          statusText = "Active";
        } else {
          statusColor = AppTheme.errorRed;
          statusText = "High Stress";
        }

        return Container(
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.h,
              ),
              leading: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primary.withValues(alpha: 0.2),
                          const Color(0xFF8B7FEA).withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        student.name.isNotEmpty
                            ? student.name[0].toUpperCase()
                            : '?',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  if (isOnline)
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.3),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                student.name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepBlue,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    'Age: ${student.profile.age ?? "N/A"}',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 12.sp,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(width: 1, height: 12, color: Colors.grey[300]),
                  SizedBox(width: 2.w),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12.sp,
                  color: AppTheme.primary,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentProgressScreen(student: student),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
