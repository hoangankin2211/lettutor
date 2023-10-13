class CourseCategoryEntity {
  final String id;
  final String? title;
  final String? description;
  final String? key;
  final int? displayOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CourseCategoryEntity({
    required this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'key': key,
      'displayOrder': displayOrder,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CourseCategoryEntity.fromJson(Map<String, dynamic> map) {
    return CourseCategoryEntity(
      id: map['id'] as String,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      key: map['key'] != null ? map['key'] as String : null,
      displayOrder:
          map['displayOrder'] != null ? map['displayOrder'] as int : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
