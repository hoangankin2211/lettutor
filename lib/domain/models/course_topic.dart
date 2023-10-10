// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourseTopic {
  final String id;
  final String courseId;
  final int? orderCourse;
  final String name;
  final String? beforeTheClassNotes;
  final String? afterTheClassNotes;
  final String? nameFile;
  final int? numberOfPages;
  final String? description;
  final String? videoUrl;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CourseTopic({
    required this.id,
    required this.courseId,
    this.orderCourse,
    required this.name,
    this.beforeTheClassNotes,
    this.afterTheClassNotes,
    this.nameFile,
    this.numberOfPages,
    this.description,
    this.videoUrl,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  CourseTopic copyWith({
    String? id,
    String? courseId,
    int? orderCourse,
    String? name,
    String? beforeTheClassNotes,
    String? afterTheClassNotes,
    String? nameFile,
    int? numberOfPages,
    String? description,
    String? videoUrl,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseTopic(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      orderCourse: orderCourse ?? this.orderCourse,
      name: name ?? this.name,
      beforeTheClassNotes: beforeTheClassNotes ?? this.beforeTheClassNotes,
      afterTheClassNotes: afterTheClassNotes ?? this.afterTheClassNotes,
      nameFile: nameFile ?? this.nameFile,
      numberOfPages: numberOfPages ?? this.numberOfPages,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
