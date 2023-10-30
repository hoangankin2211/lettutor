import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'ebook_service.g.dart';

@injectable
@RestApi()
abstract class EbookService {
  static const String getEbookData = "/e-book";

  @factoryMethod
  factory EbookService(Dio dio) = _EbookService;

  @GET(getEbookData)
  Future<HttpResponse> getEbook(
      {@Queries() required Map<String, dynamic> queries});
}
