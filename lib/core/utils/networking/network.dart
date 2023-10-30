import 'package:dio/dio.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/core/utils/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';

import 'interceptor/logger_interceptor.dart';

class NetworkService {
  static Dio initializeDio({
    required String baseUrl,
  }) {
    var uri = Uri.tryParse(baseUrl);
    var host = uri?.host;
    BaseOptions? baseOptions;
    baseOptions = host?.isNotEmpty ?? false
        ? BaseOptions(baseUrl: baseUrl, headers: {
            'Accept': 'application/json, text/plain, */*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'en-US,en;q=0.9',
            'Content-Type': 'application/json',
            'Origin': 'https://sandbox.app.lettutor.com',
            'Referer': 'https://sandbox.app.lettutor.com/',
            'Sec-Ch-Ua':
                '"Microsoft Edge";v="117", "Not;A=Brand";v="8", "Chromium";v="117"',
            'Sec-Ch-Ua-Mobile': '?1',
            'Sec-Ch-Ua-Platform': '"Android"',
            'Sec-Fetch-Dest': 'empty',
            'Sec-Fetch-Mode': 'cors',
            'Sec-Fetch-Site': 'same-site',
          })
        : BaseOptions();

    final dio = Dio(baseOptions)
      ..interceptors.add(LoggerInterceptor())
      ..interceptors.add(ApiTokenInterceptor(
        injector.get<AppLocalStorage>(),
      ));

    return dio;
  }
}
