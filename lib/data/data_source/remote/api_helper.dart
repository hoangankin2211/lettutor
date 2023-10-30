import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/networking/networking.dart';

Future<DataState<T>> getStateOf<T>({
  required Future<HttpResponse> Function() request,
  Future<T> Function(Map<String, dynamic> data)? parser,
}) async {
  try {
    final httpResponse = await request();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(
        data: parser == null
            ? httpResponse.data
            : await parser(httpResponse.data),
        statusCode: httpResponse.response.statusCode!,
      );
    } else {
      final String? extraMessage =
          (httpResponse.response.data as Map<String, dynamic>?)?["message"];
      throw DioException(
        response: httpResponse.response,
        message:
            '${httpResponse.response.statusMessage}' + '\n' + '$extraMessage',
        requestOptions: httpResponse.response.requestOptions,
        error: httpResponse.response,
      );
    }
  } on DioException catch (e) {
    return DataFailed(
      exception: e,
      statusCode: e.response?.statusCode ?? 400,
    );
  }
}
