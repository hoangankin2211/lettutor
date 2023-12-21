import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TutorSearchRequest {
  final int perPage;
  final int page;
  final String search;
  final List<String> specialties;
  final Map<String, dynamic> nationality;
  final List<int> tutoringTimeAvailable;
  final DateTime? date;
  const TutorSearchRequest({
    this.perPage = 12,
    this.page = 1,
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
            ? "${DateFormat('E MMM d y HH:mm:ss').format(date!)} GMT+0700 (Indochina Time)"
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
