import 'course_topic_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CourseDetailEntity {
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
  final List<CourseTopicEntity>? topics;

  CourseDetailEntity({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'level': level,
      'reason': reason,
      'purpose': purpose,
      'otherDetails': otherDetails,
      'defaultPrice': defaultPrice,
      'coursePrice': coursePrice,
      'courseType': courseType,
      'sectionType': sectionType,
      'visible': visible,
      'displayOrder': displayOrder,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'topics': topics?.map((x) => x.toMap()).toList(),
    };
  }

  static CourseDetailEntity fromJson(Map<String, dynamic> map) {
    return CourseDetailEntity(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      level: map['level'] != null ? map['level'] as String : null,
      reason: map['reason'] != null ? map['reason'] as String : null,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      otherDetails:
          map['otherDetails'] != null ? map['otherDetails'] as String : null,
      defaultPrice:
          map['defaultPrice'] != null ? map['defaultPrice'] as int : null,
      coursePrice:
          map['coursePrice'] != null ? map['coursePrice'] as int : null,
      courseType:
          map['courseType'] != null ? map['courseType'] as String : null,
      sectionType:
          map['sectionType'] != null ? map['sectionType'] as String : null,
      visible: map['visible'] != null ? map['visible'] as bool : null,
      displayOrder:
          map['displayOrder'] != null ? map['displayOrder'] as int : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      topics: map['topics'] != null
          ? List<CourseTopicEntity>.from(
              (map['topics'] as List<dynamic>).map<CourseTopicEntity?>(
                (x) => CourseTopicEntity.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
