import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/models/models.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

@singleton
class AppSocket {
  Socket? _socket;
  static const String sendMessageEvent = "chat:sendMessage";
  static const String receiveNewMessageEvent = "chat:returnNewMessage";
  static const String connectionLogin = "connection:login";
  static const String onlineTutor = "connection:login";

  User? user;
  final Map<String, Function(dynamic data)> _eventHandlerMap = {};

  initSocket(User user) {
    this.user = user;
  }

  connectSocket() {
    disconnectSocket();
    _socket = io.io(
      "wss://sandbox.api.lettutor.com/socket.io/?EIO=4&transport=websocket",
      io.OptionBuilder()
          .setQuery({"EIO": "4", "transport": "websocket"})
          .setExtraHeaders({
            "Host": "sandbox.api.lettutor.com",
            "Origin": "https://sandbox.api.lettutor.com",
            "Sec-WebSocket-Extensions":
                "permessage-deflate; client_max_window_bits",
            "Sec-WebSocket-Key": "ovE75c6vakEtakQC6yMhtg==",
            "connection": "Upgrade",
            "upgrade": "websocket",
          })
          .setReconnectionAttempts(double.infinity)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setRandomizationFactor(0.5)
          .setTimeout(1000000000000)
          .enableAutoConnect()
          .enableForceNew()
          .enableReconnection()
          .build(),
    );

    _socket!.connect();
    logger.d("connectSocket: ${_socket?.connected}");
    _socket?.onConnect((data) {
      logger.d(data);
    });

    _socket?.onclose((data) {
      logger.d(data);
    });

    _socket?.onAny((event, data) => logger.d(event + data.toString()));

    _socket?.onError((data) => {logger.d(data)});

    _socket?.emit(connectionLogin, user?.toMap());

    _eventHandlerMap.forEach((key, value) {
      _socket?.on(key, value);
    });
  }

  Socket get getSocket {
    if (_socket == null) {
      connectSocket();
    }
    return _socket!;
  }

  void onNewMessageEvent(Function(dynamic data) handler) {
    logger.d("onNewMessageEvent");
    _eventHandlerMap.containsKey(receiveNewMessageEvent)
        ? _eventHandlerMap[receiveNewMessageEvent] = handler
        : _eventHandlerMap.addAll({receiveNewMessageEvent: handler});

    getSocket.on(receiveNewMessageEvent, handler);
  }

  void onSendMessageEvent(dynamic data) {
    if (_socket == null) {
      connectSocket();
    }

    _socket?.emit(sendMessageEvent, data);
  }

  disconnectSocket() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket?.close();
    _socket = null;
  }
}
