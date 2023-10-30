import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';
import 'package:lettutor/data/data_source/remote/chore/chores_service.dart';
import 'package:lettutor/data/entities/test_preparation.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/mapper/mapper.dart';
import 'package:lettutor/domain/models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chores_provider.g.dart';

@riverpod
Future<List<LearnTopics>> getLearnTopic(GetLearnTopicRef ref) async {
  final response = await getStateOf(
    request: () async => await injector.get<ChoresService>().getLearnTopic(),
  );

  return (response.data! as List<dynamic>)
      .map<LearnTopics>((e) => LearnTopics.fromMap(e))
      .toList();
}

@riverpod
Future<List<TestPreparation>> getTestPreparation(
    GetTestPreparationRef ref) async {
  final response = await getStateOf(
    request: () async => await injector.get<ChoresService>().getLearnTopic(),
  );

  return (response.data! as List<dynamic>)
      .map<TestPreparation>((e) =>
          TestPreparationMapper.fromEntity(TestPreparationEntity.fromJson(e)))
      .toList();
}
