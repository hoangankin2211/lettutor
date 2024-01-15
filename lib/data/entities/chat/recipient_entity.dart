import 'package:lettutor/data/entities/chat/message_entity.dart';

class RecipientEntity {
  final List<MessageEntity> messages;
  final int unreadCount;
  RecipientEntity({
    required this.messages,
    required this.unreadCount,
  });

  RecipientEntity copyWith({
    List<MessageEntity>? messages,
    int? unreadCount,
  }) {
    return RecipientEntity(
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages.map((x) => x.toMap()).toList(),
      'unreadCount': unreadCount,
    };
  }

  factory RecipientEntity.fromJson(Map<String, dynamic> map) {
    return RecipientEntity(
      messages: List<MessageEntity>.from(
        (map['messages'] as List<dynamic>? ?? []).map<MessageEntity>(
          (x) => MessageEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
      unreadCount: map['unreadCount'] as int? ?? 0,
    );
  }
}
