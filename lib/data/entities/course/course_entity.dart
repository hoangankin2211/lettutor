class CourseEntity {
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

  CourseEntity({
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
    };
  }

  static CourseEntity fromJson(Map<String, dynamic> map) {
    return CourseEntity(
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
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'] as String)
            : null,
        updatedAt:
            map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null);
  }
}
