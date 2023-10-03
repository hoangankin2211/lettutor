import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/components/networking/networking.dart';

Future<DataState<T>> getStateOf<T>({
  required Future<HttpResponse<T>> Function() request,
}) async {
  try {
    final httpResponse = await request();
    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSuccess(data: httpResponse.data);
    } else {
      throw DioException(
        requestOptions: httpResponse.response.requestOptions,
        error: httpResponse.response,
      );
    }
  } on DioException catch (e) {
    return DataFailed(exception: e);
  }
}
