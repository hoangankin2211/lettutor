import 'dart:convert';

import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/entities/user_entity.dart';

class AuthLocalData {
  final AppLocalStorage _appLocalStorage;
  const AuthLocalData(this._appLocalStorage);

  Future<void> setToken(String token) async {
    await _appLocalStorage.saveString('token', token);
  }

  Future<String?> getToken() async {
    return _appLocalStorage.getString('token');
  }

  Future<void> deleteToken() async {
    await _appLocalStorage.remove('token');
  }

  Future<void> setRefreshToken(String token) async {
    await _appLocalStorage.saveString('refreshToken', token);
  }

  Future<String?> getRefreshToken() async {
    return _appLocalStorage.getString('refreshToken');
  }

  Future<void> deleteRefreshToken() async {
    await _appLocalStorage.remove('refreshToken');
  }

  // Future<UserEntity?> getLocalUserEntity() async {
  //   final userEntity = _appLocalStorage.getString('userEntity');
  //   if (userEntity == null) {
  //     return null;
  //   }
  //   return UserEntity.fromJson(userEntity);
  // }

  // Future<void> setLocalUserEntity(UserEntity userEntity) async {
  //   await _appLocalStorage.saveString(
  //       'userEntity', jsonEncode(userEntity.toJson()));
  // }
}
