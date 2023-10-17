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
    as _i17;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/course/course_service.dart' as _i20;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i12;
import '../../data/data_source/remote/review/feedback_service.dart' as _i13;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i14;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i15;
import '../../data/data_source/remote/user/user_service.dart' as _i16;
import '../../data/repositories/authentication_repos_impl.dart' as _i19;
import '../../data/repositories/course_repos_impl.dart' as _i27;
import '../../data/repositories/tutor_repos_impl.dart' as _i22;
import '../../domain/repositories/authentication_repo.dart' as _i25;
import '../../domain/repositories/course_repo.dart' as _i26;
import '../../domain/repositories/repositories.dart' as _i18;
import '../../domain/repositories/tutor_repo.dart' as _i21;
import '../../domain/usecases/auth_usecase.dart' as _i24;
import '../../domain/usecases/course_usecase.dart' as _i28;
import '../../domain/usecases/tutor_usecase.dart' as _i23;
import '../../ui/auth/blocs/auth_bloc.dart' as _i32;
import '../../ui/course/blocs/course_bloc.dart' as _i33;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i34;
import '../../ui/course/blocs/ebook_bloc.dart' as _i29;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i30;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i31;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i3;
import '../components/navigation/routes_service.dart' as _i8;
import 'module.dart' as _i35;

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
    () => _i5.GoogleAuthImpl(),
    instanceName: 'GoogleAuthImpl',
  );
  gh.factory<_i4.AuthenticationApi>(
    () => _i6.FacebookAuthImpl(),
    instanceName: 'FacebookAuthImpl',
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
  gh.factory<_i16.UserService>(() => _i16.UserService(gh<_i11.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i17.EmailAuthApi(gh<_i11.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i18.AuthenticationRepository>(
      () => _i19.AuthenticationRepositoryImpl(
            gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i9.AppLocalStorage>(),
          ));
  gh.factory<_i20.CourseService>(() => _i20.CourseService(gh<_i11.Dio>()));
  gh.factory<_i21.TutorRepository>(() => _i22.TutorRepositoryImpl(
        gh<_i15.TutorService>(),
        gh<_i13.FeedbackService>(),
      ));
  gh.factory<_i23.TutorUseCase>(() => _i23.TutorUseCase(
        gh<_i21.TutorRepository>(),
        gh<_i13.FeedbackService>(),
      ));
  gh.factory<_i24.AuthUseCase>(
      () => _i24.AuthUseCase(gh<_i25.AuthenticationRepository>()));
  gh.factory<_i26.CourseRepository>(
      () => _i27.CourseRepositoryImpl(courseService: gh<_i20.CourseService>()));
  gh.factory<_i28.CourseUseCase>(() => _i28.CourseUseCase(
        gh<_i26.CourseRepository>(),
        gh<_i12.EbookService>(),
      ));
  gh.factory<_i29.EBookBloc>(() => _i29.EBookBloc(gh<_i28.CourseUseCase>()));
  gh.factory<_i30.TutorBloc>(() => _i30.TutorBloc(gh<_i23.TutorUseCase>()));
  gh.factory<_i31.TutorDetailBloc>(
      () => _i31.TutorDetailBloc(gh<_i23.TutorUseCase>()));
  gh.factory<_i32.AuthBloc>(() => _i32.AuthBloc(gh<_i24.AuthUseCase>()));
  gh.factory<_i33.CourseBloc>(() => _i33.CourseBloc(gh<_i28.CourseUseCase>()));
  gh.factory<_i34.CourseDetailBloc>(
      () => _i34.CourseDetailBloc(gh<_i28.CourseUseCase>()));
  return getIt;
}

class _$HiveModule extends _i35.HiveModule {}

class _$DioModule extends _i35.DioModule {}
