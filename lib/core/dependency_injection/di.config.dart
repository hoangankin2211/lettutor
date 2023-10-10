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
    as _i16;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/course/course_service.dart' as _i19;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i12;
import '../../data/data_source/remote/review/feedback_service.dart' as _i13;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i14;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i15;
import '../../data/repositories/authentication_repos_impl.dart' as _i18;
import '../../data/repositories/course_repos_impl.dart' as _i23;
import '../../domain/repositories/authentication_repo.dart' as _i21;
import '../../domain/repositories/course_repo.dart' as _i22;
import '../../domain/repositories/repositories.dart' as _i17;
import '../../domain/usecases/auth_usecase.dart' as _i20;
import '../../domain/usecases/course_usecase.dart' as _i24;
import '../../ui/auth/blocs/auth_bloc.dart' as _i25;
import '../../ui/course/blocs/course_bloc.dart' as _i26;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i3;
import '../components/navigation/routes_service.dart' as _i8;
import 'module.dart' as _i27;

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
  gh.factory<_i13.FeedbackService>(() => _i13.FeedbackService(gh<_i11.Dio>()));
  gh.factory<_i14.ScheduleService>(() => _i14.ScheduleService(gh<_i11.Dio>()));
  gh.factory<_i15.TutorService>(() => _i15.TutorService(gh<_i11.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i16.EmailAuthApi(gh<_i11.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i17.AuthenticationRepository>(
      () => _i18.AuthenticationRepositoryImpl(
            gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i9.AppLocalStorage>(),
          ));
  gh.factory<_i19.CourseService>(() => _i19.CourseService(gh<_i11.Dio>()));
  gh.factory<_i20.AuthUseCase>(
      () => _i20.AuthUseCase(gh<_i21.AuthenticationRepository>()));
  gh.factory<_i22.CourseRepository>(
      () => _i23.CourseRepositoryImpl(courseService: gh<_i19.CourseService>()));
  gh.factory<_i24.CourseUseCase>(
      () => _i24.CourseUseCase(gh<_i22.CourseRepository>()));
  gh.factory<_i25.AuthBloc>(() => _i25.AuthBloc(gh<_i20.AuthUseCase>()));
  gh.factory<_i26.CourseBloc>(() => _i26.CourseBloc(gh<_i24.CourseUseCase>()));
  return getIt;
}

class _$HiveModule extends _i27.HiveModule {}

class _$DioModule extends _i27.DioModule {}
