import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/configuration/configuration.dart';
import 'package:lettutor/core/utils/networking/networking.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/data_source/remote/authentication/email/email_auth_api.dart';
import 'package:lettutor/data/entities/token_entity.dart';
import 'package:lettutor/data/repositories/authentication_repos_impl.dart';
import 'package:lettutor/domain/repositories/authentication_repo.dart';

const keyAuthentication = 'Authorization';
const keyApiKey = 'XApiKey';
const keyBear = 'Bearer';
const keyAcceptLanguage = 'Accept-Language';
const accessTokenKey = "token";

class ApiTokenInterceptor extends Interceptor {
  final AppLocalStorage _appLocalStorage;

  ApiTokenInterceptor(this._appLocalStorage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final tokenMap = _appLocalStorage.getMap(accessTokenKey);

    if (tokenMap?.isNotEmpty ?? false) {
      final TokenEntity tokenEntity =
          TokenEntity.fromJson(tokenMap!.convertMapDynamicToString());

      final accessExpiredTime = DateTime.parse(tokenEntity.access.expires);

      if (accessExpiredTime.isBefore(DateTime.now())) {
        final refreshExpiredTime = DateTime.parse(tokenEntity.refresh.expires);

        if (refreshExpiredTime.isBefore(DateTime.now())) {
          return;
        }
        try {
          final response = await EmailAuthApi(
            NetworkService.initializeDio(
              baseUrl: Configurations.baseUrl,
              haveApiInterceptor: false,
            ),
          ).refreshToken(body: {
            "refreshToken": tokenEntity.refresh.token,
            "timezone": 7,
          });

          await _appLocalStorage.saveMap(
            accessTokenKey,
            response.data.tokens.toMap(),
          );

          options.headers[keyAuthentication] =
              '$keyBear ${response.data.tokens.access.token}';
        } catch (e) {
          handler.reject(DioException(
            requestOptions: options,
            error: e,
          ));
        }
      } else {
        options.headers[keyAuthentication] =
            '$keyBear ${tokenEntity.access.token}';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log('[Dio][ApiTokenInterceptor] error ${err.response}');
    }

    if (err.response?.data['statusCode'] == 401 ||
        401 == err.response?.statusCode) {}

    super.onError(err, handler);
  }
}