// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registerBecomeTutorHash() =>
    r'd32678b95a818d4d0c5f122ae1828b67e569be34';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [registerBecomeTutor].
@ProviderFor(registerBecomeTutor)
const registerBecomeTutorProvider = RegisterBecomeTutorFamily();

/// See also [registerBecomeTutor].
class RegisterBecomeTutorFamily
    extends Family<AsyncValue<Either<String, String>>> {
  /// See also [registerBecomeTutor].
  const RegisterBecomeTutorFamily();

  /// See also [registerBecomeTutor].
  RegisterBecomeTutorProvider call({
    required String interest,
    required String education,
    required String experience,
    required String profession,
    required String bio,
    required String language,
  }) {
    return RegisterBecomeTutorProvider(
      interest: interest,
      education: education,
      experience: experience,
      profession: profession,
      bio: bio,
      language: language,
    );
  }

  @override
  RegisterBecomeTutorProvider getProviderOverride(
    covariant RegisterBecomeTutorProvider provider,
  ) {
    return call(
      interest: provider.interest,
      education: provider.education,
      experience: provider.experience,
      profession: provider.profession,
      bio: provider.bio,
      language: provider.language,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'registerBecomeTutorProvider';
}

/// See also [registerBecomeTutor].
class RegisterBecomeTutorProvider
    extends AutoDisposeFutureProvider<Either<String, String>> {
  /// See also [registerBecomeTutor].
  RegisterBecomeTutorProvider({
    required String interest,
    required String education,
    required String experience,
    required String profession,
    required String bio,
    required String language,
  }) : this._internal(
          (ref) => registerBecomeTutor(
            ref as RegisterBecomeTutorRef,
            interest: interest,
            education: education,
            experience: experience,
            profession: profession,
            bio: bio,
            language: language,
          ),
          from: registerBecomeTutorProvider,
          name: r'registerBecomeTutorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerBecomeTutorHash,
          dependencies: RegisterBecomeTutorFamily._dependencies,
          allTransitiveDependencies:
              RegisterBecomeTutorFamily._allTransitiveDependencies,
          interest: interest,
          education: education,
          experience: experience,
          profession: profession,
          bio: bio,
          language: language,
        );

  RegisterBecomeTutorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.interest,
    required this.education,
    required this.experience,
    required this.profession,
    required this.bio,
    required this.language,
  }) : super.internal();

  final String interest;
  final String education;
  final String experience;
  final String profession;
  final String bio;
  final String language;

  @override
  Override overrideWith(
    FutureOr<Either<String, String>> Function(RegisterBecomeTutorRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterBecomeTutorProvider._internal(
        (ref) => create(ref as RegisterBecomeTutorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        interest: interest,
        education: education,
        experience: experience,
        profession: profession,
        bio: bio,
        language: language,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Either<String, String>> createElement() {
    return _RegisterBecomeTutorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterBecomeTutorProvider &&
        other.interest == interest &&
        other.education == education &&
        other.experience == experience &&
        other.profession == profession &&
        other.bio == bio &&
        other.language == language;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, interest.hashCode);
    hash = _SystemHash.combine(hash, education.hashCode);
    hash = _SystemHash.combine(hash, experience.hashCode);
    hash = _SystemHash.combine(hash, profession.hashCode);
    hash = _SystemHash.combine(hash, bio.hashCode);
    hash = _SystemHash.combine(hash, language.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RegisterBecomeTutorRef
    on AutoDisposeFutureProviderRef<Either<String, String>> {
  /// The parameter `interest` of this provider.
  String get interest;

  /// The parameter `education` of this provider.
  String get education;

  /// The parameter `experience` of this provider.
  String get experience;

  /// The parameter `profession` of this provider.
  String get profession;

  /// The parameter `bio` of this provider.
  String get bio;

  /// The parameter `language` of this provider.
  String get language;
}

class _RegisterBecomeTutorProviderElement
    extends AutoDisposeFutureProviderElement<Either<String, String>>
    with RegisterBecomeTutorRef {
  _RegisterBecomeTutorProviderElement(super.provider);

  @override
  String get interest => (origin as RegisterBecomeTutorProvider).interest;
  @override
  String get education => (origin as RegisterBecomeTutorProvider).education;
  @override
  String get experience => (origin as RegisterBecomeTutorProvider).experience;
  @override
  String get profession => (origin as RegisterBecomeTutorProvider).profession;
  @override
  String get bio => (origin as RegisterBecomeTutorProvider).bio;
  @override
  String get language => (origin as RegisterBecomeTutorProvider).language;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
