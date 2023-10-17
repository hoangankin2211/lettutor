// ignore_for_file: public_member_api_docs, sort_constructors_first
class FeedbackUserModel {
  final String? name;
  final String? avatar;
  FeedbackUserModel({
    this.name,
    this.avatar,
  });

  FeedbackUserModel copyWith({
    String? name,
    String? avatar,
  }) {
    return FeedbackUserModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
