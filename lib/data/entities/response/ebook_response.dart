import '../ebook_entity.dart';

class EBookResponse {
  final String status;
  final int count;
  final List<EBookEntity> eBoos;
  EBookResponse(this.status, this.count, this.eBoos);

  static EBookResponse fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return EBookResponse('Error', 0, List.empty());
    return EBookResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => EBookEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
