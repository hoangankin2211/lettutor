import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TutorSearchRequest {
  final int perPage;
  final int page;
  final String search;
  final List<String> specialties;
  final Map<String, dynamic> nationality;
  final List<String> tutoringTimeAvailable;
  final DateTime? date;
  TutorSearchRequest({
    required this.perPage,
    required this.page,
    this.search = "",
    this.specialties = const [],
    this.nationality = const {},
    this.tutoringTimeAvailable = const [],
    this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filters': {
        'date': date != null
            ? DateFormat('E MMM d y HH:mm:ss "GMT"Z (z)').format(date!)
            : null,
        'nationality': nationality,
        'specialties': specialties,
        'tutoringTimeAvailable': tutoringTimeAvailable.isEmpty
            ? [null, null]
            : tutoringTimeAvailable,
      },
      'page': page.toString(),
      'perPage': perPage,
      if (search.isNotEmpty) 'search': search,
    };
  }
}
