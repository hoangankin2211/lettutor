import 'package:lettutor/data/entities/course/course_category_entity.dart';

class EBookEntity {
  final String id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? level;
  final bool? visible;
  final String? fileUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<CourseCategoryEntity>? categories;

  EBookEntity({
    required this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.visible,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
    this.categories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'level': level,
      'visible': visible,
      'fileUrl': fileUrl,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'categories': categories?.map((x) => x.toMap()).toList(),
    };
  }

  static EBookEntity fromJson(Map<String, dynamic> map) {
    return EBookEntity(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      level: map['level'] != null ? map['level'] as String : null,
      visible: map['visible'] != null ? map['visible'] as bool : null,
      fileUrl: map['fileUrl'] != null ? map['fileUrl'] as String : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      categories: map['categories'] != null
          ? List<CourseCategoryEntity>.from(
              (map['categories'] as List<dynamic>).map<CourseCategoryEntity?>(
                (x) => CourseCategoryEntity.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
