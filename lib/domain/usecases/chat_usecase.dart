// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/utils/networking/socket/app_socket.dart';
import 'package:lettutor/data/data_source/remote/chat/chat_query.dart';
import 'package:lettutor/data/entities/chat/chat_entity.dart';
import 'package:lettutor/data/entities/chat/new_message.dart';
import 'package:lettutor/data/entities/chat/recipient_entity.dart';
import 'package:lettutor/data/entities/chat/send_message.dart';

import 'package:lettutor/domain/repositories/chat_repo.dart';

@singleton
class ChatUseCase {
  final ChatRepository _chatRepository;
  final AppSocket _appSocket;

  final StreamController<NewMessage> _newMessageController =
      StreamController.broadcast();

  final Map<String, Stream> _streamMap = {};

  ChatUseCase(this._chatRepository, this._appSocket);

  void connectSocket() {
    _appSocket.onNewMessageEvent(_onNewMessage);
  }

  Future<Either<String, RecipientEntity>> fetchAllRecipient() async {
    return await _chatRepository.fetchAllRecipient();
  }

  Future<Either<String, ChatEntity>> getChatDetail({
    required String messageId,
    ChatQuery chatQueries = const ChatQuery(),
  }) async {
    return _chatRepository.getChatDetail(
      infoId: messageId,
      chatQueries: chatQueries,
    );
  }

  void sendMessage(SendMessage message) {
    _appSocket.onSendMessageEvent(message);
  }

  void _onNewMessage(dynamic data) {
    _newMessageController.add(NewMessage.fromJson(data));
  }

  Stream<NewMessage> getNewMessage({Key? key}) {
    if (_streamMap.containsKey(key.toString())) {
      return _streamMap[key.toString()] as Stream<NewMessage>;
    }

    var newMessageStream = _newMessageController.stream;
    _streamMap.addAll({key.toString(): newMessageStream});
    return newMessageStream;
  }

  void disconnectNewMessageListener({Key? key}) {
    _streamMap.remove(key.toString());
  }
}
