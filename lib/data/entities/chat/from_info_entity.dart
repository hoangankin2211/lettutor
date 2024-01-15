class FromInfoEntity {
  final String id;
  final String name;
  final String? avatar;
  FromInfoEntity({
    required this.id,
    this.name = "",
    this.avatar,
  });

  FromInfoEntity copyWith({
    String? id,
    String? name,
    String? avatar,
  }) {
    return FromInfoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  factory FromInfoEntity.fromJson(Map<String, dynamic> map) {
    return FromInfoEntity(
      id: map['id'] as String? ?? "",
      name: map['name'] as String? ?? "",
      avatar: map['avatar'] as String?,
    );
  }
}
