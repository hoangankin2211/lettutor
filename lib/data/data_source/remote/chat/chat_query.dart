import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatQuery {
  final int? startTime;
  final int page;
  final int perPage;
  const ChatQuery({
    this.startTime,
    this.page = 1,
    this.perPage = 15,
  });

  ChatQuery copyWith({
    int? startTime,
    int? page,
    int? perPage,
  }) {
    return ChatQuery(
      startTime: startTime ?? this.startTime,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'startTime': startTime ?? DateTime.now().millisecondsSinceEpoch,
      'page': page,
      'perPage': perPage,
    };
  }

  factory ChatQuery.fromJson(Map<String, dynamic> map) {
    return ChatQuery(
      startTime: map['startTime'] as int,
      page: map['page'] as int,
      perPage: map['perPage'] as int,
    );
  }
}
