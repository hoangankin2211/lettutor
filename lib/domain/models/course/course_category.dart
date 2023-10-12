// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourseCategory {
  final String id;
  final String? title;
  final String? description;
  final String? key;
  final int? displayOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CourseCategory({
    required this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  CourseCategory copyWith({
    String? id,
    String? title,
    String? description,
    String? key,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      key: key ?? this.key,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
