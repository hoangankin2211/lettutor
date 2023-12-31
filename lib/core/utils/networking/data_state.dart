import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? dioException;
  final int statusCode;

  const DataState(
      {required this.statusCode,
      required this.data,
      required this.dioException});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
    required super.statusCode,
  }) : super(data: data, dioException: null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(
      {required super.statusCode,
      required DioException exception,
      dynamic data})
      : super(data: data, dioException: exception);
}

extension DataStateExtensions<T> on DataState<T> {
  Either<DioException, bool> isSuccess() {
    if (this is DataFailed) {
      return Left((this as DataFailed).dioException!);
    }
    return const Right(true);
  }
}
