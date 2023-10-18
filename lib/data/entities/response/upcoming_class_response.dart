import 'package:lettutor/data/entities/schedule/booking_info_entity.dart';

class UpcomingClassResponse {
  final String message;
  final List<BookingInfoEntity> data;

  UpcomingClassResponse(this.message, this.data);

  factory UpcomingClassResponse.fromJson(Map<String, dynamic> data) {
    return UpcomingClassResponse(
      data['message']?.toString() ?? 'Error',
      data['data'] != null
          ? ((data['data']) as List<dynamic>)
              .map((e) => BookingInfoEntity.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}
