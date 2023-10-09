// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/authentication/authentication.dart';
import 'package:lettutor/domain/models/user.dart';

import '../../domain/repositories/repositories.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _authenticationApi;
  AuthenticationRepositoryImpl(@Named("EmailAuthApi") this._authenticationApi);

  @override
  Future<User> getCurrentUser() {
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    final authResponse = await _authenticationApi.signIn(body: {
      'email': email,
      'password': password,
    });
    // return User(
    //   id: authResponse.data!.user.id,
    //   email: authResponse.data!.user.email,
    //   name: authResponse.data!.user.name,
    //   avatar: authResponse.data!.user.avatar,
    //   country: authResponse.data!.user.country,
    //   phone: authResponse.data!.user.phone,
    //   roles: authResponse.data!.user.roles,
    //   language: authResponse.data!.user.language,
    //   birthday: authResponse.data!.user.birthday,
    //   isActivated: authResponse.data!.user.isActivated,
    //   courses: authResponse.data!.user.courses,
    //   requireNote: authResponse.data!.user.requireNote,
    //   level: authResponse.data!.user.level,
    //   learnTopics: authResponse.data!.user.learnTopics,
    //   isPhoneActivated: authResponse.data!.user.isPhoneActivated,
    //   timezone: authResponse.data!.user.timezone,
    //   studySchedule: authResponse.data!.user.studySchedule,
    //   canSendMessage: authResponse.data!.user.canSendMessage,
    // );
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
