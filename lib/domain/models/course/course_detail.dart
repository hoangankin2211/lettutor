import 'course.dart';

class CourseDetail {
  final String id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? level;
  final String? reason;
  final String? purpose;
  final String? otherDetails;
  final int? defaultPrice;
  final int? coursePrice;
  final String? courseType;
  final String? sectionType;
  final bool? visible;
  final int? displayOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CourseTopic>? topics;
  CourseDetail({
    required this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    this.topics,
  });

  CourseDetail copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? level,
    String? reason,
    String? purpose,
    String? otherDetails,
    int? defaultPrice,
    int? coursePrice,
    String? courseType,
    String? sectionType,
    bool? visible,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CourseTopic>? topics,
  }) {
    return CourseDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      level: level ?? this.level,
      reason: reason ?? this.reason,
      purpose: purpose ?? this.purpose,
      otherDetails: otherDetails ?? this.otherDetails,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      coursePrice: coursePrice ?? this.coursePrice,
      courseType: courseType ?? this.courseType,
      sectionType: sectionType ?? this.sectionType,
      visible: visible ?? this.visible,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      topics: topics ?? this.topics,
    );
  }
}
