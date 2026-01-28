import 'package:cloud_firestore/cloud_firestore.dart';

enum RewardType { message, sticker }

enum SenderRole { parent, teacher }

class Reward {
  final String id;
  final String childId;
  final String senderId;
  final String senderName;
  final SenderRole senderRole;
  final RewardType type;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const Reward({
    required this.id,
    required this.childId,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.type,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'childId': childId,
      'senderId': senderId,
      'senderName': senderName,
      'senderRole': senderRole.name,
      'type': type.name, // 'message' or 'sticker'
      'content': content,
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }

  factory Reward.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Reward(
      id: doc.id,
      childId: data['childId'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName:
          data['senderName'] ??
          (data['senderRole'] == 'teacher' ? 'Teacher' : 'Parent'),
      senderRole: SenderRole.values.firstWhere(
        (e) => e.name == (data['senderRole'] ?? 'parent'),
        orElse: () => SenderRole.parent,
      ),
      type: RewardType.values.firstWhere(
        (e) => e.name == (data['type'] ?? 'message'),
        orElse: () => RewardType.message,
      ),
      content: data['content'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Reward copyWith({
    String? id,
    String? childId,
    String? senderId,
    String? senderName,
    SenderRole? senderRole,
    RewardType? type,
    String? content,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Reward(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      type: type ?? this.type,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}
