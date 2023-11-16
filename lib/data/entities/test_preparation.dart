// ignore_for_file: public_member_api_docs, sort_constructors_first

class TestPreparationEntity {
  final int id;
  final String key;
  final String name;

  TestPreparationEntity({
    required this.id,
    required this.key,
    required this.name,
  });

  TestPreparationEntity copyWith({
    int? id,
    String? key,
    String? name,
  }) {
    return TestPreparationEntity(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'name': name,
    };
  }

  factory TestPreparationEntity.fromJson(Map<String, dynamic> map) {
    return TestPreparationEntity(
      id: map['id'] as int,
      key: map['key'] as String,
      name: map['name'] as String,
    );
  }

  @override
  String toString() => 'TestPreparationEntity(id: $id, key: $key, name: $name)';

  @override
  bool operator ==(covariant TestPreparationEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.key == key && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ key.hashCode ^ name.hashCode;
}
