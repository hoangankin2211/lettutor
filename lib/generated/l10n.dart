// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Explore further`
  String get discoverMore {
    return Intl.message(
      'Explore further',
      name: 'discoverMore',
      desc: '',
      args: [],
    );
  }

  /// `Organize By`
  String get arrangeBy {
    return Intl.message(
      'Organize By',
      name: 'arrangeBy',
      desc: '',
      args: [],
    );
  }

  /// `Visual presentation`
  String get visuals {
    return Intl.message(
      'Visual presentation',
      name: 'visuals',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get logIn {
    return Intl.message(
      'Sign in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Enroll`
  String get signUp {
    return Intl.message(
      'Enroll',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming course`
  String get upcomingCourse {
    return Intl.message(
      'Upcoming course',
      name: 'upcomingCourse',
      desc: '',
      args: [],
    );
  }

  /// `Recommend Course`
  String get recommendCourse {
    return Intl.message(
      'Recommend Course',
      name: 'recommendCourse',
      desc: '',
      args: [],
    );
  }

  /// `Meeting options`
  String get meetingSettings {
    return Intl.message(
      'Meeting options',
      name: 'meetingSettings',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Skill level`
  String get expertiseLevel {
    return Intl.message(
      'Skill level',
      name: 'expertiseLevel',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get Intermediate {
    return Intl.message(
      'Intermediate',
      name: 'Intermediate',
      desc: '',
      args: [],
    );
  }

  /// `Subjects`
  String get subjects {
    return Intl.message(
      'Subjects',
      name: 'subjects',
      desc: '',
      args: [],
    );
  }

  /// `Join gathering`
  String get joinMeeting {
    return Intl.message(
      'Join gathering',
      name: 'joinMeeting',
      desc: '',
      args: [],
    );
  }

  /// `milliseconds`
  String get milliseconds {
    return Intl.message(
      'milliseconds',
      name: 'milliseconds',
      desc: '',
      args: [],
    );
  }

  /// `OverView`
  String get OverView {
    return Intl.message(
      'OverView',
      name: 'OverView',
      desc: '',
      args: [],
    );
  }

  /// `Total sessions count is`
  String get totalSessionsCountIs {
    return Intl.message(
      'Total sessions count is',
      name: 'totalSessionsCountIs',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Refresh Token has expired`
  String get refreshTokenExpired {
    return Intl.message(
      'Refresh Token has expired',
      name: 'refreshTokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `No pdf found`
  String get noPdfFound {
    return Intl.message(
      'No pdf found',
      name: 'noPdfFound',
      desc: '',
      args: [],
    );
  }

  /// `Can not open this tutor profile detail`
  String get notOpenTutorProfile {
    return Intl.message(
      'Can not open this tutor profile detail',
      name: 'notOpenTutorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Why select this course?`
  String get whyChooseThisCourse {
    return Intl.message(
      'Why select this course?',
      name: 'whyChooseThisCourse',
      desc: '',
      args: [],
    );
  }

  /// `What will you accomplish?`
  String get whatWillYouAchieve {
    return Intl.message(
      'What will you accomplish?',
      name: 'whatWillYouAchieve',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to `
  String get welcomeTo {
    return Intl.message(
      'Welcome to ',
      name: 'welcomeTo',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Apple`
  String get signInApple {
    return Intl.message(
      'Sign in with Apple',
      name: 'signInApple',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get signInFace {
    return Intl.message(
      'Sign in with Facebook',
      name: 'signInFace',
      desc: '',
      args: [],
    );
  }

  /// `List Topics`
  String get listTopic {
    return Intl.message(
      'List Topics',
      name: 'listTopic',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Password`
  String get enterPassword {
    return Intl.message(
      'Enter your Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Learn Now`
  String get learnNow {
    return Intl.message(
      'Learn Now',
      name: 'learnNow',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours`
  String get scheduleScreenTitle {
    return Intl.message(
      'Here is a list of the sessions you have booked\nYou can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours',
      name: 'scheduleScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Account ? `
  String get noAccount {
    return Intl.message(
      'No Account ? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Course Length`
  String get courseLength {
    return Intl.message(
      'Course Length',
      name: 'courseLength',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username or email address`
  String get usernameEmail {
    return Intl.message(
      'Username or email address',
      name: 'usernameEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get passwordCharactersLong {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'passwordCharactersLong',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get yourPassword {
    return Intl.message(
      'Your password',
      name: 'yourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get pleaseEnterAddress {
    return Intl.message(
      'Please enter a valid email address',
      name: 'pleaseEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your Educator profile is your opportunity to present yourself to students on Tutoring`
  String get yourEducatorProfile {
    return Intl.message(
      'Your Educator profile is your opportunity to present yourself to students on Tutoring',
      name: 'yourEducatorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Provide your vocations`
  String get ProvideYourOccupations {
    return Intl.message(
      'Provide your vocations',
      name: 'ProvideYourOccupations',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username or email address`
  String get entUsernameEmail {
    return Intl.message(
      'Enter your username or email address',
      name: 'entUsernameEmail',
      desc: '',
      args: [],
    );
  }

  /// `Students will assess this data on your profile to determine if you're a suitable match for them`
  String get studentsWillReviewThisData {
    return Intl.message(
      'Students will assess this data on your profile to determine if you\'re a suitable match for them',
      name: 'studentsWillReviewThisData',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get seeMore {
    return Intl.message(
      'See More',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get currencies {
    return Intl.message(
      'Currencies',
      name: 'currencies',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Code and Fingerprint`
  String get codeAndFingerPrints {
    return Intl.message(
      'Code and Fingerprint',
      name: 'codeAndFingerPrints',
      desc: '',
      args: [],
    );
  }

  /// `Lock and Security`
  String get lockAndSecurity {
    return Intl.message(
      'Lock and Security',
      name: 'lockAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `General Settings`
  String get generalSettings {
    return Intl.message(
      'General Settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `Sort By Price`
  String get byPrice {
    return Intl.message(
      'Sort By Price',
      name: 'byPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code`
  String get enterCode {
    return Intl.message(
      'Enter Code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Error Code`
  String get errorCode {
    return Intl.message(
      'Error Code',
      name: 'errorCode',
      desc: '',
      args: [],
    );
  }

  /// `Become a Tutor`
  String get becomeTutor {
    return Intl.message(
      'Become a Tutor',
      name: 'becomeTutor',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up to Use LetTutor`
  String get signUpToUse {
    return Intl.message(
      'Sign Up to Use LetTutor',
      name: 'signUpToUse',
      desc: '',
      args: [],
    );
  }

  /// `Register an Account to Access All LetTutor Features`
  String get registerAccountToUse {
    return Intl.message(
      'Register an Account to Access All LetTutor Features',
      name: 'registerAccountToUse',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Register Account`
  String get registerAccount {
    return Intl.message(
      'Register Account',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email Address to Find Your Account`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please Enter Your Email Address to Find Your Account',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Say Hello to Your English Tutors`
  String get sayHelloToYour {
    return Intl.message(
      'Say Hello to Your English Tutors',
      name: 'sayHelloToYour',
      desc: '',
      args: [],
    );
  }

  /// `Become Fluent Faster Through Personalized One-on-One Video Chat Lessons`
  String get beComeFluent {
    return Intl.message(
      'Become Fluent Faster Through Personalized One-on-One Video Chat Lessons',
      name: 'beComeFluent',
      desc: '',
      args: [],
    );
  }

  /// `Or Continue With`
  String get orContinue {
    return Intl.message(
      'Or Continue With',
      name: 'orContinue',
      desc: '',
      args: [],
    );
  }

  /// `Registering`
  String get registering {
    return Intl.message(
      'Registering',
      name: 'registering',
      desc: '',
      args: [],
    );
  }

  /// `Tutor Registration`
  String get tutorRegister {
    return Intl.message(
      'Tutor Registration',
      name: 'tutorRegister',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get introduction {
    return Intl.message(
      'Introduction',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `My Spoken Language`
  String get language {
    return Intl.message(
      'My Spoken Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Whom I Teach`
  String get whoITeach {
    return Intl.message(
      'Whom I Teach',
      name: 'whoITeach',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Interests`
  String get enterYourInterests {
    return Intl.message(
      'Enter Your Interests',
      name: 'enterYourInterests',
      desc: '',
      args: [],
    );
  }

  /// `Experiences`
  String get experiences {
    return Intl.message(
      'Experiences',
      name: 'experiences',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Experiences`
  String get enterYourExperiences {
    return Intl.message(
      'Enter Your Experiences',
      name: 'enterYourExperiences',
      desc: '',
      args: [],
    );
  }

  /// `Professions`
  String get professions {
    return Intl.message(
      'Professions',
      name: 'professions',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basicInfo {
    return Intl.message(
      'Basic Information',
      name: 'basicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get bio {
    return Intl.message(
      'Biography',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Report Tutor`
  String get reportTutor {
    return Intl.message(
      'Report Tutor',
      name: 'reportTutor',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Add Report Content`
  String get addReportContent {
    return Intl.message(
      'Add Report Content',
      name: 'addReportContent',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get addReview {
    return Intl.message(
      'Add Review',
      name: 'addReview',
      desc: '',
      args: [],
    );
  }

  /// `Your Review`
  String get yourReview {
    return Intl.message(
      'Your Review',
      name: 'yourReview',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Write Your Review...`
  String get writeYourReview {
    return Intl.message(
      'Write Your Review...',
      name: 'writeYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rateStar {
    return Intl.message(
      'Rate',
      name: 'rateStar',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Find Tutors`
  String get tutorSearch {
    return Intl.message(
      'Find Tutors',
      name: 'tutorSearch',
      desc: '',
      args: [],
    );
  }

  /// `Search Here`
  String get searchHere {
    return Intl.message(
      'Search Here',
      name: 'searchHere',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get nationality {
    return Intl.message(
      'Nationality',
      name: 'nationality',
      desc: '',
      args: [],
    );
  }

  /// `All E-Books`
  String get allEBooks {
    return Intl.message(
      'All E-Books',
      name: 'allEBooks',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get startTime {
    return Intl.message(
      'Start Time',
      name: 'startTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get endTime {
    return Intl.message(
      'End Time',
      name: 'endTime',
      desc: '',
      args: [],
    );
  }

  /// `Profile Preview`
  String get profilePreview {
    return Intl.message(
      'Profile Preview',
      name: 'profilePreview',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Courses`
  String get courses {
    return Intl.message(
      'Courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `Experience Level`
  String get experienceLevel {
    return Intl.message(
      'Experience Level',
      name: 'experienceLevel',
      desc: '',
      args: [],
    );
  }

  /// `Test`
  String get test {
    return Intl.message(
      'Test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Search Tutor Results`
  String get searchTutorResult {
    return Intl.message(
      'Search Tutor Results',
      name: 'searchTutorResult',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upComing {
    return Intl.message(
      'Upcoming',
      name: 'upComing',
      desc: '',
      args: [],
    );
  }

  /// `Book Tutor`
  String get bookTutor {
    return Intl.message(
      'Book Tutor',
      name: 'bookTutor',
      desc: '',
      args: [],
    );
  }

  /// `Tutor Details`
  String get tutorDetail {
    return Intl.message(
      'Tutor Details',
      name: 'tutorDetail',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch url `
  String get couldNotLaunchUrl {
    return Intl.message(
      'Could not launch url ',
      name: 'couldNotLaunchUrl',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get isFavorite {
    return Intl.message(
      'Favorite',
      name: 'isFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Education`
  String get enterEducation {
    return Intl.message(
      'Enter Your Education',
      name: 'enterEducation',
      desc: '',
      args: [],
    );
  }

  /// `Specialties`
  String get specialties {
    return Intl.message(
      'Specialties',
      name: 'specialties',
      desc: '',
      args: [],
    );
  }

  /// `Suggested Courses`
  String get suggestedCourses {
    return Intl.message(
      'Suggested Courses',
      name: 'suggestedCourses',
      desc: '',
      args: [],
    );
  }

  /// `Levels`
  String get level {
    return Intl.message(
      'Levels',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Profile Setting`
  String get profileSetting {
    return Intl.message(
      'Profile Setting',
      name: 'profileSetting',
      desc: '',
      args: [],
    );
  }

  /// `Go to meeting`
  String get goToMeeting {
    return Intl.message(
      'Go to meeting',
      name: 'goToMeeting',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterYourName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `No review yet`
  String get noReviewYet {
    return Intl.message(
      'No review yet',
      name: 'noReviewYet',
      desc: '',
      args: [],
    );
  }

  /// `Other Settings`
  String get otherSetting {
    return Intl.message(
      'Other Settings',
      name: 'otherSetting',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Your total lesson time is`
  String get yourTotalLessonTime {
    return Intl.message(
      'Your total lesson time is',
      name: 'yourTotalLessonTime',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book {
    return Intl.message(
      'Book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `Your next class will begin in`
  String get nextClassWillBeginIn {
    return Intl.message(
      'Your next class will begin in',
      name: 'nextClassWillBeginIn',
      desc: '',
      args: [],
    );
  }

  /// `You have no upcoming lesson`
  String get noUpcomingLesson {
    return Intl.message(
      'You have no upcoming lesson',
      name: 'noUpcomingLesson',
      desc: '',
      args: [],
    );
  }

  /// `English Teacher`
  String get englishTeacher {
    return Intl.message(
      'English Teacher',
      name: 'englishTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get Hello {
    return Intl.message(
      'Hello',
      name: 'Hello',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get play {
    return Intl.message(
      'Play',
      name: 'play',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthDay {
    return Intl.message(
      'Birthday',
      name: 'birthDay',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Lesson`
  String get upcomingLesson {
    return Intl.message(
      'Upcoming Lesson',
      name: 'upcomingLesson',
      desc: '',
      args: [],
    );
  }

  /// `Find A Tutor`
  String get findATutor {
    return Intl.message(
      'Find A Tutor',
      name: 'findATutor',
      desc: '',
      args: [],
    );
  }

  /// `Other Reviews`
  String get otherReview {
    return Intl.message(
      'Other Reviews',
      name: 'otherReview',
      desc: '',
      args: [],
    );
  }

  /// `There is not any comment ! Be the first comment on this tutor`
  String get noComment {
    return Intl.message(
      'There is not any comment ! Be the first comment on this tutor',
      name: 'noComment',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get userInformation {
    return Intl.message(
      'User Information',
      name: 'userInformation',
      desc: '',
      args: [],
    );
  }

  /// `Tutor Free Booking Time`
  String get tutorFreeBookingTime {
    return Intl.message(
      'Tutor Free Booking Time',
      name: 'tutorFreeBookingTime',
      desc: '',
      args: [],
    );
  }

  /// `Study Schedule`
  String get studySchedule {
    return Intl.message(
      'Study Schedule',
      name: 'studySchedule',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Don't have any schedule booking in this date range`
  String get emptyAlert {
    return Intl.message(
      'Don\'t have any schedule booking in this date range',
      name: 'emptyAlert',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Study Schedule`
  String get enterStudySchedule {
    return Intl.message(
      'Enter Your Study Schedule',
      name: 'enterStudySchedule',
      desc: '',
      args: [],
    );
  }

  /// `User Levels`
  String get userLevels {
    return Intl.message(
      'User Levels',
      name: 'userLevels',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Topics and Preparations`
  String get topicsAndPreparations {
    return Intl.message(
      'Topics and Preparations',
      name: 'topicsAndPreparations',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateProfile {
    return Intl.message(
      'Update Profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Add a Rating`
  String get addRating {
    return Intl.message(
      'Add a Rating',
      name: 'addRating',
      desc: '',
      args: [],
    );
  }

  /// `Lesson Time`
  String get lessonTime {
    return Intl.message(
      'Lesson Time',
      name: 'lessonTime',
      desc: '',
      args: [],
    );
  }

  /// `Total Lesson Time is`
  String get totalLessonsTimesIs {
    return Intl.message(
      'Total Lesson Time is',
      name: 'totalLessonsTimesIs',
      desc: '',
      args: [],
    );
  }

  /// `No Upcoming Classes`
  String get donHaveAnyUpcoming {
    return Intl.message(
      'No Upcoming Classes',
      name: 'donHaveAnyUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Tutor`
  String get tutor {
    return Intl.message(
      'Tutor',
      name: 'tutor',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get showMore {
    return Intl.message(
      'Show More',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese Tutor`
  String get vietnameseTutor {
    return Intl.message(
      'Vietnamese Tutor',
      name: 'vietnameseTutor',
      desc: '',
      args: [],
    );
  }

  /// `Select Available tutoring time`
  String get selectAvailableTutoringTime {
    return Intl.message(
      'Select Available tutoring time',
      name: 'selectAvailableTutoringTime',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `PDF Viewer`
  String get pdfViewer {
    return Intl.message(
      'PDF Viewer',
      name: 'pdfViewer',
      desc: '',
      args: [],
    );
  }

  /// `Request For Lesson`
  String get requestForLesson {
    return Intl.message(
      'Request For Lesson',
      name: 'requestForLesson',
      desc: '',
      args: [],
    );
  }

  /// `Tutor Schedule`
  String get tutorSchedule {
    return Intl.message(
      'Tutor Schedule',
      name: 'tutorSchedule',
      desc: '',
      args: [],
    );
  }

  /// `The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended`
  String get historyScreen {
    return Intl.message(
      'The following is a list of lessons you have attended\nYou can review the details of the lessons you have attended',
      name: 'historyScreen',
      desc: '',
      args: [],
    );
  }

  /// `Select your tutor's national`
  String get selectTutorNational {
    return Intl.message(
      'Select your tutor\'s national',
      name: 'selectTutorNational',
      desc: '',
      args: [],
    );
  }

  /// `Currently there are no requests for this class. Please write down any requests for the teacher.`
  String get noRequest {
    return Intl.message(
      'Currently there are no requests for this class. Please write down any requests for the teacher.',
      name: 'noRequest',
      desc: '',
      args: [],
    );
  }

  /// `Created At`
  String get createdAt {
    return Intl.message(
      'Created At',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Recommend Tutor`
  String get recommendTutor {
    return Intl.message(
      'Recommend Tutor',
      name: 'recommendTutor',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Teachers`
  String get Teachers {
    return Intl.message(
      'Teachers',
      name: 'Teachers',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get Schedule {
    return Intl.message(
      'Schedule',
      name: 'Schedule',
      desc: '',
      args: [],
    );
  }

  /// `Native English Tutor`
  String get nativeEnglishTutor {
    return Intl.message(
      'Native English Tutor',
      name: 'nativeEnglishTutor',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Select Start Time`
  String get selectStartTime {
    return Intl.message(
      'Select Start Time',
      name: 'selectStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Select Tutor Tags`
  String get selectTutorTag {
    return Intl.message(
      'Select Tutor Tags',
      name: 'selectTutorTag',
      desc: '',
      args: [],
    );
  }

  /// `Select End Time`
  String get selectEndTime {
    return Intl.message(
      'Select End Time',
      name: 'selectEndTime',
      desc: '',
      args: [],
    );
  }

  /// `Updated At`
  String get updatedAt {
    return Intl.message(
      'Updated At',
      name: 'updatedAt',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `All Topics`
  String get allTopics {
    return Intl.message(
      'All Topics',
      name: 'allTopics',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Biography`
  String get enterYourBio {
    return Intl.message(
      'Enter Your Biography',
      name: 'enterYourBio',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Select Avatar`
  String get tapToSelectedAvatar {
    return Intl.message(
      'Tap to Select Avatar',
      name: 'tapToSelectedAvatar',
      desc: '',
      args: [],
    );
  }

  /// `Your Tutor Profile Is Your Opportunity to Present Yourself to Students on Tutoring`
  String get yourTutorProfile {
    return Intl.message(
      'Your Tutor Profile Is Your Opportunity to Present Yourself to Students on Tutoring',
      name: 'yourTutorProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Professions`
  String get EnterYourProfessions {
    return Intl.message(
      'Enter Your Professions',
      name: 'EnterYourProfessions',
      desc: '',
      args: [],
    );
  }

  /// `Students Will Consider This Information on Your Profile to Determine If You're a Suitable Match for Them`
  String get studentsWillViewThisInformation {
    return Intl.message(
      'Students Will Consider This Information on Your Profile to Determine If You\'re a Suitable Match for Them',
      name: 'studentsWillViewThisInformation',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  static List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
