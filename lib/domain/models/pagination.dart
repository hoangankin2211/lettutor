// ignore_for_file: public_member_api_docs, sort_constructors_first
class Pagination<T> {
  final int count;
  final int perPage;
  final int currentPage;
  final List<T> rows;

  Pagination({
    this.count = 0,
    this.perPage = 10,
    this.currentPage = 1,
    required this.rows,
  });

  Pagination<T> copyWith({
    int? count,
    int? perPage,
    int? currentPage,
    List<T>? rows,
  }) {
    return Pagination<T>(
      count: count ?? this.count,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      rows: rows ?? this.rows,
    );
  }
}
