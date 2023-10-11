import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:lettutor/core/components/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';

class NetworkService {
  static Dio initializeDio({
    required String baseUrl,
  }) {
    var uri = Uri.tryParse(baseUrl);
    var host = uri?.host;
    BaseOptions? baseOptions;
    baseOptions = host?.isNotEmpty ?? false
        ? BaseOptions(baseUrl: baseUrl)
        : BaseOptions();

    final dio = Dio(baseOptions)
      ..interceptors.add(ApiTokenInterceptor(injector.get<AppLocalStorage>()))
      ..interceptors.add(AwesomeDioInterceptor());

    return dio;
  }
}
