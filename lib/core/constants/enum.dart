import 'package:lettutor/core/logger/custom_logger.dart';

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
  TOEIC("TOEIC"),
  unknown("");

  final String name;

  static TutorTag fromKey(String key) {
    return TutorTag.values.firstWhere(
      (element) => element.key?.contains(key) ?? false,
      orElse: () => TutorTag.unknown,
    );
  }

  String? get key {
    switch (this) {
      case All:
        return null;
      case Englishforkids:
        return "english-for-kids";
      case EnglishforBusiness:
        return "business-english";
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
      case TutorTag.unknown:
        return TutorTag.unknown.name;
    }
  }

  const TutorTag(this.name);
}

enum Environment { dev, prod }
