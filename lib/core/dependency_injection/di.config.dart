// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i13;
import '../../data/data_source/local/authentication/auth_local_data.dart'
    as _i16;
import '../../data/data_source/local/hive_storage_impl.dart' as _i14;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i4;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i23;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/chat/chat_service.dart' as _i26;
import '../../data/data_source/remote/chore/chores_service.dart' as _i27;
import '../../data/data_source/remote/course/course_service.dart' as _i28;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i18;
import '../../data/data_source/remote/review/feedback_service.dart' as _i19;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i20;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i21;
import '../../data/data_source/remote/user/user_service.dart' as _i22;
import '../../data/repositories/authentication_repos_impl.dart' as _i25;
import '../../data/repositories/chat_repo_impl.dart' as _i39;
import '../../data/repositories/course_repos_impl.dart' as _i42;
import '../../data/repositories/schedule_repos_impl.dart' as _i30;
import '../../data/repositories/tutor_repos_impl.dart' as _i33;
import '../../domain/repositories/authentication_repo.dart' as _i36;
import '../../domain/repositories/chat_repo.dart' as _i38;
import '../../domain/repositories/course_repo.dart' as _i41;
import '../../domain/repositories/repositories.dart' as _i24;
import '../../domain/repositories/schedule_repo.dart' as _i29;
import '../../domain/repositories/tutor_repo.dart' as _i32;
import '../../domain/usecases/auth_usecase.dart' as _i35;
import '../../domain/usecases/chat_usecase.dart' as _i40;
import '../../domain/usecases/course_usecase.dart' as _i43;
import '../../domain/usecases/schedule_usecase.dart' as _i31;
import '../../domain/usecases/tutor_usecase.dart' as _i34;
import '../../ui/auth/blocs/auth_bloc.dart' as _i37;
import '../../ui/chat/bloc/chat_cubit.dart' as _i48;
import '../../ui/chat/bloc/chat_list_cubit.dart' as _i49;
import '../../ui/course/blocs/course_bloc.dart' as _i50;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i51;
import '../../ui/course/blocs/ebook_bloc.dart' as _i44;
import '../../ui/dashboard/blocs/dashboard_bloc.dart' as _i52;
import '../../ui/schedule/bloc/schedule_bloc.dart' as _i45;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i46;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i47;
import '../utils/analytics/google_analytic_service.dart' as _i8;
import '../utils/blocs/app_bloc.dart/application_bloc.dart' as _i15;
import '../utils/navigation/routes_service.dart' as _i11;
import '../utils/networking/socket/app_socket.dart' as _i3;
import '../utils/oauth/facebook_oauth_service.dart' as _i7;
import '../utils/oauth/google_oauth_service.dart' as _i9;
import '../utils/sentry/sentry_service.dart' as _i12;
import 'module.dart' as _i53;

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
  gh.singleton<_i3.AppSocket>(_i3.AppSocket());
  gh.factory<_i4.AuthenticationApi>(
    () => _i5.GoogleAuthImpl(),
    instanceName: 'GoogleAuthImpl',
  );
  gh.factory<_i4.AuthenticationApi>(
    () => _i6.FacebookAuthImpl(),
    instanceName: 'FacebookAuthImpl',
  );
  gh.singleton<_i7.FacebookOAuthService>(_i7.FacebookOAuthService());
  gh.singleton<_i8.GoogleAnalyticService>(_i8.GoogleAnalyticService());
  gh.singleton<_i9.GoogleOAuthService>(_i9.GoogleOAuthService());
  await gh.singletonAsync<_i10.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i11.RouteService>(() => _i11.RouteService());
  gh.factory<_i12.SentryService>(() => _i12.SentryService());
  gh.singleton<_i10.Box<dynamic>>(hiveModule.create(gh<_i10.HiveInterface>()));
  gh.singleton<_i13.AppLocalStorage>(
      _i14.HiveStorageImpl(gh<_i10.Box<dynamic>>()));
  gh.factory<_i15.ApplicationBloc>(
      () => _i15.ApplicationBloc(gh<_i13.AppLocalStorage>()));
  gh.factory<_i16.AuthLocalData>(
      () => _i16.AuthLocalData(gh<_i13.AppLocalStorage>()));
  gh.singleton<_i17.Dio>(dioModule.create(gh<_i13.AppLocalStorage>()));
  gh.factory<_i18.EbookService>(() => _i18.EbookService(gh<_i17.Dio>()));
  gh.factory<_i19.FeedbackService>(() => _i19.FeedbackService(gh<_i17.Dio>()));
  gh.factory<_i20.ScheduleService>(() => _i20.ScheduleService(gh<_i17.Dio>()));
  gh.factory<_i21.TutorService>(() => _i21.TutorService(gh<_i17.Dio>()));
  gh.factory<_i22.UserService>(() => _i22.UserService(gh<_i17.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i23.EmailAuthApi(gh<_i17.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i24.AuthenticationRepository>(
      () => _i25.AuthenticationRepositoryImpl(
            gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i13.AppLocalStorage>(),
          ));
  gh.factory<_i26.ChatService>(() => _i26.ChatService(gh<_i17.Dio>()));
  gh.factory<_i27.ChoresService>(
    () => _i27.ChoresService(gh<_i17.Dio>()),
    instanceName: 'ChoresService',
  );
  gh.factory<_i28.CourseService>(() => _i28.CourseService(gh<_i17.Dio>()));
  gh.factory<_i29.ScheduleRepository>(
      () => _i30.ScheduleRepositoryImpl(gh<_i20.ScheduleService>()));
  gh.factory<_i31.ScheduleUseCase>(
      () => _i31.ScheduleUseCase(gh<_i29.ScheduleRepository>()));
  gh.factory<_i32.TutorRepository>(() => _i33.TutorRepositoryImpl(
        gh<_i21.TutorService>(),
        gh<_i19.FeedbackService>(),
      ));
  gh.factory<_i34.TutorUseCase>(() => _i34.TutorUseCase(
        gh<_i32.TutorRepository>(),
        gh<_i19.FeedbackService>(),
        gh<_i21.TutorService>(),
        gh<_i22.UserService>(),
      ));
  gh.factory<_i35.AuthUseCase>(() => _i35.AuthUseCase(
        gh<_i36.AuthenticationRepository>(),
        gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
      ));
  gh.singleton<_i37.AuthenticationBloc>(_i37.AuthenticationBloc(
    gh<_i35.AuthUseCase>(),
    gh<_i16.AuthLocalData>(),
    gh<_i22.UserService>(),
    gh<_i9.GoogleOAuthService>(),
    gh<_i7.FacebookOAuthService>(),
  ));
  gh.factory<_i38.ChatRepository>(
      () => _i39.ChatRepositoryImpl(gh<_i26.ChatService>()));
  gh.singleton<_i40.ChatUseCase>(_i40.ChatUseCase(
    gh<_i38.ChatRepository>(),
    gh<_i3.AppSocket>(),
  ));
  gh.factory<_i41.CourseRepository>(
      () => _i42.CourseRepositoryImpl(courseService: gh<_i28.CourseService>()));
  gh.factory<_i43.CourseUseCase>(() => _i43.CourseUseCase(
        gh<_i41.CourseRepository>(),
        gh<_i18.EbookService>(),
      ));
  gh.factory<_i44.EBookBloc>(() => _i44.EBookBloc(gh<_i43.CourseUseCase>()));
  gh.factory<_i45.ScheduleBloc>(
      () => _i45.ScheduleBloc(gh<_i31.ScheduleUseCase>()));
  gh.factory<_i46.TutorBloc>(() => _i46.TutorBloc(
        gh<_i34.TutorUseCase>(),
        gh<_i31.ScheduleUseCase>(),
      ));
  gh.factory<_i47.TutorDetailBloc>(() => _i47.TutorDetailBloc(
        gh<_i34.TutorUseCase>(),
        gh<_i31.ScheduleUseCase>(),
        gh<_i21.TutorService>(),
        gh<_i8.GoogleAnalyticService>(),
      ));
  gh.singleton<_i48.ChatCubit>(_i48.ChatCubit(gh<_i40.ChatUseCase>()));
  gh.singleton<_i49.ChatListCubit>(_i49.ChatListCubit(gh<_i40.ChatUseCase>()));
  gh.factory<_i50.CourseBloc>(() => _i50.CourseBloc(gh<_i43.CourseUseCase>()));
  gh.factory<_i51.CourseDetailBloc>(() => _i51.CourseDetailBloc(
        gh<_i43.CourseUseCase>(),
        gh<_i8.GoogleAnalyticService>(),
      ));
  gh.factory<_i52.DashboardBloc>(() => _i52.DashboardBloc(
        gh<_i50.CourseBloc>(),
        gh<_i3.AppSocket>(),
        gh<_i44.EBookBloc>(),
        gh<_i46.TutorBloc>(),
        gh<_i45.ScheduleBloc>(),
        gh<_i49.ChatListCubit>(),
        gh<_i37.AuthenticationBloc>(),
        gh<_i40.ChatUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i53.HiveModule {}

class _$DioModule extends _i53.DioModule {}
