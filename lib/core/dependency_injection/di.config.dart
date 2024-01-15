// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i9;
import '../../data/data_source/local/authentication/auth_local_data.dart'
    as _i12;
import '../../data/data_source/local/hive_storage_impl.dart' as _i10;
import '../../data/data_source/remote/authentication/authentication.dart'
    as _i4;
import '../../data/data_source/remote/authentication/email/email_auth_api.dart'
    as _i19;
import '../../data/data_source/remote/authentication/facebook/facebook_auth_impl.dart'
    as _i5;
import '../../data/data_source/remote/authentication/google/google_auth_impl.dart'
    as _i6;
import '../../data/data_source/remote/chat/chat_service.dart' as _i22;
import '../../data/data_source/remote/chore/chores_service.dart' as _i23;
import '../../data/data_source/remote/course/course_service.dart' as _i24;
import '../../data/data_source/remote/ebook/ebook_service.dart' as _i14;
import '../../data/data_source/remote/review/feedback_service.dart' as _i15;
import '../../data/data_source/remote/schedule/schedule_service.dart' as _i16;
import '../../data/data_source/remote/tutorial/tutor_service.dart' as _i17;
import '../../data/data_source/remote/user/user_service.dart' as _i18;
import '../../data/repositories/authentication_repos_impl.dart' as _i21;
import '../../data/repositories/chat_repo_impl.dart' as _i35;
import '../../data/repositories/course_repos_impl.dart' as _i38;
import '../../data/repositories/schedule_repos_impl.dart' as _i26;
import '../../data/repositories/tutor_repos_impl.dart' as _i29;
import '../../domain/repositories/authentication_repo.dart' as _i32;
import '../../domain/repositories/chat_repo.dart' as _i34;
import '../../domain/repositories/course_repo.dart' as _i37;
import '../../domain/repositories/repositories.dart' as _i20;
import '../../domain/repositories/schedule_repo.dart' as _i25;
import '../../domain/repositories/tutor_repo.dart' as _i28;
import '../../domain/usecases/auth_usecase.dart' as _i31;
import '../../domain/usecases/chat_usecase.dart' as _i36;
import '../../domain/usecases/course_usecase.dart' as _i39;
import '../../domain/usecases/schedule_usecase.dart' as _i27;
import '../../domain/usecases/tutor_usecase.dart' as _i30;
import '../../ui/auth/blocs/auth_bloc.dart' as _i33;
import '../../ui/chat/bloc/chat_cubit.dart' as _i44;
import '../../ui/chat/bloc/chat_list_cubit.dart' as _i45;
import '../../ui/course/blocs/course_bloc.dart' as _i46;
import '../../ui/course/blocs/course_detail_bloc.dart' as _i47;
import '../../ui/course/blocs/ebook_bloc.dart' as _i40;
import '../../ui/dashboard/blocs/dashboard_bloc.dart' as _i48;
import '../../ui/schedule/bloc/schedule_bloc.dart' as _i41;
import '../../ui/tutor/blocs/tutor_bloc.dart' as _i42;
import '../../ui/tutor/blocs/tutor_detail_bloc.dart' as _i43;
import '../utils/blocs/app_bloc.dart/application_bloc.dart' as _i11;
import '../utils/navigation/routes_service.dart' as _i8;
import '../utils/networking/socket/app_socket.dart' as _i3;
import 'module.dart' as _i49;

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
  gh.factory<_i11.ApplicationBloc>(
      () => _i11.ApplicationBloc(gh<_i9.AppLocalStorage>()));
  gh.factory<_i12.AuthLocalData>(
      () => _i12.AuthLocalData(gh<_i9.AppLocalStorage>()));
  gh.singleton<_i13.Dio>(dioModule.create(gh<_i9.AppLocalStorage>()));
  gh.factory<_i14.EbookService>(() => _i14.EbookService(gh<_i13.Dio>()));
  gh.factory<_i15.FeedbackService>(() => _i15.FeedbackService(gh<_i13.Dio>()));
  gh.factory<_i16.ScheduleService>(() => _i16.ScheduleService(gh<_i13.Dio>()));
  gh.factory<_i17.TutorService>(() => _i17.TutorService(gh<_i13.Dio>()));
  gh.factory<_i18.UserService>(() => _i18.UserService(gh<_i13.Dio>()));
  gh.factory<_i4.AuthenticationApi>(
    () => _i19.EmailAuthApi(gh<_i13.Dio>()),
    instanceName: 'EmailAuthApi',
  );
  gh.factory<_i20.AuthenticationRepository>(
      () => _i21.AuthenticationRepositoryImpl(
            gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
            gh<_i9.AppLocalStorage>(),
          ));
  gh.factory<_i22.ChatService>(() => _i22.ChatService(gh<_i13.Dio>()));
  gh.factory<_i23.ChoresService>(
    () => _i23.ChoresService(gh<_i13.Dio>()),
    instanceName: 'ChoresService',
  );
  gh.factory<_i24.CourseService>(() => _i24.CourseService(gh<_i13.Dio>()));
  gh.factory<_i25.ScheduleRepository>(
      () => _i26.ScheduleRepositoryImpl(gh<_i16.ScheduleService>()));
  gh.factory<_i27.ScheduleUseCase>(
      () => _i27.ScheduleUseCase(gh<_i25.ScheduleRepository>()));
  gh.factory<_i28.TutorRepository>(() => _i29.TutorRepositoryImpl(
        gh<_i17.TutorService>(),
        gh<_i15.FeedbackService>(),
      ));
  gh.factory<_i30.TutorUseCase>(() => _i30.TutorUseCase(
        gh<_i28.TutorRepository>(),
        gh<_i15.FeedbackService>(),
        gh<_i17.TutorService>(),
        gh<_i18.UserService>(),
      ));
  gh.factory<_i31.AuthUseCase>(() => _i31.AuthUseCase(
        gh<_i32.AuthenticationRepository>(),
        gh<_i4.AuthenticationApi>(instanceName: 'EmailAuthApi'),
      ));
  gh.singleton<_i33.AuthenticationBloc>(_i33.AuthenticationBloc(
    gh<_i31.AuthUseCase>(),
    gh<_i12.AuthLocalData>(),
    gh<_i18.UserService>(),
  ));
  gh.factory<_i34.ChatRepository>(
      () => _i35.ChatRepositoryImpl(gh<_i22.ChatService>()));
  gh.singleton<_i36.ChatUseCase>(_i36.ChatUseCase(
    gh<_i34.ChatRepository>(),
    gh<_i3.AppSocket>(),
  ));
  gh.factory<_i37.CourseRepository>(
      () => _i38.CourseRepositoryImpl(courseService: gh<_i24.CourseService>()));
  gh.factory<_i39.CourseUseCase>(() => _i39.CourseUseCase(
        gh<_i37.CourseRepository>(),
        gh<_i14.EbookService>(),
      ));
  gh.factory<_i40.EBookBloc>(() => _i40.EBookBloc(gh<_i39.CourseUseCase>()));
  gh.factory<_i41.ScheduleBloc>(
      () => _i41.ScheduleBloc(gh<_i27.ScheduleUseCase>()));
  gh.factory<_i42.TutorBloc>(() => _i42.TutorBloc(
        gh<_i30.TutorUseCase>(),
        gh<_i27.ScheduleUseCase>(),
      ));
  gh.factory<_i43.TutorDetailBloc>(() => _i43.TutorDetailBloc(
        gh<_i30.TutorUseCase>(),
        gh<_i27.ScheduleUseCase>(),
        gh<_i17.TutorService>(),
      ));
  gh.singleton<_i44.ChatCubit>(_i44.ChatCubit(gh<_i36.ChatUseCase>()));
  gh.singleton<_i45.ChatListCubit>(_i45.ChatListCubit(gh<_i36.ChatUseCase>()));
  gh.factory<_i46.CourseBloc>(() => _i46.CourseBloc(gh<_i39.CourseUseCase>()));
  gh.factory<_i47.CourseDetailBloc>(
      () => _i47.CourseDetailBloc(gh<_i39.CourseUseCase>()));
  gh.factory<_i48.DashboardBloc>(() => _i48.DashboardBloc(
        gh<_i46.CourseBloc>(),
        gh<_i3.AppSocket>(),
        gh<_i40.EBookBloc>(),
        gh<_i42.TutorBloc>(),
        gh<_i41.ScheduleBloc>(),
        gh<_i45.ChatListCubit>(),
        gh<_i33.AuthenticationBloc>(),
        gh<_i36.ChatUseCase>(),
      ));
  return getIt;
}

class _$HiveModule extends _i49.HiveModule {}

class _$DioModule extends _i49.DioModule {}
