import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/entities/chat/message_entity.dart';
import 'package:lettutor/data/entities/chat/new_message.dart';
import 'package:lettutor/domain/usecases/chat_usecase.dart';
import 'package:lettutor/ui/chat/bloc/chat_list_state.dart';

@singleton
class ChatListCubit extends Cubit<ChatListState> {
  final ChatUseCase _chatUseCase;
  Key key = UniqueKey();

  ChatListCubit(this._chatUseCase) : super(ChatListInitial());

  void connectSocket() {
    _chatUseCase.getNewMessage().listen(_newInbox);
  }

  Future<void> loadChats() async {
    emit(ChatListLoading(
      recipient: state.recipient,
      selectedChatId: state.selectedChatId,
    ));

    try {
      await _chatUseCase.fetchAllRecipient().either(
        (left) => emit(
            ChatListError(message: left, selectedChatId: state.selectedChatId)),
        (right) {
          final _selectedChatId = state.selectedChatId.isEmpty
              ? (right.messages.isNotEmpty ? right.messages.first.id : "")
              : state.selectedChatId;
          emit(ChatListLoaded(
              recipient: right, selectedChatId: _selectedChatId));
        },
      );
    } catch (e) {
      emit(ChatListError(
          message: e.toString(), selectedChatId: state.selectedChatId));
    }
  }

  Future<void> _newInbox(NewMessage newMessage) async {
    try {
      emit(
        ChatListLoaded(
            recipient: state.recipient.copyWith(
              unreadCount: state.recipient.unreadCount + 1,
              messages: List.from(state.recipient.messages)
                ..add(MessageEntity.fromNewMessage(newMessage)),
            ),
            selectedChatId: state.selectedChatId),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> selectChat(String chatId) async {
    emit(
      ChatListLoaded(recipient: state.recipient, selectedChatId: chatId),
    );
  }

  @override
  Future<void> close() {
    _chatUseCase.disconnectNewMessageListener(key: key);
    return super.close();
  }
}
