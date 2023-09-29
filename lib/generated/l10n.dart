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

  /// `Quote Generator`
  String get appTitle {
    return Intl.message(
      'Quote Generator',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navBarHome {
    return Intl.message(
      'Home',
      name: 'navBarHome',
      desc: '',
      args: [],
    );
  }

  /// `Create Quote`
  String get navBarCreateQuote {
    return Intl.message(
      'Create Quote',
      name: 'navBarCreateQuote',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get navBarSearch {
    return Intl.message(
      'Search',
      name: 'navBarSearch',
      desc: '',
      args: [],
    );
  }

  /// `Created by you`
  String get appBarCreateByYou {
    return Intl.message(
      'Created by you',
      name: 'appBarCreateByYou',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get appBarFavorite {
    return Intl.message(
      'Favorites',
      name: 'appBarFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Search Quote`
  String get appBarSearchQuote {
    return Intl.message(
      'Search Quote',
      name: 'appBarSearchQuote',
      desc: '',
      args: [],
    );
  }

  /// `Quote Details`
  String get appBarQuoteDetails {
    return Intl.message(
      'Quote Details',
      name: 'appBarQuoteDetails',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get appBarSettings {
    return Intl.message(
      'Settings',
      name: 'appBarSettings',
      desc: '',
      args: [],
    );
  }

  /// `Delete this quote?`
  String get alertTitle {
    return Intl.message(
      'Delete this quote?',
      name: 'alertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this quote?`
  String get alertContent {
    return Intl.message(
      'Are you sure you want to delete this quote?',
      name: 'alertContent',
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

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `You haven't created any quotes yet`
  String get emptyCardCreatedByYou {
    return Intl.message(
      'You haven\'t created any quotes yet',
      name: 'emptyCardCreatedByYou',
      desc: '',
      args: [],
    );
  }

  /// `You haven't added any quotes to your favorites yet`
  String get emptyCardFavoriteQuote {
    return Intl.message(
      'You haven\'t added any quotes to your favorites yet',
      name: 'emptyCardFavoriteQuote',
      desc: '',
      args: [],
    );
  }

  /// `There is no quote from the server yet!`
  String get emptyCardDiscovery {
    return Intl.message(
      'There is no quote from the server yet!',
      name: 'emptyCardDiscovery',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Quote`
  String get createYourQuote {
    return Intl.message(
      'Create Your Quote',
      name: 'createYourQuote',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Select background color`
  String get backgroundColor {
    return Intl.message(
      'Select background color',
      name: 'backgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Select color shade`
  String get selectColorShade {
    return Intl.message(
      'Select color shade',
      name: 'selectColorShade',
      desc: '',
      args: [],
    );
  }

  /// `Start writing your quote here ...`
  String get writeYourQuoteHere {
    return Intl.message(
      'Start writing your quote here ...',
      name: 'writeYourQuoteHere',
      desc: '',
      args: [],
    );
  }

  /// `Quote author ...`
  String get quoteAuhtor {
    return Intl.message(
      'Quote author ...',
      name: 'quoteAuhtor',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get small {
    return Intl.message(
      'Small',
      name: 'small',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Large`
  String get large {
    return Intl.message(
      'Large',
      name: 'large',
      desc: '',
      args: [],
    );
  }

  /// `Letter spacing`
  String get letterSpacing {
    return Intl.message(
      'Letter spacing',
      name: 'letterSpacing',
      desc: '',
      args: [],
    );
  }

  /// `Font size`
  String get fontSize {
    return Intl.message(
      'Font size',
      name: 'fontSize',
      desc: '',
      args: [],
    );
  }

  /// `Word spacing`
  String get wordSpacing {
    return Intl.message(
      'Word spacing',
      name: 'wordSpacing',
      desc: '',
      args: [],
    );
  }

  /// `Quote created successfully!`
  String get quoteCreatedSuccessfully {
    return Intl.message(
      'Quote created successfully!',
      name: 'quoteCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Quote posted successfully!`
  String get quotePostedSuccessfully {
    return Intl.message(
      'Quote posted successfully!',
      name: 'quotePostedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Quote deleted successfully`
  String get quoteDeletedSuccessfully {
    return Intl.message(
      'Quote deleted successfully',
      name: 'quoteDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Quote removed from favorites successfully`
  String get quoteRemovedFromFav {
    return Intl.message(
      'Quote removed from favorites successfully',
      name: 'quoteRemovedFromFav',
      desc: '',
      args: [],
    );
  }

  /// `Quote added to favorites successfully`
  String get quoteAddedToFav {
    return Intl.message(
      'Quote added to favorites successfully',
      name: 'quoteAddedToFav',
      desc: '',
      args: [],
    );
  }

  /// `Quote must not be empty!`
  String get emptyQuoteAlert {
    return Intl.message(
      'Quote must not be empty!',
      name: 'emptyQuoteAlert',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a quote to save this.`
  String get enterQuoteToSave {
    return Intl.message(
      'Please enter a quote to save this.',
      name: 'enterQuoteToSave',
      desc: '',
      args: [],
    );
  }

  /// `Find a quote here ...`
  String get searchQuoteHintText {
    return Intl.message(
      'Find a quote here ...',
      name: 'searchQuoteHintText',
      desc: '',
      args: [],
    );
  }

  /// `Search for a Quote`
  String get searchQuoteEmptyScreenTitle {
    return Intl.message(
      'Search for a Quote',
      name: 'searchQuoteEmptyScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start typing to see suggestions`
  String get searchQuoteEmptyScreenDescritpion {
    return Intl.message(
      'Start typing to see suggestions',
      name: 'searchQuoteEmptyScreenDescritpion',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkMode {
    return Intl.message(
      'Dark',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightMode {
    return Intl.message(
      'Light',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Photo Saved on Library`
  String get imageSaved {
    return Intl.message(
      'Photo Saved on Library',
      name: 'imageSaved',
      desc: '',
      args: [],
    );
  }

  /// `Oops, Something went wrong!`
  String get somethingWentWrong {
    return Intl.message(
      'Oops, Something went wrong!',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Go to home screen`
  String get goToHome {
    return Intl.message(
      'Go to home screen',
      name: 'goToHome',
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

  /// `quote copied to clipboard`
  String get copiedToClipboard {
    return Intl.message(
      'quote copied to clipboard',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Google`
  String get signInGoogle {
    return Intl.message(
      'Sign In with Google',
      name: 'signInGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Heelo Hoang`
  String get hello {
    return Intl.message(
      'Heelo Hoang',
      name: 'hello',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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
