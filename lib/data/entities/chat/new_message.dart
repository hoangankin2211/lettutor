class NewMessage {
  final String id;
  final String content;
  final bool isRead;
  final String createdAt;
  final String fromId;
  final String toId;
  NewMessage({
    required this.id,
    required this.content,
    required this.isRead,
    required this.createdAt,
    required this.fromId,
    required this.toId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isRead': isRead,
      'createdAt': createdAt,
      'fromId': fromId,
      'toId': toId,
    };
  }

  factory NewMessage.fromJson(Map<String, dynamic> map) {
    return NewMessage(
      id: map['id'] as String,
      content: map['content'] as String,
      isRead: map['isRead'] as bool,
      createdAt: map['createdAt'] as String,
      fromId: map['fromId'] as String,
      toId: map['toId'] as String,
    );
  }

  NewMessage copyWith({
    String? id,
    String? content,
    bool? isRead,
    String? createdAt,
    String? fromId,
    String? toId,
  }) {
    return NewMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
    );
  }
}
