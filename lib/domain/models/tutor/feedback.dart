// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/domain/models/tutor/feedback_user_model.dart';

class Feedback {
  final String? id;
  final String? content;
  final double? rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FeedbackUserModel? feedBackUserModel;

  const Feedback({
    this.id,
    this.content,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.feedBackUserModel,
  });

  Feedback copyWith({
    String? id,
    String? content,
    double? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
    FeedbackUserModel? feedBackUserModel,
  }) {
    return Feedback(
      id: id ?? this.id,
      content: content ?? this.content,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      feedBackUserModel: feedBackUserModel ?? this.feedBackUserModel,
    );
  }
}
