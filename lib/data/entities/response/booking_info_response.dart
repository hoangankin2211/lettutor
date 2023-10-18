import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';

class BookingResponse {
  final String status;
  final int count;
  final List<BookingInfoEntity> booking;
  BookingResponse(this.status, this.count, this.booking);

  factory BookingResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return BookingResponse('Error', 0, List.empty());
    return BookingResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => BookingInfoEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
