import 'package:either_dart/either.dart';
import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:lettutor/data/entities/chat/chat_entity.dart';
import 'package:lettutor/data/entities/chat/recipient_entity.dart';

abstract class ChatRepository {
  Future<Either<String, RecipientEntity>> fetchAllRecipient();

  Future<Either<String, ChatEntity>> getChatDetail({
    required String infoId,
    ChatQuery chatQueries = const ChatQuery(),
  });
}
