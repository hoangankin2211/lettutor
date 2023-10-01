import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lettutor/data/local/app_local_storage.dart';

const keyAuthentication = 'Authorization';
const keyApiKey = 'XApiKey';
const keyBear = 'Bearer';
const keyAcceptLanguage = 'Accept-Language';
const accessTokenKey = "accessToken";

class ApiTokenInterceptor extends Interceptor {
  final AppLocalStorage _appLocalStorage;

  ApiTokenInterceptor(this._appLocalStorage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = _appLocalStorage.getString(accessTokenKey);

    if (accessToken?.isNotEmpty ?? false) {
      options.headers[keyAuthentication] = '$keyBear $accessToken';
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
