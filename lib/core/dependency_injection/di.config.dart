// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i15;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i11;
import '../../data/data_source/local/authentication/auth_local_data.dart'
    as _i14;
import '../../data/data_source/local/hive_storage_impl.dart' as _i12;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i4;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i21;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/chat/chat_service.dart' as _i24;
import '../../data/data_source/remote/chore/chores_service.dart' as _i25;
import '../../data/data_source/remote/course/course_service.dart' as _i26;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i16;
import '../../data/data_source/remote/review/feedback_service.dart' as _i17;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i18;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i19;
import '../../data/data_source/remote/user/user_service.dart' as _i20;
import '../../data/repositories/authentication_repos_impl.dart' as _i23;
import '../../data/repositories/chat_repo_impl.dart' as _i37;
import '../../data/repositories/course_repos_impl.dart' as _i40;
import '../../data/repositories/schedule_repos_impl.dart' as _i28;
import '../../data/repositories/tutor_repos_impl.dart' as _i31;
import '../../domain/repositories/authentication_repo.dart' as _i34;
import '../../domain/repositories/chat_repo.dart' as _i36;
import '../../domain/repositories/course_repo.dart' as _i39;
import '../../domain/repositories/repositories.dart' as _i22;
import '../../domain/repositories/schedule_repo.dart' as _i27;
import '../../domain/repositories/tutor_repo.dart' as _i30;
import '../../domain/usecases/auth_usecase.dart' as _i33;
import '../../domain/usecases/chat_usecase.dart' as _i38;
import '../../domain/usecases/course_usecase.dart' as _i41;
import '../../domain/usecases/schedule_usecase.dart' as _i29;
import '../../domain/usecases/tutor_usecase.dart' as _i32;
import '../../ui/auth/blocs/auth_bloc.dart' as _i35;
import '../../ui/chat/bloc/chat_cubit.dart' as _i46;
import '../../ui/chat/bloc/chat_list_cubit.dart' as _i47;
import '../../ui/course/blocs/course_bloc.dart' as _i48;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i49;
import '../../ui/course/blocs/ebook_bloc.dart' as _i42;
import '../../ui/dashboard/blocs/dashboard_bloc.dart' as _i50;
import '../../ui/schedule/bloc/schedule_bloc.dart' as _i43;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i44;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i45;
import '../utils/blocs/app_bloc.dart/application_bloc.dart' as _i13;
import '../utils/navigation/routes_service.dart' as _i10;
import '../utils/networking/socket/app_socket.dart' as _i3;
import '../utils/oauth/facebook_oauth_service.dart' as _i7;
import '../utils/oauth/google_oauth_service.dart' as _i8;
import 'module.dart' as _i51;

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
  gh.singleton<_i8.GoogleOAuthService>(_i8.GoogleOAuthService());
  await gh.singletonAsync<_i9.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i10.RouteService>(() => _i10.RouteService());
  gh.singleton<_i9.Box<dynamic>>(hiveModule.create(gh<_i9.HiveInterface>()));
  gh.singleton<_i11.AppLocalStorage>(
      _i12.HiveStorageImpl(gh<_i9.Box<dynamic>>()));
  gh.factory<_i13.ApplicationBloc>(
      () => _i13.ApplicationBloc(gh<_i11.AppLocalStorage>()));
  gh.factory<_i14.AuthLocalData>(
      () => _i14.AuthLocalData(gh<_i11.AppLocalStorage>()));
  gh.singleton<_i15.Dio>(dioModule.create(gh<_i11.AppLocalStorage>()));
  gh.factory<_i16.EbookService>(() => _i16.EbookService(gh<_i15.Dio>()));
  gh.factory<_i17.FeedbackService>(() => _i17.FeedbackService(gh<_i15.Dio>()));
  gh.factory<_i18.ScheduleService>(() => _i18.ScheduleService(gh<_i15.Dio>()));
  gh.factory<_i19.TutorService>(() => _i19.TutorService(gh<_i15.Dio>()));
  gh.factory<_i20.UserService>(() => _i20.UserService(gh<_i15.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i21.EmailAuthApi(gh<_i15.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i22.AuthenticationRepository>(
      () => _i23.AuthenticationRepositoryImpl(
            gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i11.AppLocalStorage>(),
          ));
  gh.factory<_i24.ChatService>(() => _i24.ChatService(gh<_i15.Dio>()));
  gh.factory<_i25.ChoresService>(
    () => _i25.ChoresService(gh<_i15.Dio>()),
    instanceName: 'ChoresService',
  );
  gh.factory<_i26.CourseService>(() => _i26.CourseService(gh<_i15.Dio>()));
  gh.factory<_i27.ScheduleRepository>(
      () => _i28.ScheduleRepositoryImpl(gh<_i18.ScheduleService>()));
  gh.factory<_i29.ScheduleUseCase>(
      () => _i29.ScheduleUseCase(gh<_i27.ScheduleRepository>()));
  gh.factory<_i30.TutorRepository>(() => _i31.TutorRepositoryImpl(
        gh<_i19.TutorService>(),
        gh<_i17.FeedbackService>(),
      ));
  gh.factory<_i32.TutorUseCase>(() => _i32.TutorUseCase(
        gh<_i30.TutorRepository>(),
        gh<_i17.FeedbackService>(),
        gh<_i19.TutorService>(),
        gh<_i20.UserService>(),
      ));
  gh.factory<_i33.AuthUseCase>(() => _i33.AuthUseCase(
        gh<_i34.AuthenticationRepository>(),
        gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
      ));
  gh.singleton<_i35.AuthenticationBloc>(_i35.AuthenticationBloc(
    gh<_i33.AuthUseCase>(),
    gh<_i14.AuthLocalData>(),
    gh<_i20.UserService>(),
    gh<_i8.GoogleOAuthService>(),
    gh<_i7.FacebookOAuthService>(),
  ));
  gh.factory<_i36.ChatRepository>(
      () => _i37.ChatRepositoryImpl(gh<_i24.ChatService>()));
  gh.singleton<_i38.ChatUseCase>(_i38.ChatUseCase(
    gh<_i36.ChatRepository>(),
    gh<_i3.AppSocket>(),
  ));
  gh.factory<_i39.CourseRepository>(
      () => _i40.CourseRepositoryImpl(courseService: gh<_i26.CourseService>()));
  gh.factory<_i41.CourseUseCase>(() => _i41.CourseUseCase(
        gh<_i39.CourseRepository>(),
        gh<_i16.EbookService>(),
      ));
  gh.factory<_i42.EBookBloc>(() => _i42.EBookBloc(gh<_i41.CourseUseCase>()));
  gh.factory<_i43.ScheduleBloc>(
      () => _i43.ScheduleBloc(gh<_i29.ScheduleUseCase>()));
  gh.factory<_i44.TutorBloc>(() => _i44.TutorBloc(
        gh<_i32.TutorUseCase>(),
        gh<_i29.ScheduleUseCase>(),
      ));
  gh.factory<_i45.TutorDetailBloc>(() => _i45.TutorDetailBloc(
        gh<_i32.TutorUseCase>(),
        gh<_i29.ScheduleUseCase>(),
        gh<_i19.TutorService>(),
      ));
  gh.singleton<_i46.ChatCubit>(_i46.ChatCubit(gh<_i38.ChatUseCase>()));
  gh.singleton<_i47.ChatListCubit>(_i47.ChatListCubit(gh<_i38.ChatUseCase>()));
  gh.factory<_i48.CourseBloc>(() => _i48.CourseBloc(gh<_i41.CourseUseCase>()));
  gh.factory<_i49.CourseDetailBloc>(
      () => _i49.CourseDetailBloc(gh<_i41.CourseUseCase>()));
  gh.factory<_i50.DashboardBloc>(() => _i50.DashboardBloc(
        gh<_i48.CourseBloc>(),
        gh<_i3.AppSocket>(),
        gh<_i42.EBookBloc>(),
        gh<_i44.TutorBloc>(),
        gh<_i43.ScheduleBloc>(),
        gh<_i47.ChatListCubit>(),
        gh<_i35.AuthenticationBloc>(),
        gh<_i38.ChatUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i51.HiveModule {}

class _$DioModule extends _i51.DioModule {}
