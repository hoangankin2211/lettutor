import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:lettutor/data/entities/chat/chat_entity.dart';

abstract class ChatState {
  final ChatEntity chatEntity;
  final ChatQuery chatQuery;
  ChatState(this.chatEntity, {this.chatQuery = const ChatQuery()});
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

class LoadMoreChat extends ChatState {
  LoadMoreChat(ChatEntity chatEntity, ChatQuery chatQuery)
      : super(chatEntity, chatQuery: chatQuery);
}

class LoadingMoreChat extends ChatState {
  LoadingMoreChat(ChatEntity chatEntity) : super(chatEntity);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message) : super(ChatEntity());
}

class NewChatMessage extends ChatState {
  NewChatMessage(ChatEntity chatEntity) : super(chatEntity);
}
