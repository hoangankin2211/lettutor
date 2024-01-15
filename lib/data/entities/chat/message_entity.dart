import 'package:lettutor/data/entities/chat/from_info_entity.dart';
import 'package:lettutor/data/entities/chat/new_message.dart';

class MessageEntity {
  final String id;
  final String content;
  final bool isRead;
  final String createdAt;
  final FromInfoEntity fromInfo;
  final FromInfoEntity toInfo;
  final FromInfoEntity? partner;
  MessageEntity({
    required this.id,
    required this.content,
    required this.isRead,
    required this.createdAt,
    required this.fromInfo,
    required this.toInfo,
    this.partner,
  });

  MessageEntity copyWith({
    String? id,
    String? content,
    bool? isRead,
    String? createdAt,
    FromInfoEntity? fromInfo,
    FromInfoEntity? toInfo,
    FromInfoEntity? partner,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      fromInfo: fromInfo ?? this.fromInfo,
      toInfo: toInfo ?? this.toInfo,
      partner: partner ?? this.partner,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isRead': isRead,
      'createdAt': createdAt,
      'fromInfo': fromInfo.toMap(),
      'toInfo': toInfo.toMap(),
      'partner': partner?.toMap(),
    };
  }

  factory MessageEntity.fromNewMessage(NewMessage newMessage) {
    return MessageEntity(
      id: newMessage.id,
      content: newMessage.content,
      isRead: newMessage.isRead,
      createdAt: newMessage.createdAt,
      fromInfo: FromInfoEntity(id: newMessage.fromId),
      toInfo: FromInfoEntity(id: newMessage.fromId),
    );
  }

  factory MessageEntity.fromJson(Map<String, dynamic> map) {
    return MessageEntity(
      id: map['id'] as String? ?? "",
      content: map['content'] as String? ?? "",
      isRead: map['isRead'] as bool? ?? true,
      createdAt: map['createdAt'] as String? ?? "",
      fromInfo: FromInfoEntity.fromJson(
          map['fromInfo'] as Map<String, dynamic>? ?? {}),
      toInfo:
          FromInfoEntity.fromJson(map['toInfo'] as Map<String, dynamic>? ?? {}),
      partner: FromInfoEntity.fromJson(
          map['partner'] as Map<String, dynamic>? ?? {}),
    );
  }
}
