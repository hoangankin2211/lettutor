// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lettutor/core/components/extensions/extensions.dart';

class TokenEntity {
  final TokenInfo access;
  final TokenInfo refresh;

  TokenEntity({required this.access, required this.refresh});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access': access.toMap(),
      'refresh': refresh.toMap(),
    };
  }

  factory TokenEntity.fromJson(Map<String, dynamic> map) {
    return TokenEntity(
      access: TokenInfo.fromMap(
          (map['access'] as Map<dynamic, dynamic>).convertMapDynamicToString()),
      refresh: TokenInfo.fromMap((map['refresh'] as Map<dynamic, dynamic>)
          .convertMapDynamicToString()),
    );
  }
}

class TokenInfo {
  final String token;
  final String expires;

  TokenInfo({required this.token, required this.expires});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'expires': expires,
    };
  }

  factory TokenInfo.fromMap(Map<String, dynamic> map) {
    return TokenInfo(
      token: map['token'] as String,
      expires: map['expires'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenInfo.fromJson(String source) =>
      TokenInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
