class FeedBackUserModelEntity {
  final String? name;
  final String? avatar;
  FeedBackUserModelEntity({
    this.name,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
    };
  }

  static FeedBackUserModelEntity fromMap(Map<String, dynamic> map) {
    return FeedBackUserModelEntity(
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }
}
