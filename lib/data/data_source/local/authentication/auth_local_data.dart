import 'package:injectable/injectable.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/entities/token_entity.dart';

@injectable
class AuthLocalData {
  final AppLocalStorage _appLocalStorage;
  const AuthLocalData(this._appLocalStorage);

  Future<void> setToken(String token) async {
    await _appLocalStorage.saveString('token', token);
  }

  Future<TokenEntity> getToken() async {
    final tokenMap = _appLocalStorage.getMap(accessTokenKey);

    if (tokenMap?.isNotEmpty ?? false) {
      try {
        final TokenEntity tokenEntity =
            TokenEntity.fromJson(tokenMap!.convertMapDynamicToString());
        return tokenEntity;
      } catch (e) {
        throw Exception('Cannot parse token');
      }
    } else {
      throw Exception('Token is invalid');
    }
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
