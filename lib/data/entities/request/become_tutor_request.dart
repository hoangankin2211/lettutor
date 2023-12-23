import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/src/media_type.dart';

class BecomeTeacherRequest {
  // ... (previous class definition remains the same)
  String name;
  String country;
  DateTime birthday;
  String interests;
  String education;
  String experience;
  String profession;
  List<String> languages;
  String bio;
  String targetStudent;
  List<String> specialties;
  int price;
  String videoIntroduction;
  String avatar;

  BecomeTeacherRequest({
    required this.name,
    required this.country,
    required this.birthday,
    required this.interests,
    required this.education,
    required this.experience,
    required this.profession,
    required this.languages,
    required this.bio,
    required this.targetStudent,
    required this.specialties,
    required this.price,
    required this.videoIntroduction,
    required this.avatar,
  });

  // ... (rest of the class remains the same)

  FormData buildFormData() {
    final formData = FormData();

    // Add text fields
    formData.fields.addAll([
      MapEntry('name', name),
      MapEntry('country', country),
      MapEntry('birthday', birthday.toIso8601String()),
      MapEntry('interests', interests),
      MapEntry('education', education),
      MapEntry('experience', experience),
      MapEntry('profession', profession),
      MapEntry('languages', jsonEncode(languages)),
      MapEntry('bio', bio),
      MapEntry('targetStudent', targetStudent),
      MapEntry('specialties', jsonEncode(specialties)),
      MapEntry('price', price.toString()),
    ]);

    // Add file fields
    if (videoIntroduction.isNotEmpty) {
      formData.files.add(
        MapEntry(
          'video',
          MultipartFile.fromBytes(File(videoIntroduction).readAsBytesSync()),
        ),
      );
    }

    if (avatar.isNotEmpty) {
      formData.files.add(MapEntry(
        'avatar',
        MultipartFile.fromBytes(File(avatar).readAsBytesSync()),
      ));
    }

    return formData;
  }
}
