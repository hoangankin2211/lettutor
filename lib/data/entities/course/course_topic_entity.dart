class CourseTopicEntity {
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
  CourseTopicEntity({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'courseId': courseId,
      'orderCourse': orderCourse,
      'name': name,
      'beforeTheClassNotes': beforeTheClassNotes,
      'afterTheClassNotes': afterTheClassNotes,
      'nameFile': nameFile,
      'numberOfPages': numberOfPages,
      'description': description,
      'videoUrl': videoUrl,
      'type': type,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CourseTopicEntity.fromJson(Map<String, dynamic> map) {
    return CourseTopicEntity(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      orderCourse:
          map['orderCourse'] != null ? map['orderCourse'] as int : null,
      name: map['name'] as String,
      beforeTheClassNotes: map['beforeTheClassNotes'] != null
          ? map['beforeTheClassNotes'] as String
          : null,
      afterTheClassNotes: map['afterTheClassNotes'] != null
          ? map['afterTheClassNotes'] as String
          : null,
      nameFile: map['nameFile'] != null ? map['nameFile'] as String : null,
      numberOfPages:
          map['numberOfPages'] != null ? map['numberOfPages'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }
}
