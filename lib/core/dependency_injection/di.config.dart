// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/local/app_local_storage.dart' as _i3;
import '../../data/local/hive_storage_impl.dart' as _i4;
import '../components/blocs/app_bloc.dart/application_bloc.dart' as _i6;
import '../components/navigation/routes_service.dart' as _i8;
import '../components/networking/network.dart' as _i7;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppLocalStorage>(
      _i4.HiveStorageImpl(gh<_i5.Box<dynamic>>()));
  gh.factory<_i6.ApplicationBloc>(
      () => _i6.ApplicationBloc(gh<_i6.ApplicationState>()));
  gh.factory<_i7.NetworkService>(() => _i7.NetworkService());
  gh.factory<_i8.RouteService>(() => _i8.RouteService());
  return getIt;
}
