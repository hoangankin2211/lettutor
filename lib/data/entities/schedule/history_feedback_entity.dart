class HistoryFeedbackEntity {
  final String id;
  final String bookingId;
  final String firstId;
  final String secondId;
  final int rating;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  HistoryFeedbackEntity({
    required this.id,
    required this.bookingId,
    required this.firstId,
    required this.secondId,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookingId': bookingId,
      'firstId': firstId,
      'secondId': secondId,
      'rating': rating,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory HistoryFeedbackEntity.fromJson(Map<String, dynamic> map) {
    return HistoryFeedbackEntity(
      id: map['id'] as String? ?? "",
      bookingId: map['bookingId'] as String? ?? "",
      firstId: map['firstId'] as String? ?? "",
      secondId: map['secondId'] as String? ?? "",
      rating: map['rating'] as int? ?? 0,
      content: map['content'] as String? ?? "",
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
