import 'package:lettutor/data/entities/chat/message_entity.dart';

class ChatEntity {
  final int count;
  final List<MessageEntity> rows;
  ChatEntity({
    this.count = 0,
    this.rows = const [],
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'count': count,
      'rows': rows.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatEntity.fromJson(Map<String, dynamic> map) {
    return ChatEntity(
      count: map['count'] as int,
      rows: List<MessageEntity>.from(
        (map['rows'] as List<dynamic>).map<MessageEntity>(
          (x) => MessageEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  ChatEntity copyWith({
    int? count,
    List<MessageEntity>? rows,
  }) {
    return ChatEntity(
      count: count ?? this.count,
      rows: rows ?? this.rows,
    );
  }
}
