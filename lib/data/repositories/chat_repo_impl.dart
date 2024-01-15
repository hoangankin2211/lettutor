import 'package:either_dart/src/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/data_state.dart';
import 'package:lettutor/data/data_source/remote/api_helper.dart';

import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:lettutor/data/data_source/remote/chat/chat_service.dart';
import 'package:lettutor/data/entities/chat/chat_entity.dart';
import 'package:lettutor/data/entities/chat/recipient_entity.dart';
import 'package:lettutor/domain/repositories/chat_repo.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl extends ChatRepository {
  final ChatService _chatService;

  ChatRepositoryImpl(this._chatService);

  @override
  Future<Either<String, RecipientEntity>> fetchAllRecipient() async {
    final dataState = await getStateOf<RecipientEntity>(
      request: () => _chatService.fetchAllRecipient(),
      parser: (data) => compute(RecipientEntity.fromJson, data),
    );

    if (dataState is DataSuccess) {
      return Right(dataState.data!);
    }
    return Left(dataState.dioException?.message ?? "Error while fetching");
  }

  @override
  Future<Either<String, ChatEntity>> getChatDetail({
    required String infoId,
    ChatQuery chatQueries = const ChatQuery(),
  }) async {
    final dataState = await getStateOf<ChatEntity>(
      request: () => _chatService.fetchAllMessage(
        infoId: infoId,
        chatQueries: chatQueries,
      ),
      parser: (data) => compute(ChatEntity.fromJson, data),
    );

    if (dataState is DataSuccess) {
      return Right(dataState.data!);
    }
    return Left((dataState.statusCode == 400
            ? dataState.dioException?.response?.data["message"]
            : dataState.dioException?.message) ??
        "Error while get chat detail");
  }
}
