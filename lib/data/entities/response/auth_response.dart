// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lettutor/data/entities/token_entity.dart';
import 'package:lettutor/data/entities/user_entity.dart';

class AuthResponse {
  final UserEntity user;
  final TokenEntity tokens;
  AuthResponse({
    required this.user,
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'tokens': tokens.toMap(),
    };
  }

  factory AuthResponse.fromJson(Map<String, dynamic> map) {
    return AuthResponse(
      user: UserEntity.fromJson(map['user'] as Map<String, dynamic>),
      tokens: TokenEntity.fromJson(map['tokens'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());
}
