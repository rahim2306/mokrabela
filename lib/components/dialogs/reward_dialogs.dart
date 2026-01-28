import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokrabela/components/parent/rewards/reward_feed_widget.dart';
import 'package:mokrabela/models/reward_model.dart';
import 'package:mokrabela/services/parent_service.dart';
import 'package:mokrabela/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class RewardDialogs {
  static void showHistory(
    BuildContext context, {
    required String childId,
    required String childName,
  }) {
    showDialog(
      context: context,
      builder: (context) =>
          _RewardHistoryDialog(childId: childId, childName: childName),
    );
  }

  static void showSend(
    BuildContext context, {
    required String childId,
    required String childName,
  }) {
    showDialog(
      context: context,
      builder: (context) =>
          _SendRewardDialog(childId: childId, childName: childName),
    );
  }
}

class _RewardHistoryDialog extends StatelessWidget {
  final String childId;
  final String childName;
  final ParentService _parentService = ParentService();

  _RewardHistoryDialog({required this.childId, required this.childName});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        height: 70.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rewards for $childName',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepBlue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder<List<Reward>>(
                stream: _parentService.getRewardsStream(childId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final rewards = snapshot.data ?? [];
                  return RewardFeedWidget(
                    rewards: rewards,
                    currentUserId: currentUserId,
                  );
                },
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Close history and open send dialog
                  Navigator.pop(context);
                  RewardDialogs.showSend(
                    context,
                    childId: childId,
                    childName: childName,
                  );
                },
                icon: const Icon(Icons.card_giftcard),
                label: const Text('Send New Reward'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SendRewardDialog extends StatefulWidget {
  final String childId;
  final String childName;

  const _SendRewardDialog({required this.childId, required this.childName});

  @override
  State<_SendRewardDialog> createState() => _SendRewardDialogState();
}

class _SendRewardDialogState extends State<_SendRewardDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final ParentService _parentService = ParentService();
  bool _isSending = false;
  String? _selectedSticker;

  final List<String> _stickers = [
    'assets/images/icons/crown.png',
    'assets/images/icons/present.png',
    'assets/images/icons/badge.png',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final isMessageTab = _tabController.index == 0;
    final content = isMessageTab
        ? _messageController.text.trim()
        : _selectedSticker;

    if (content == null || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select content to send')),
      );
      return;
    }

    setState(() => _isSending = true);

    try {
      final currentUser = FirebaseAuth.instance.currentUser!;
      final isParent = await _parentService.isParent(currentUser.uid);
      final senderName =
          currentUser.displayName ?? (isParent ? 'Dad/Mom' : 'Teacher');

      final reward = Reward(
        id: '', // Generated by service
        childId: widget.childId,
        senderId: currentUser.uid,
        senderName: senderName,
        senderRole: isParent ? SenderRole.parent : SenderRole.teacher,
        type: isMessageTab ? RewardType.message : RewardType.sticker,
        content: content,
        timestamp: DateTime.now(),
      );

      await _parentService.sendReward(reward);

      if (mounted) {
        Navigator.pop(context); // Close send dialog
        // Re-open history to show sent item
        RewardDialogs.showHistory(
          context,
          childId: widget.childId,
          childName: widget.childName,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error sending: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Text(
              'Send Reward to ${widget.childName}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepBlue,
              ),
            ),
            SizedBox(height: 2.h),
            TabBar(
              controller: _tabController,
              labelColor: AppTheme.primary,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.primary,
              tabs: const [
                Tab(text: 'Message'),
                Tab(text: 'Sticker'),
              ],
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildMessageTab(), _buildStickerTab()],
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSending ? null : _send,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageTab() {
    return Column(
      children: [
        TextField(
          controller: _messageController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Write a motivational message...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 2.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSuggestionChip('Good Job 🌟'),
              SizedBox(width: 2.w),
              _buildSuggestionChip('Bon Travail 👏'),
              SizedBox(width: 2.w),
              _buildSuggestionChip('أحسنت 👑'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      backgroundColor: AppTheme.primary.withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: AppTheme.primary,
        fontSize: 13.sp, // Bigger text
        fontWeight: FontWeight.w600,
        fontFamily: 'Outfit',
      ),
      onPressed: () {
        _messageController.text = text;
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
    );
  }

  Widget _buildStickerTab() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _stickers.length,
      itemBuilder: (context, index) {
        final sticker = _stickers[index];
        final isSelected = _selectedSticker == sticker;

        return GestureDetector(
          onTap: () => setState(() => _selectedSticker = sticker),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primary.withValues(alpha: 0.1)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppTheme.primary : Colors.grey[200]!,
                width: 2,
              ),
            ),
            padding: EdgeInsets.all(2.w),
            child: Image.asset(
              sticker,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
