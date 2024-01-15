import 'package:lettutor/data/entities/chat/chat_entity.dart';

abstract class ChatState {
  final ChatEntity chatEntity;

  ChatState(this.chatEntity);
}

class ChatInitial extends ChatState {
  ChatInitial() : super(ChatEntity());
}

class ChatLoading extends ChatState {
  ChatLoading() : super(ChatEntity());
}

class ChatLoaded extends ChatState {
  ChatLoaded(ChatEntity chatEntity) : super(chatEntity);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message) : super(ChatEntity());
}

class NewChatMessage extends ChatState {
  NewChatMessage(ChatEntity chatEntity) : super(chatEntity);
}
