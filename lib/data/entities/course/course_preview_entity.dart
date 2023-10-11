class CoursePreviewEntity {
  final String id;
  final String name;
  CoursePreviewEntity({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CoursePreviewEntity.fromJson(Map<String, dynamic> map) {
    return CoursePreviewEntity(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
