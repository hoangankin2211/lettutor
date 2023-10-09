// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i9;
import '../../data/data_source/local/hive_storage_impl.dart' as _i10;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i4;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i15;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/course/course_service.dart' as _i18;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i12;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i13;
import '../../data/data_source/remote/tutorial/tutorial_service.dart' as _i14;
import '../../data/repositories/authentication_repos_impl.dart' as _i17;
import '../../domain/repositories/authentication_repo.dart' as _i20;
import '../../domain/repositories/repositories.dart' as _i16;
import '../../domain/usecases/auth_usecase.dart' as _i19;
import '../../ui/auth/blocs/auth_bloc.dart' as _i21;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i3;
import '../components/navigation/routes_service.dart' as _i8;
import 'module.dart' as _i22;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final hiveModule = _$HiveModule();
  final dioModule = _$DioModule();
  gh.factory<_i3.ApplicationBloc>(() => _i3.ApplicationBloc());
  gh.factory<_i4.AuthenticationApi>(
    () => _i5.FacebookAuthImpl(),
    instanceName: 'FacebookAuthImpl',
  );
  gh.factory<_i4.AuthenticationApi>(
    () => _i6.GoogleAuthImpl(),
    instanceName: 'GoogleAuthImpl',
  );
  await gh.singletonAsync<_i7.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i8.RouteService>(() => _i8.RouteService());
  gh.singleton<_i7.Box<dynamic>>(hiveModule.create(gh<_i7.HiveInterface>()));
  gh.singleton<_i9.AppLocalStorage>(
      _i10.HiveStorageImpl(gh<_i7.Box<dynamic>>()));
  gh.singleton<_i11.Dio>(dioModule.create(gh<_i9.AppLocalStorage>()));
  gh.factory<_i12.EbookService>(() => _i12.EbookService(gh<_i11.Dio>()));
  gh.factory<_i13.ScheduleService>(() => _i13.ScheduleService(gh<_i11.Dio>()));
  gh.factory<_i14.TutorialService>(() => _i14.TutorialService(gh<_i11.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i15.EmailAuthApi(gh<_i11.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i16.AuthenticationRepository>(() =>
      _i17.AuthenticationRepositoryImpl(
          gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi')));
  gh.factory<_i18.CourseService>(() => _i18.CourseService(gh<_i11.Dio>()));
  gh.factory<_i19.AuthUseCase>(
      () => _i19.AuthUseCase(gh<_i20.AuthenticationRepository>()));
  gh.factory<_i21.AuthBloc>(() => _i21.AuthBloc(gh<_i19.AuthUseCase>()));
  return getIt;
}

class _$HiveModule extends _i22.HiveModule {}

class _$DioModule extends _i22.DioModule {}
