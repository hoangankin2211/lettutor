import '../feedback/feedback_entity.dart';

class FeedbackResponse {
  final String status;
  final int count;
  final List<FeedbackEntity> reviews;
  FeedbackResponse(this.status, this.count, this.reviews);

  factory FeedbackResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return FeedbackResponse('Error', 0, List.empty());
    return FeedbackResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => FeedbackEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
