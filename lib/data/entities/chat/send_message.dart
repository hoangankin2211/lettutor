// ignore_for_file: public_member_api_docs, sort_constructors_first
class SendMessage {
  final String content;
  final String fromId;
  final String toId;
  SendMessage({
    required this.content,
    required this.fromId,
    required this.toId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'fromId': fromId,
      'toId': toId,
    };
  }

  factory SendMessage.fromJson(Map<String, dynamic> map) {
    return SendMessage(
      content: map['content'] as String,
      fromId: map['fromId'] as String,
      toId: map['toId'] as String,
    );
  }

  SendMessage copyWith({
    String? content,
    String? fromId,
    String? toId,
  }) {
    return SendMessage(
      content: content ?? this.content,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
    );
  }
}
