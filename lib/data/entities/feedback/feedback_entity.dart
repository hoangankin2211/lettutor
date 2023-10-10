// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'feedback_user_model_entity.dart';

class FeedbackEntity {
  final String? id;

  final String? content;

  final double? rating;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final FeedBackUserModelEntity? feedBackUserModelEntity;
  FeedbackEntity({
    this.id,
    this.content,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.feedBackUserModelEntity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'rating': rating,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'feedBackUserModelEntity': feedBackUserModelEntity?.toMap(),
    };
  }

  factory FeedbackEntity.fromMap(Map<String, dynamic> map) {
    return FeedbackEntity(
      id: map['id'] != null ? map['id'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      rating: map['rating'] != null ? map['rating'] as double : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      feedBackUserModelEntity: map['feedBackUserModelEntity'] != null
          ? FeedBackUserModelEntity.fromMap(
              map['feedBackUserModelEntity'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackEntity.fromJson(String source) =>
      FeedbackEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
