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
      'firstInfo': feedBackUserModelEntity?.toMap(),
    };
  }

  factory FeedbackEntity.fromJson(Map<String, dynamic> map) {
    return FeedbackEntity(
      id: map['id'] != null ? map['id'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      rating: map['rating'] != null ? (map['rating'] as int).toDouble() : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      feedBackUserModelEntity: map['firstInfo'] != null
          ? FeedBackUserModelEntity.fromMap(
              map['firstInfo'] as Map<String, dynamic>)
          : null,
    );
  }
}
