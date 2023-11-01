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
import 'package:hive/hive.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i8;
import '../../data/data_source/local/hive_storage_impl.dart' as _i9;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i3;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i17;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i4;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/chore/chores_service.dart' as _i20;
import '../../data/data_source/remote/course/course_service.dart' as _i21;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i12;
import '../../data/data_source/remote/review/feedback_service.dart' as _i13;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i14;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i15;
import '../../data/data_source/remote/user/user_service.dart' as _i16;
import '../../data/repositories/authentication_repos_impl.dart' as _i19;
import '../../data/repositories/course_repos_impl.dart' as _i31;
import '../../data/repositories/schedule_repos_impl.dart' as _i23;
import '../../data/repositories/tutor_repos_impl.dart' as _i26;
import '../../domain/repositories/authentication_repo.dart' as _i29;
import '../../domain/repositories/course_repo.dart' as _i30;
import '../../domain/repositories/repositories.dart' as _i18;
import '../../domain/repositories/schedule_repo.dart' as _i22;
import '../../domain/repositories/tutor_repo.dart' as _i25;
import '../../domain/usecases/auth_usecase.dart' as _i28;
import '../../domain/usecases/course_usecase.dart' as _i32;
import '../../domain/usecases/schedule_usecase.dart' as _i24;
import '../../domain/usecases/tutor_usecase.dart' as _i27;
import '../../ui/auth/blocs/auth_bloc.dart' as _i37;
import '../../ui/course/blocs/course_bloc.dart' as _i38;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i39;
import '../../ui/course/blocs/ebook_bloc.dart' as _i33;
import '../../ui/dashboard/blocs/dashboard_bloc.dart' as _i40;
import '../../ui/schedule/bloc/schedule_bloc.dart' as _i34;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i35;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i36;
import '../utils/blocs/app_bloc.dart/application_bloc.dart' as _i10;
import '../utils/navigation/routes_service.dart' as _i7;
import 'module.dart' as _i41;

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
  gh.singleton<_i11.Dio>(dioModule.create(gh<_i8.AppLocalStorage>()));
  gh.factory<_i12.EbookService>(() => _i12.EbookService(gh<_i11.Dio>()));
  gh.factory<_i13.FeedbackService>(() => _i13.FeedbackService(gh<_i11.Dio>()));
  gh.factory<_i14.ScheduleService>(() => _i14.ScheduleService(gh<_i11.Dio>()));
  gh.factory<_i15.TutorService>(() => _i15.TutorService(gh<_i11.Dio>()));
  gh.factory<_i16.UserService>(() => _i16.UserService(gh<_i11.Dio>()));
  gh.factory<_i3.AuthenticationApi>(
    () => _i17.EmailAuthApi(gh<_i11.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i18.AuthenticationRepository>(
      () => _i19.AuthenticationRepositoryImpl(
            gh<_i3.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i8.AppLocalStorage>(),
          ));
  gh.factory<_i20.ChoresService>(
    () => _i20.ChoresService(gh<_i11.Dio>()),
    instanceName: 'ChoresService',
  );
  gh.factory<_i21.CourseService>(() => _i21.CourseService(gh<_i11.Dio>()));
  gh.factory<_i22.ScheduleRepository>(
      () => _i23.ScheduleRepositoryImpl(gh<_i14.ScheduleService>()));
  gh.factory<_i24.ScheduleUseCase>(
      () => _i24.ScheduleUseCase(gh<_i22.ScheduleRepository>()));
  gh.factory<_i25.TutorRepository>(() => _i26.TutorRepositoryImpl(
        gh<_i15.TutorService>(),
        gh<_i13.FeedbackService>(),
      ));
  gh.factory<_i27.TutorUseCase>(() => _i27.TutorUseCase(
        gh<_i25.TutorRepository>(),
        gh<_i13.FeedbackService>(),
        gh<_i15.TutorService>(),
      ));
  gh.factory<_i28.AuthUseCase>(
      () => _i28.AuthUseCase(gh<_i29.AuthenticationRepository>()));
  gh.factory<_i30.CourseRepository>(
      () => _i31.CourseRepositoryImpl(courseService: gh<_i21.CourseService>()));
  gh.factory<_i32.CourseUseCase>(() => _i32.CourseUseCase(
        gh<_i30.CourseRepository>(),
        gh<_i12.EbookService>(),
      ));
  gh.factory<_i33.EBookBloc>(() => _i33.EBookBloc(gh<_i32.CourseUseCase>()));
  gh.factory<_i34.ScheduleBloc>(
      () => _i34.ScheduleBloc(gh<_i24.ScheduleUseCase>()));
  gh.factory<_i35.TutorBloc>(() => _i35.TutorBloc(
        gh<_i27.TutorUseCase>(),
        gh<_i24.ScheduleUseCase>(),
      ));
  gh.factory<_i36.TutorDetailBloc>(() => _i36.TutorDetailBloc(
        gh<_i27.TutorUseCase>(),
        gh<_i24.ScheduleUseCase>(),
      ));
  gh.singleton<_i37.AuthBloc>(_i37.AuthBloc(
    gh<_i28.AuthUseCase>(),
    gh<_i8.AppLocalStorage>(),
    gh<_i16.UserService>(),
  ));
  gh.factory<_i38.CourseBloc>(() => _i38.CourseBloc(gh<_i32.CourseUseCase>()));
  gh.factory<_i39.CourseDetailBloc>(
      () => _i39.CourseDetailBloc(gh<_i32.CourseUseCase>()));
  gh.factory<_i40.DashboardBloc>(() => _i40.DashboardBloc(
        gh<_i38.CourseBloc>(),
        gh<_i33.EBookBloc>(),
        gh<_i35.TutorBloc>(),
        gh<_i34.ScheduleBloc>(),
      ));
  return getIt;
}

class _$HiveModule extends _i41.HiveModule {}

class _$DioModule extends _i41.DioModule {}
