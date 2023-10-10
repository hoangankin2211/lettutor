// ignore_for_file: public_member_api_docs, sort_constructors_first
class CoursePreview {
  final String id;
  final String name;
  CoursePreview({
    required this.id,
    required this.name,
  });

  CoursePreview copyWith({
    String? id,
    String? name,
  }) {
    return CoursePreview(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
