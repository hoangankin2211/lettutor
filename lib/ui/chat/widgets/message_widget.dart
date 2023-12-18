import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key,
      required this.message,
      required this.date,
      required this.onLeftSwipe,
      required this.repliedText,
      required this.username,
      required this.isSeen});

  final String message;
  final String date;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final bool isSeen;

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: (details) => onLeftSwipe(),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
            minWidth: MediaQuery.of(context).size.width / 3.5,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Color.fromRGBO(5, 96, 98, 1),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: true
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      // if (isReplying) ...[
                      //   Text(
                      //     username,
                      //     style: const TextStyle(fontWeight: FontWeight.bold),
                      //   ),
                      //   const SizedBox(height: 3),
                      //   Container(
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //       color: backgroundColor.withOpacity(0.5),
                      //       borderRadius: const BorderRadius.all(
                      //         Radius.circular(5),
                      //       ),
                      //     ),
                      //     child: DisplayMessage(
                      //       msg: repliedText,
                      //       type: repliedMsgType,
                      //     ),
                      //   ),
                      //   const SizedBox(height: 8),
                      // ],
                      DisplayMessage(
                        msg: message,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isSeen ? Icons.done_all : Icons.done,
                        size: 20,
                        color: isSeen ? Colors.blue : Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DisplayMessage extends StatelessWidget {
  final String msg;
  const DisplayMessage({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: const TextStyle(fontSize: 16),
    );
  }
}
