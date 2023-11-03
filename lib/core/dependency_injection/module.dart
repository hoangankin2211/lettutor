import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/network.dart';
import 'package:lettutor/data/data_source/local/app_local_storage.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../configuration/configuration.dart';

const String _hiveBoxName = 'lettuorBox';

//Add dio to locator so that it can be injected to the service needed
@module
abstract class DioModule {
  @singleton
  Dio create(AppLocalStorage appStorage) =>
      NetworkService.initializeDio(baseUrl: Configurations.baseUrl);
}

//Add hive to locator so that it can be injected to the service needed
@module
abstract class HiveModule {
  //await the method in the get it initialize so that get the box synchronize
  @preResolve
  @singleton
  Future<HiveInterface> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<dynamic>(_hiveBoxName);
    return Hive;
  }

  @singleton
  Box create(HiveInterface hive) {
    return hive.box(_hiveBoxName);
  }
}
