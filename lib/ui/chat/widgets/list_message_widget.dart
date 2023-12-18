import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/ui/chat/widgets/message_widget.dart';

class ListMessageWidget extends StatelessWidget {
  const ListMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return MessageWidget(
            message: "Hello",
            date: DateFormat.ABBR_MONTH,
            repliedText: "repliedText",
            username: "msgData.repliedTo",
            onLeftSwipe: () {},
            isSeen: false,
          );
        }
        // return SenderMessageCard(
        //   message: msgData.text,
        //   date: timeSent,
        //   type: msgData.type,
        //   repliedText: msgData.repliedMessage,
        //   username: msgData.repliedTo,
        //   repliedMsgType: msgData.repliedMessageType,
        //   onRightSwipe: () => onMessageSwipe(
        //     msgData.text,
        //     false,
        //     msgData.type,
        //   ),
        );
  }
}

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final String repliedMessage;
  final String repliedTo;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      repliedMessage: map['repliedMessage'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
    );
  }
}
