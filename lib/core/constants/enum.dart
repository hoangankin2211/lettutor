enum National {
  vietnam,
  england,
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

  const TutorTag(this.name);
}

enum Environment { dev, prod }
