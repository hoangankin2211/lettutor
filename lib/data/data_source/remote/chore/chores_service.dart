import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chores_service.g.dart';

@injectable
@Named(ChoresService.name)
@RestApi()
abstract class ChoresService {
  static const String name = 'ChoresService';
  static const String testPreparation = '/test_preparation';
  static const String learnTopic = '/learn-topic';

  @factoryMethod
  factory ChoresService(Dio dio) = _ChoresService;

  @GET(testPreparation)
  Future<HttpResponse> getTestPreparation();

  @GET(learnTopic)
  Future<HttpResponse> getLearnTopic();
}
