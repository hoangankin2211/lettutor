import 'package:lettutor/domain/models/tutor/tutor.dart';

enum National {
  vietnam,
  native,
  foreign,
}

enum TutorTag {
  All("All"),
  Englishforkids("English for kids"),
  EnglishforBusiness('English for Business'),
  Conversational("Conversational"),
  STARTERS("STARTERS"),
  MOVERS("MOVERS"),
  FLYERS("FLYERS"),
  KET("KET"),
  PET("PET"),
  IELTS("IELTS"),
  TOEFL("TOEFL"),
  TOEIC("TOEIC");

  final String name;

  static TutorTag fromKey(String key) => TutorTag.values.firstWhere(
        (element) => element.key == key,
        orElse: () => All,
      );

  String? get key {
    switch (this) {
      case All:
        return null;
      case Englishforkids:
        return "english_for_kids";
      case EnglishforBusiness:
        return "business_english";
      case Conversational:
        return "conversational-english";
      case STARTERS:
        return "starters";

      case MOVERS:
        return "movers";
      case FLYERS:
        return "flyers";
      case KET:
        return "ket";
      case PET:
        return "pet";
      case IELTS:
        return "ielts";
      case TOEFL:
        return "toefl";

      case TOEIC:
        return "toeic";
    }
  }

  const TutorTag(this.name);
}

enum Environment { dev, prod }
