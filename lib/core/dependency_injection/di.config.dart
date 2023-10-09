// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i10;
import '../../data/data_source/local/hive_storage_impl.dart' as _i11;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i5;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i16;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i7;
import '../../data/data_source/remote/course/course_service.dart' as _i17;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i13;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i14;
import '../../data/data_source/remote/tutorial/tutorial_service.dart' as _i15;
import '../../ui/auth/blocs/auth_bloc.dart' as _i4;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i3;
import '../components/navigation/routes_service.dart' as _i9;
import 'module.dart' as _i18;

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
  gh.factory<_i3.ApplicationBloc>(
      () => _i3.ApplicationBloc(gh<_i3.ApplicationState>()));
  gh.factory<_i4.AuthBloc>(() => _i4.AuthBloc());
  gh.factory<_i5.AuthenticationApi>(
    () => _i6.FacebookAuthImpl(),
    instanceName: 'FacebookAuthImpl',
  );
  gh.factory<_i5.AuthenticationApi>(
    () => _i7.GoogleAuthImpl(),
    instanceName: 'GoogleAuthImpl',
  );
  await gh.singletonAsync<_i8.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i9.RouteService>(() => _i9.RouteService());
  gh.singleton<_i8.Box<dynamic>>(hiveModule.create(gh<_i8.HiveInterface>()));
  gh.singleton<_i10.AppLocalStorage>(
      _i11.HiveStorageImpl(gh<_i8.Box<dynamic>>()));
  gh.singleton<_i12.Dio>(dioModule.create(gh<_i10.AppLocalStorage>()));
  gh.factory<_i13.EbookService>(() => _i13.EbookService(gh<_i12.Dio>()));
  gh.factory<_i14.ScheduleService>(() => _i14.ScheduleService(gh<_i12.Dio>()));
  gh.factory<_i15.TutorialService>(() => _i15.TutorialService(gh<_i12.Dio>()));
  gh.factory<_i5.AuthenticationApi>(
    () => _i16.EmailAuthApi(gh<_i12.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i17.CourseService>(() => _i17.CourseService(gh<_i12.Dio>()));
  return getIt;
}

class _$HiveModule extends _i18.HiveModule {}

class _$DioModule extends _i18.DioModule {}
