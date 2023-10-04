// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String role;
  final String message;
  final bool isSuccess;
  final int expiredTime;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.message,
    required this.isSuccess,
    required this.expiredTime,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  AuthResponse copyWith({
    String? accessToken,
    String? refreshToken,
    String? role,
    String? message,
    bool? isSuccess,
    int? expiredTime,
  }) {
    return AuthResponse(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      role: role ?? this.role,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
      expiredTime: expiredTime ?? this.expiredTime,
    );
  }

  @override
  bool operator ==(covariant AuthResponse other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.role == role &&
        other.message == message &&
        other.isSuccess == isSuccess &&
        other.expiredTime == expiredTime;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        refreshToken.hashCode ^
        role.hashCode ^
        message.hashCode ^
        isSuccess.hashCode ^
        expiredTime.hashCode;
  }
}
