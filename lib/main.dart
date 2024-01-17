import 'package:lettutor/core/configuration/configuration_service.dart';
import 'app_init.dart';

void main() {
  const flavor = String.fromEnvironment("flavor", defaultValue: "dev");
  print(flavor);
  if (flavor == "dev") {
    AppBuilder.run(devConfigUrl);
  } else if (flavor == "prod") {
    AppBuilder.run(prodConfigUrl);
  } else {
    throw Exception("Invalid flavor");
  }
}
