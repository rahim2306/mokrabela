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
              _buildRewardBubble(reward, isMe),
              SizedBox(height: 0.5.h),
              Text(
                DateFormat.MMMd().add_jm().format(reward.timestamp),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppTheme.textSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardBubble(Reward reward, bool isMe) {
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
          width: 80,
          height: 80,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 40, color: Colors.grey);
          },
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      constraints: BoxConstraints(maxWidth: 70.w),
      decoration: BoxDecoration(
        color: isMe ? AppTheme.primary : Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isMe ? 20 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 20),
        ),
      ),
      child: Text(
        reward.content,
        style: TextStyle(
          fontSize: 12.sp,
          color: isMe ? Colors.white : AppTheme.deepBlue,
          height: 1.4,
        ),
      ),
    );
  }
}
