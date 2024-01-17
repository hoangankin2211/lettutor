import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
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
          .setExtraHeaders({
            "Host": "sandbox.api.lettutor.com",
            "connection": "Upgrade",
            "Origin": "https://sandbox.app.lettutor.com",
            "Pragma": "no-cache",
            "Cache-Control": "no-cache",
            "Upgrade": "websocket",
            "Sec-WebSocket-Version": "13",
            "Sec-WebSocket-Extensions":
                "permessage-deflate; client_max_window_bits",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "en-US,en;q=0.9"
          })
          .setReconnectionAttempts(10)
          .setReconnectionDelay(1000)
          .setReconnectionDelayMax(5000)
          .setRandomizationFactor(0.5)
          .enableAutoConnect()
          .enableReconnection()
          .build(),
    );

    _socket!.connect();

    _socket?.onConnect((data) {
      logger.d(data);
    });

    _socket?.onclose((data) {
      logger.d("onclose: $data");
    });

    _socket?.onAny((event, data) => logger.d(event + data.toString()));

    _socket?.onError((data) => {logger.d("onError: $data")});

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
