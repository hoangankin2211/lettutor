class Configurations {
  static String _name = DefaultEnv.name;
  static String _environment = DefaultEnv.environment;
  static String _baseUrl = DefaultEnv.baseUrl;

  static void setConfigurationValues(Map<String, dynamic> value) {
    _name = value['name'] ?? DefaultEnv.name;
    _environment = value['environment'] ?? DefaultEnv.environment;
    _baseUrl = value['baseUrl'] ?? DefaultEnv.baseUrl;
  }

  static String get name => _name;

  static String get environment => _environment;

  static String get baseUrl => _baseUrl;
}

class DefaultEnv {
  static String name = "";
  static String environment = "";
  static String baseUrl = "";
}
