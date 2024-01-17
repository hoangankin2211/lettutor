import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:lettutor/data/entities/chat/chat_entity.dart';
import 'package:lettutor/data/entities/chat/message_entity.dart';
import 'package:lettutor/data/entities/chat/new_message.dart';
import 'package:lettutor/data/entities/chat/send_message.dart';
import 'package:lettutor/domain/usecases/chat_usecase.dart';
import 'package:lettutor/ui/chat/bloc/chat_state.dart';

@singleton
class ChatCubit extends Cubit<ChatState> {
  Key? key = UniqueKey();

  final ChatUseCase _chatUseCase;
  ChatCubit(this._chatUseCase) : super(ChatInitial());

  void connectToSocket() {
    _chatUseCase.getNewMessage().listen(_newMessage);
  }

  Future<void> loadChat({
    required String partnerId,
    ChatQuery chatQueries = const ChatQuery(),
  }) async {
    emit(ChatLoading());
    try {
      (await _chatUseCase.getChatDetail(messageId: partnerId)).either(
        (left) => emit(ChatError(left)),
        (right) => emit(ChatLoaded(right)),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void sendMessage(SendMessage message) {
    _chatUseCase.sendMessage(message);
  }

  void _newMessage(NewMessage newMessage) {
    try {
      final List<MessageEntity> newChatList = List.from(state.chatEntity.rows)
        ..add(MessageEntity.fromNewMessage(newMessage));
      emit(
        NewChatMessage(ChatEntity(
          rows: newChatList,
          count: state.chatEntity.count + 1,
        )),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  void loadMoreChat({
    required String partnerId,
    ChatQuery chatQueries = const ChatQuery(),
  }) async {
    if (state is LoadingMoreChat) return;
    if (state.chatEntity.count == state.chatEntity.rows.length) return;
    emit(LoadingMoreChat(state.chatEntity));
    logger.d(chatQueries.page);
    try {
      (await _chatUseCase.getChatDetail(
              messageId: partnerId, chatQueries: chatQueries))
          .fold(
        (error) => emit(ChatError(error)),
        (chatEntity) {
          final List<MessageEntity> newChatList =
              List.from(state.chatEntity.rows);
          newChatList.addAll(chatEntity.rows);
          emit(
            LoadMoreChat(
              ChatEntity(
                rows: newChatList,
                count: chatEntity.count,
              ),
              chatQueries,
            ),
          );
        },
      );
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> close() {
    _chatUseCase.disconnectNewMessageListener();
    return super.close();
  }
}
