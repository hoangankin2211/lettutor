import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:retrofit/retrofit.dart';
part 'chat_service.g.dart';

@injectable
@RestApi()
abstract class ChatService {
  static const String branch = "/message";
  static const String getAllRecipientApi = "$branch/get-all-recipient";
  static const String getAllMessageApi = "$branch/get";

  @factoryMethod
  factory ChatService(Dio dio) = _ChatService;

  @GET(getAllRecipientApi)
  Future<HttpResponse> fetchAllRecipient();

  @GET("$getAllMessageApi/{id}")
  Future<HttpResponse> fetchAllMessage({
    @Path("id") required String infoId,
    @Queries() required ChatQuery chatQueries,
  });
}
