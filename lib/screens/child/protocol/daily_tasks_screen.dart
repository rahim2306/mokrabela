import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:mokrabela/l10n/app_localizations.dart';
import 'package:mokrabela/models/daily_task.dart';
import 'package:mokrabela/services/auth_service.dart';
import 'package:mokrabela/services/task_service.dart';
import 'dart:async';
import 'package:mokrabela/services/protocol_service.dart';
import 'package:uuid/uuid.dart';

class DailyTasksScreen extends StatefulWidget {
  const DailyTasksScreen({super.key});

  @override
  State<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  final TaskService _taskService = TaskService();
  final AuthService _authService = AuthService();
  final ProtocolService _protocolService = ProtocolService();
  final Uuid _uuid = const Uuid();

  // Timer State
  Timer? _timer;
  int _remainingSeconds = 25 * 60; // 25 minutes default
  bool _isRunning = false;

  String? _childId;
  Stream<List<DailyTask>>? _tasksStream;

  @override
  void initState() {
    super.initState();
    _loadChildId();
  }

  Future<void> _loadChildId() async {
    final user = _authService.currentUser;
    if (user != null) {
      setState(() {
        _childId = user.uid;
        _tasksStream = _taskService.getTasks(_childId!);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        setState(() => _isRunning = false);
        _showCompletionDialog();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 25 * 60;
      _isRunning = false;
    });
  }

  void _showCompletionDialog() {
    _saveSession();
    // Basic completion feedback
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Great Job!"),
        content: const Text("You finished your focus session!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Awesome!"),
          ),
        ],
      ),
    );
  }

  Future<void> _saveSession() async {
    if (_childId != null) {
      await _protocolService.updateProtocolProgress(_childId!, 3);
    }
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds / 60).floor();
    final seconds = totalSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void _showAddTaskDialog() {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController titleController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 5.w,
                right: 5.w,
                top: 3.h,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppTheme.border.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Center(
                      child: Text(
                        l10n.dtNewTask,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 22.sp, // INCREASED significantly
                          fontWeight: FontWeight.w800, // Bolder
                          color: AppTheme.deepBlue,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h), // More breathing room
                    // Task Title Input
                    TextField(
                      controller: titleController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: l10n.dtTaskTitlePlaceholder,
                        hintStyle: GoogleFonts.spaceGrotesk(
                          color: AppTheme.textSecondary.withValues(alpha: 0.4),
                          fontSize: 16.sp, // Much larger placeholder
                          fontWeight: FontWeight.w600,
                        ),
                        filled: true,
                        fillColor: AppTheme.backgroundLight.withValues(
                          alpha: 0.5,
                        ), // Softer fill
                        // Explicitly removing ALL borders to override theme
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h, // Taller touch target
                        ),
                      ),
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18.sp, // Much larger input text
                        fontWeight: FontWeight.w700,
                        color: AppTheme.deepBlue,
                      ),
                      cursorColor: AppTheme.vibrantOrange,
                    ),
                    SizedBox(height: 4.h),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 2.5.h),
                              foregroundColor: AppTheme
                                  .textSecondary, // Explicit splash color
                            ),
                            child: Text(
                              l10n.dtCancelButton,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 14.sp, // Larger
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (titleController.text.isNotEmpty &&
                                  _childId != null) {
                                final newTask = DailyTask(
                                  id: _uuid.v4(),
                                  childId: _childId!,
                                  title: titleController.text,
                                  createdAt: DateTime.now(),
                                );

                                Navigator.pop(context);
                                await _taskService.addTask(newTask);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.vibrantOrange,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 2.5.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  28,
                                ), // More rounded
                              ),
                            ),
                            child: Text(
                              l10n.dtAddButton,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 16.sp, // Big button text
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFF9E6), // Softer yellow background
              AppTheme.kidsBackgroundGradient.colors.last.withValues(
                alpha: 0.15,
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(1.2.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppTheme.border.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF1A1A1A,
                              ).withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: AppTheme.deepBlue,
                          size: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.square3Title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 22.sp, // Increased
                        fontWeight: FontWeight.w800, // Bolder
                        color: AppTheme.deepBlue,
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timer Section
                      Hero(
                        tag: 'daily_tasks_card',
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(2.5.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFB366), // Vibrant yellow/orange
                                  Color(0xFFFF9433),
                                  Color(0xFFFFD1A3),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFFFB366,
                                  ).withValues(alpha: 0.35),
                                  blurRadius: 25,
                                  offset: const Offset(0, 12),
                                  spreadRadius: -4,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                    vertical: 0.8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    l10n.focusTimer.toUpperCase(),
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                // Circle Timer
                                Container(
                                  width: 20.h,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 6,
                                    ),
                                    color: Colors.white.withValues(alpha: 0.1),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _formatTime(_remainingSeconds),
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 28.sp, // Larger
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            letterSpacing: -1.5,
                                          ),
                                        ),
                                        Text(
                                          l10n.minutes,
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 12.sp, // Larger
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white.withValues(
                                              alpha: 0.9,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                // Control Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: _isRunning
                                          ? _pauseTimer
                                          : _startTimer,
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 1.8.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.1,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              _isRunning
                                                  ? Icons.pause_rounded
                                                  : Icons.play_arrow_rounded,
                                              color: const Color(0xFFFF9433),
                                              size: 22.sp,
                                            ),
                                            SizedBox(width: 2.w),
                                            Text(
                                              (_isRunning
                                                      ? l10n.pause
                                                      : l10n.start)
                                                  .toUpperCase(),
                                              style: GoogleFonts.spaceGrotesk(
                                                fontSize: 14.sp, // Larger
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xFFFF9433),
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (_remainingSeconds < 25 * 60) ...[
                                      SizedBox(width: 4.w),
                                      IconButton(
                                        onPressed: _resetTimer,
                                        icon: Icon(
                                          Icons.refresh_rounded,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.white
                                              .withValues(alpha: 0.2),
                                          padding: EdgeInsets.all(1.5.h),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // Live Tasks List
                      StreamBuilder<List<DailyTask>>(
                        stream: _tasksStream,
                        builder: (context, snapshot) {
                          final tasks = snapshot.data ?? [];
                          final completedProgress = snapshot.hasData
                              ? "${tasks.where((t) => t.isCompleted).length} of ${tasks.length} completed"
                              : "Tasks list";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.myTasks,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 20.sp, // Increased
                                          fontWeight: FontWeight.w800,
                                          color: AppTheme.deepBlue,
                                          letterSpacing: -0.6,
                                        ),
                                      ),
                                      Text(
                                        completedProgress,
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 13.sp, // Increased
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.textSecondary
                                              .withValues(alpha: 0.8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: _showAddTaskDialog,
                                    child: Container(
                                      padding: EdgeInsets.all(1.h),
                                      decoration: BoxDecoration(
                                        color: AppTheme.tealGreen.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: AppTheme.tealGreen.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add_rounded,
                                        color: AppTheme.tealGreen,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.h),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else if (tasks.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6.h,
                                    horizontal: 4.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(3.h),
                                    border: Border.all(
                                      color: AppTheme.border.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFF0F0F0),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2.5.h),
                                        decoration: BoxDecoration(
                                          color: AppTheme.backgroundLight,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.assignment_outlined,
                                          size: 32.sp,
                                          color: AppTheme.textLight,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        "No tasks for today",
                                        style: GoogleFonts.spaceGrotesk(
                                          color: AppTheme.deepBlue,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "Add a task to start your day!",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(
                                          color: AppTheme.textSecondary,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tasks.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 1.5.h),
                                  itemBuilder: (context, index) {
                                    final task = tasks[index];
                                    final isCompleted = task.isCompleted;

                                    return Dismissible(
                                      key: Key(task.id),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(right: 5.w),
                                        decoration: BoxDecoration(
                                          color: AppTheme.error,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.delete_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onDismissed: (direction) =>
                                          _taskService.deleteTask(task.id),
                                      child: GestureDetector(
                                        onTap: () {
                                          _taskService.updateTask(
                                            task.copyWith(
                                              isCompleted: !isCompleted,
                                              completedAt: !isCompleted
                                                  ? DateTime.now()
                                                  : null,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 4.w,
                                            vertical: 2.2.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            border: Border.all(
                                              color: AppTheme.border.withValues(
                                                alpha: 0.3,
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              AnimatedContainer(
                                                duration: const Duration(
                                                  milliseconds: 300,
                                                ),
                                                width: 28,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: isCompleted
                                                      ? const LinearGradient(
                                                          colors: [
                                                            Color(0xFF4ECDC4),
                                                            Color(0xFF45B7AF),
                                                          ],
                                                        )
                                                      : null,
                                                  color: isCompleted
                                                      ? null
                                                      : Colors.white,
                                                  border: Border.all(
                                                    color: isCompleted
                                                        ? Colors.transparent
                                                        : AppTheme.border,
                                                    width: 2,
                                                  ),
                                                  boxShadow: isCompleted
                                                      ? [
                                                          BoxShadow(
                                                            color:
                                                                const Color(
                                                                  0xFF4ECDC4,
                                                                ).withValues(
                                                                  alpha: 0.3,
                                                                ),
                                                            blurRadius: 8,
                                                            offset:
                                                                const Offset(
                                                                  0,
                                                                  4,
                                                                ),
                                                          ),
                                                        ]
                                                      : [],
                                                ),
                                                child: isCompleted
                                                    ? Icon(
                                                        Icons.check_rounded,
                                                        size: 18.sp,
                                                        color: Colors.white,
                                                      )
                                                    : null,
                                              ),
                                              SizedBox(width: 4.w),
                                              Expanded(
                                                child: Text(
                                                  task.title,
                                                  style: GoogleFonts.spaceGrotesk(
                                                    fontSize: 15
                                                        .sp, // Increased significantly
                                                    fontWeight: FontWeight.w700,
                                                    color: isCompleted
                                                        ? AppTheme.textSecondary
                                                        : AppTheme.deepBlue,
                                                    decoration: isCompleted
                                                        ? TextDecoration
                                                              .lineThrough
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFFFF9433), // Vibrant orange/yellow
        elevation: 3,
        highlightElevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
        label: Text(
          l10n.addTask,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14.sp, // Larger
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
