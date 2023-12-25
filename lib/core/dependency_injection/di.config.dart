// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i8;
import '../../data/data_source/local/authentication/auth_local_data.dart'
    as _i11;
import '../../data/data_source/local/hive_storage_impl.dart' as _i9;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i3;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i18;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i4;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/chore/chores_service.dart' as _i21;
import '../../data/data_source/remote/course/course_service.dart' as _i22;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i13;
import '../../data/data_source/remote/review/feedback_service.dart' as _i14;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i15;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i16;
import '../../data/data_source/remote/user/user_service.dart' as _i17;
import '../../data/repositories/authentication_repos_impl.dart' as _i20;
import '../../data/repositories/course_repos_impl.dart' as _i33;
import '../../data/repositories/schedule_repos_impl.dart' as _i24;
import '../../data/repositories/tutor_repos_impl.dart' as _i27;
import '../../domain/repositories/authentication_repo.dart' as _i30;
import '../../domain/repositories/course_repo.dart' as _i32;
import '../../domain/repositories/repositories.dart' as _i19;
import '../../domain/repositories/schedule_repo.dart' as _i23;
import '../../domain/repositories/tutor_repo.dart' as _i26;
import '../../domain/usecases/auth_usecase.dart' as _i29;
import '../../domain/usecases/course_usecase.dart' as _i34;
import '../../domain/usecases/schedule_usecase.dart' as _i25;
import '../../domain/usecases/tutor_usecase.dart' as _i28;
import '../../ui/auth/blocs/auth_bloc.dart' as _i31;
import '../../ui/course/blocs/course_bloc.dart' as _i39;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i40;
import '../../ui/course/blocs/ebook_bloc.dart' as _i35;
import '../../ui/dashboard/blocs/dashboard_bloc.dart' as _i41;
import '../../ui/schedule/bloc/schedule_bloc.dart' as _i36;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i37;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i38;
import '../utils/blocs/app_bloc.dart/application_bloc.dart' as _i10;
import '../utils/navigation/routes_service.dart' as _i7;
import 'module.dart' as _i42;

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
  gh.factory<_i3.AuthenticationApi>(
    () => _i4.FacebookAuthImpl(),
    instanceName: 'FacebookAuthImpl',
  );
  gh.factory<_i3.AuthenticationApi>(
    () => _i5.GoogleAuthImpl(),
    instanceName: 'GoogleAuthImpl',
  );
  await gh.singletonAsync<_i6.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i7.RouteService>(() => _i7.RouteService());
  gh.singleton<_i6.Box<dynamic>>(hiveModule.create(gh<_i6.HiveInterface>()));
  gh.singleton<_i8.AppLocalStorage>(
      _i9.HiveStorageImpl(gh<_i6.Box<dynamic>>()));
  gh.factory<_i10.ApplicationBloc>(
      () => _i10.ApplicationBloc(gh<_i8.AppLocalStorage>()));
  gh.factory<_i11.AuthLocalData>(
      () => _i11.AuthLocalData(gh<_i8.AppLocalStorage>()));
  gh.singleton<_i12.Dio>(dioModule.create(gh<_i8.AppLocalStorage>()));
  gh.factory<_i13.EbookService>(() => _i13.EbookService(gh<_i12.Dio>()));
  gh.factory<_i14.FeedbackService>(() => _i14.FeedbackService(gh<_i12.Dio>()));
  gh.factory<_i15.ScheduleService>(() => _i15.ScheduleService(gh<_i12.Dio>()));
  gh.factory<_i16.TutorService>(() => _i16.TutorService(gh<_i12.Dio>()));
  gh.factory<_i17.UserService>(() => _i17.UserService(gh<_i12.Dio>()));
  gh.factory<_i3.AuthenticationApi>(
    () => _i18.EmailAuthApi(gh<_i12.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i19.AuthenticationRepository>(
      () => _i20.AuthenticationRepositoryImpl(
            gh<_i3.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i8.AppLocalStorage>(),
          ));
  gh.factory<_i21.ChoresService>(
    () => _i21.ChoresService(gh<_i12.Dio>()),
    instanceName: 'ChoresService',
  );
  gh.factory<_i22.CourseService>(() => _i22.CourseService(gh<_i12.Dio>()));
  gh.factory<_i23.ScheduleRepository>(
      () => _i24.ScheduleRepositoryImpl(gh<_i15.ScheduleService>()));
  gh.factory<_i25.ScheduleUseCase>(
      () => _i25.ScheduleUseCase(gh<_i23.ScheduleRepository>()));
  gh.factory<_i26.TutorRepository>(() => _i27.TutorRepositoryImpl(
        gh<_i16.TutorService>(),
        gh<_i14.FeedbackService>(),
      ));
  gh.factory<_i28.TutorUseCase>(() => _i28.TutorUseCase(
        gh<_i26.TutorRepository>(),
        gh<_i14.FeedbackService>(),
        gh<_i16.TutorService>(),
        gh<_i17.UserService>(),
      ));
  gh.factory<_i29.AuthUseCase>(() => _i29.AuthUseCase(
        gh<_i30.AuthenticationRepository>(),
        gh<_i3.AuthenticationApi>(instanceName: 'EmailAuthApi'),
      ));
  gh.factory<_i31.AuthenticationBloc>(() => _i31.AuthenticationBloc(
        gh<_i29.AuthUseCase>(),
        gh<_i11.AuthLocalData>(),
        gh<_i17.UserService>(),
      ));
  gh.factory<_i32.CourseRepository>(
      () => _i33.CourseRepositoryImpl(courseService: gh<_i22.CourseService>()));
  gh.factory<_i34.CourseUseCase>(() => _i34.CourseUseCase(
        gh<_i32.CourseRepository>(),
        gh<_i13.EbookService>(),
      ));
  gh.factory<_i35.EBookBloc>(() => _i35.EBookBloc(gh<_i34.CourseUseCase>()));
  gh.factory<_i36.ScheduleBloc>(
      () => _i36.ScheduleBloc(gh<_i25.ScheduleUseCase>()));
  gh.factory<_i37.TutorBloc>(() => _i37.TutorBloc(
        gh<_i28.TutorUseCase>(),
        gh<_i25.ScheduleUseCase>(),
      ));
  gh.factory<_i38.TutorDetailBloc>(() => _i38.TutorDetailBloc(
        gh<_i28.TutorUseCase>(),
        gh<_i25.ScheduleUseCase>(),
        gh<_i16.TutorService>(),
      ));
  gh.factory<_i39.CourseBloc>(() => _i39.CourseBloc(gh<_i34.CourseUseCase>()));
  gh.factory<_i40.CourseDetailBloc>(
      () => _i40.CourseDetailBloc(gh<_i34.CourseUseCase>()));
  gh.factory<_i41.DashboardBloc>(() => _i41.DashboardBloc(
        gh<_i39.CourseBloc>(),
        gh<_i35.EBookBloc>(),
        gh<_i37.TutorBloc>(),
        gh<_i36.ScheduleBloc>(),
      ));
  return getIt;
}

class _$HiveModule extends _i42.HiveModule {}

class _$DioModule extends _i42.DioModule {}
