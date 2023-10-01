import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/components/configuration/configuration.dart';

@injectable
class NetworkService {
  late final Dio dio;

  NetworkService() {
    dio = initializeDio(baseUrl: Configurations.baseUrl);
  }

  Dio initializeDio({
    required String baseUrl,
  }) {
    var uri = Uri.tryParse(baseUrl);
    var host = uri?.host;
    BaseOptions? baseOptions;
    baseOptions = host?.isNotEmpty ?? false
        ? BaseOptions(baseUrl: baseUrl)
        : BaseOptions();

    final dio = Dio(baseOptions);
    // ..interceptors.add(ApiTokenInterceptor(appStorage))
    // ..interceptors.add(LoggerInterceptor());

    return dio;
  }
}
