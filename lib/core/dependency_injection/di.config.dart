// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/data_source/local/app_local_storage.dart' as _i6;
import '../../data/data_source/local/hive_storage_impl.dart' as _i7;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i3;
import '../components/navigation/routes_service.dart' as _i5;
import 'module.dart' as _i9;

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
  await gh.singletonAsync<_i4.HiveInterface>(
    () => hiveModule.initHive(),
    preResolve: true,
  );
  gh.factory<_i5.RouteService>(() => _i5.RouteService());
  gh.singleton<_i4.Box<dynamic>>(hiveModule.create(gh<_i4.HiveInterface>()));
  gh.singleton<_i6.AppLocalStorage>(
      _i7.HiveStorageImpl(gh<_i4.Box<dynamic>>()));
  gh.singleton<_i8.Dio>(dioModule.create(gh<_i6.AppLocalStorage>()));
  return getIt;
}

class _$HiveModule extends _i9.HiveModule {}

class _$DioModule extends _i9.DioModule {}
