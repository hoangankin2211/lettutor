// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/data/entities/chat/recipient_entity.dart';

abstract class ChatListState {
  RecipientEntity recipient;
  final String selectedChatId;
  ChatListState(this.recipient, {this.selectedChatId = ""});
}

class ChatListInitial extends ChatListState {
  ChatListInitial()
      : super(RecipientEntity(messages: List.empty(), unreadCount: 0));
}

class ChatListLoading extends ChatListState {
  ChatListLoading({
    required RecipientEntity recipient,
    required String selectedChatId,
  }) : super(recipient, selectedChatId: selectedChatId);
}

class ChatListLoaded extends ChatListState {
  ChatListLoaded({
    required RecipientEntity recipient,
    required String selectedChatId,
  }) : super(recipient, selectedChatId: selectedChatId);
}

class ChatListError extends ChatListState {
  final String message;
  ChatListError({
    required this.message,
    required String selectedChatId,
  }) : super(
          RecipientEntity(messages: List.empty(), unreadCount: 0),
          selectedChatId: selectedChatId,
        );
}
