import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

const String _hiveBoxName = 'lettuorBox';

@module
abstract class HiveModule {
  @preResolve
  @singleton
  Future<HiveInterface> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<dynamic>(_hiveBoxName);
    return Hive;
  }

  @singleton
  Box prefs(HiveInterface hive) {
    return hive.box(_hiveBoxName);
  }
}
