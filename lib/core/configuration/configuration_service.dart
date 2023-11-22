import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lettutor/core/logger/custom_logger.dart';

const String prodConfigUrl = "assets/config/prod_config.json";
const String devConfigUrl = "assets/config/dev_config.json";

Map<String, String>? _getHeader(Map jsonHeader) {
  try {
    return Map.castFrom<dynamic, dynamic, String, String>(jsonHeader);
  } on Exception catch (e) {
    logger.e(e);
    return {
      "Accept": "application/json, text/plain, */*",
      "Accept-Encoding": "gzip, deflate, br",
      "Accept-Language": "en-US,en;q=0.9",
      "Content-Type": "application/json",
      "Origin": "https://sandbox.app.lettutor.com",
      "Referer": "https://sandbox.app.lettutor.com/",
      "Sec-Ch-Ua": "Microsoft Edge;v=117, Not;A=Brand;v=8, Chromium;v=117",
      "Sec-Ch-Ua-Mobile": "?1",
      "Sec-Ch-Ua-Platform": "Android",
      "Sec-Fetch-Dest": "empty",
      "Sec-Fetch-Mode": "cors",
      "Sec-Fetch-Site": "same-site"
    };
  }
}

Future<Map<String, dynamic>> getConfigFromJson(String fileConfig) async {
  final String response = await rootBundle.loadString(fileConfig);
  final config = await json.decode(response);
  return {
    'name': config['name'],
    'environment': config['environment'],
    'baseUrl': config['baseUrl'],
    "header": _getHeader(config['header']),
    "primaryColor": config['primaryColor'],
    "enableRemoteConfigFirebase": config['enableRemoteConfigFirebase'],
    "enableFirebaseAnalytics": config['enableFirebaseAnalytics'],
    "countryCodeDefault": config['countryCodeDefault'],
  };
}
