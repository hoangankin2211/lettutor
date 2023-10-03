import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/configuration/configuration.dart';
import 'package:lettutor/core/components/networking/interceptor/api_token_interceptor.dart';
import 'package:lettutor/core/dependency_injection/di.dart';

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
      ..interceptors.add(ApiTokenInterceptor(injector.get()))
      ..interceptors.add(AwesomeDioInterceptor());

    return dio;
  }
}
