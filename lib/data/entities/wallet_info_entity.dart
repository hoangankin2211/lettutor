// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WalletInfoEntity {
  final String id;
  final String userId;
  final String amount;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;
  final int bonus;

  WalletInfoEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    required this.bonus,
  });

  WalletInfoEntity copyWith({
    String? id,
    String? userId,
    String? amount,
    bool? isBlocked,
    String? createdAt,
    String? updatedAt,
    int? bonus,
  }) {
    return WalletInfoEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bonus: bonus ?? this.bonus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'amount': amount,
      'isBlocked': isBlocked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'bonus': bonus,
    };
  }

  factory WalletInfoEntity.fromMap(Map<String, dynamic> map) {
    return WalletInfoEntity(
      id: map['id'] as String,
      userId: map['userId'] as String,
      amount: map['amount'] as String,
      isBlocked: map['isBlocked'] as bool,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      bonus: map['bonus'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletInfoEntity.fromJson(String source) =>
      WalletInfoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WalletInfoEntity(id: $id, userId: $userId, amount: $amount, isBlocked: $isBlocked, createdAt: $createdAt, updatedAt: $updatedAt, bonus: $bonus)';
  }

  @override
  bool operator ==(covariant WalletInfoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.amount == amount &&
        other.isBlocked == isBlocked &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.bonus == bonus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        amount.hashCode ^
        isBlocked.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        bonus.hashCode;
  }
}
