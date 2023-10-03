import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? dioException;

  const DataState({required this.data, required this.dioException});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({
    required T data,
  }) : super(data: data, dioException: null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed({
    required DioException exception,
  }) : super(data: null, dioException: exception);
}
