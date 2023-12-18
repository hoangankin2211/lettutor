import 'package:flutter/material.dart';
import 'package:lettutor/ui/chat/widgets/list_message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListMessageWidget(),
        ),
        // BottomChatField(
        //   receiverUid: uid,
        //   isGroupChat: isGroupChat,
        // ),
      ],
    );
  }
}
