import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/data/entities/token_entity.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

const keyAuthentication = 'Authorization';
const keyApiKey = 'XApiKey';
const keyBear = 'Bearer';
const keyAcceptLanguage = 'Accept-Language';
const accessTokenKey = "token";

class ApiTokenInterceptor extends Interceptor {
  final AppLocalStorage _appLocalStorage;

  ApiTokenInterceptor(this._appLocalStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final tokenMap =
        _appLocalStorage.getMap(accessTokenKey) as Map<String, dynamic>?;

    if (tokenMap?.isNotEmpty ?? false) {
      final TokenEntity tokenEntity = TokenEntity.fromJson(tokenMap!);

      final accessExpiredTime = DateTime.parse(tokenEntity.access.expires);

      if (accessExpiredTime.isBefore(DateTime.now())) {
        final refreshExpiredTime = DateTime.parse(tokenEntity.refresh.expires);

        final authBloc = injector.get<AuthBloc>();

        if (refreshExpiredTime.isBefore(DateTime.now())) {
          authBloc.add(LogoutAuthenticationRequest());
          return;
        }

        authBloc.add(RefreshTokenRequest(tokenEntity.refresh.token));
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
