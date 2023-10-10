import 'dart:math';

import 'package:lettutor/data/entities/course/course_category_entity.dart';
import 'package:lettutor/data/entities/course/course_detail_entity.dart';
import 'package:lettutor/data/entities/course/course_topic_entity.dart';
import 'package:lettutor/domain/models/course_category.dart';
import 'package:lettutor/domain/models/course_detail.dart';
import 'package:lettutor/domain/models/course_topic.dart';

import '../../data/entities/course/course_entity.dart';

class CourseMapper {
  static CourseCategory courseCategoryFromEntity(CourseCategoryEntity entity) {
    return CourseCategory(
      id: entity.id,
      displayOrder: entity.displayOrder,
      title: entity.title,
      description: entity.description,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static CourseDetail courseEntityFromEntity(CourseEntity entity) {
    return CourseDetail(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      level: entity.level,
      reason: entity.reason,
      purpose: entity.purpose,
      otherDetails: entity.otherDetails,
      defaultPrice: entity.defaultPrice,
      coursePrice: entity.coursePrice,
      courseType: entity.courseType,
      sectionType: entity.sectionType,
      visible: entity.visible,
      displayOrder: entity.displayOrder,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      topics: null,
    );
  }

  static CourseDetail courseDetailEntityFromEntity(CourseDetailEntity entity) {
    return CourseDetail(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      level: entity.level,
      reason: entity.reason,
      purpose: entity.purpose,
      otherDetails: entity.otherDetails,
      defaultPrice: entity.defaultPrice,
      coursePrice: entity.coursePrice,
      courseType: entity.courseType,
      sectionType: entity.sectionType,
      visible: entity.visible,
      displayOrder: entity.displayOrder,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      topics: entity.topics?.map(courseTopicFromEntity).toList(),
    );
  }

  static CourseTopic courseTopicFromEntity(CourseTopicEntity entity) {
    return CourseTopic(
      id: entity.id,
      courseId: entity.courseId,
      orderCourse: entity.orderCourse,
      name: entity.name,
      beforeTheClassNotes: entity.beforeTheClassNotes,
      afterTheClassNotes: entity.afterTheClassNotes,
      nameFile: entity.nameFile,
      numberOfPages: entity.numberOfPages,
      description: entity.description,
      videoUrl: entity.videoUrl,
      type: entity.type,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
