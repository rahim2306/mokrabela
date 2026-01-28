import 'package:flutter/material.dart';
import 'package:mokrabela/models/reward_model.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RewardFeedWidget extends StatelessWidget {
  final List<Reward> rewards;
  final String currentUserId;

  const RewardFeedWidget({
    super.key,
    required this.rewards,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    if (rewards.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.stars_rounded,
              size: 40.sp,
              color: AppTheme.textSecondary.withValues(alpha: 0.2),
            ),
            SizedBox(height: 2.h),
            Text(
              'No rewards sent yet\nStart encouraging them!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AppTheme.textSecondary),
            ),
          ],
        ),
      );
    }

    // Reverse list so most recent is at bottom if we were building a chat
    // But for a history log, descending order (newest top) usually makes sense
    // Let's stick to descending order (newest first) as provided by stream

    return ListView.builder(
      padding: EdgeInsets.all(4.w),
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        final reward = rewards[index];
        final isMe = reward.senderId == currentUserId;

        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 0.5.h,
                    start: 2.w,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        reward.senderRole == SenderRole.teacher
                            ? Icons.school_rounded
                            : Icons.face_rounded,
                        size: 16.sp,
                        color: AppTheme.primary,
                      ),
                      SizedBox(width: 1.5.w),
                      Text(
                        reward.senderName,
                        style: TextStyle(
                          fontSize: 13.sp, // Bigger and readable
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              _buildRewardBubble(context, reward, isMe),
              SizedBox(height: 0.5.h),
              Text(
                DateFormat.MMMd().add_jm().format(reward.timestamp),
                style: TextStyle(
                  fontSize: 11.sp, // Bigger timestamp
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardBubble(BuildContext context, Reward reward, bool isMe) {
    if (reward.type == RewardType.sticker) {
      return Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isMe
              ? AppTheme.primary.withValues(alpha: 0.1)
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: isMe
              ? Border.all(color: AppTheme.primary.withValues(alpha: 0.3))
              : Border.all(color: Colors.transparent),
        ),
        child: Image.asset(
          reward.content,
          width: 100, // Bigger sticker
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
          },
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
      constraints: BoxConstraints(maxWidth: 75.w),
      decoration: BoxDecoration(
        color: isMe
            ? AppTheme.primary
            : const Color(0xFFF0F4F8), // Lighter grey for better contrast
        borderRadius: BorderRadiusDirectional.only(
          topStart: const Radius.circular(24),
          topEnd: const Radius.circular(24),
          bottomStart: Radius.circular(isMe ? 24 : 6),
          bottomEnd: Radius.circular(isMe ? 6 : 24),
        ).resolve(Directionality.of(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        reward.content,
        style: TextStyle(
          fontSize: 14.sp, // significantly bigger for kids
          fontWeight: FontWeight.w600, // bolder text
          color: isMe ? Colors.white : AppTheme.deepBlue,
          height: 1.4,
        ),
      ),
    );
  }
}
