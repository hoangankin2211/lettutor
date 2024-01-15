import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/data/entities/chat/message_entity.dart';
import 'package:lettutor/ui/chat/bloc/chat_cubit.dart';
import 'package:lettutor/ui/chat/bloc/chat_state.dart';

class ChatScreen extends StatefulWidget {
  final String partnerId;
  final MessageEntity messageEntity;
  const ChatScreen(
      {super.key, required this.partnerId, required this.messageEntity});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatCubit get _chatCubit => injector.get<ChatCubit>();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _chatCubit.connectToSocket();
    _chatCubit.loadChat(partnerId: widget.partnerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      bloc: _chatCubit,
      listener: (context, state) {
        if (state is ChatError) {
          context.showSnackBarAlert(state.message);
        }
      },
      builder: (context, chatState) => Scaffold(
        appBar: _buildAppBar(),
        body: chatState is ChatLoading
            ? const AppLoadingIndicator()
            : Column(
                children: [
                  Expanded(
                    child: buildListMessage(chatState),
                  ),
                  InputWidget(
                    isListening: false,
                    micAvailable: true,
                    onSubmitted: () {
                      // _streamController.add();
                      if (_textEditingController.text.isNotEmpty) {
                        // _messageStore.sendMessage(
                        //   message: _textEditingController.value.text,
                        //   role: Role.user,
                        // );
                        _textEditingController.clear();
                      }
                    },
                    onVoiceStart: () {},
                    onVoiceStop: () {},
                    textEditingController: _textEditingController,
                  ),
                ],
              ),
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundImage: NetworkImage(
              widget.messageEntity.partner!.avatar!,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            widget.messageEntity.partner!.name,
          ),
        ],
      ),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      _buildReloadButton(),
    ];
  }

  Widget _buildReloadButton() {
    return IconButton(
      onPressed: () {
        _chatCubit.loadChat(partnerId: widget.partnerId);
      },
      icon: const Icon(Icons.refresh),
    );
  }

  Widget buildItem(
    String senderId,
    String sender,
    String message,
    String time, {
    bool isLoading = false,
  }) {
    return Row(
      textDirection:
          senderId == widget.partnerId ? TextDirection.ltr : TextDirection.rtl,
      children: [
        Column(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                minWidth: MediaQuery.of(context).size.width * 0.2,
              ),
              decoration: BoxDecoration(
                color: senderId == widget.partnerId
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sender,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.hintColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    message,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: senderId == widget.partnerId
                          ? Theme.of(context).colorScheme.onBackground
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
            ),
            Text(
              time,
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.theme.hintColor),
            )
          ],
        ),
      ],
    );
  }

  Widget buildListMessage(ChatState chatState) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      reverse: true,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: ScrollController(),
      itemBuilder: (context, index) {
        final message = chatState.chatEntity.rows[index];
        return buildItem(
          message.fromInfo.id,
          message.fromInfo.name,
          message.content,
          intl.DateFormat('dd MMM kk:mm')
              .format(DateTime.parse(message.createdAt)),
        );
      },
      itemCount: chatState.chatEntity.rows.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
    );
  }
}

class InputWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onSubmitted;
  final bool isListening;
  final Function() onVoiceStart;
  final Function() onVoiceStop;
  final bool micAvailable;

  const InputWidget({
    required this.textEditingController,
    required this.onSubmitted,
    required this.isListening,
    required this.onVoiceStart,
    required this.onVoiceStop,
    required this.micAvailable,
    super.key,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(28),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: !widget.isListening
              //       ? widget.onVoiceStart
              //       : widget.onVoiceStop,
              //   padding: const EdgeInsets.only(bottom: 8),
              //   icon:
              //       //  widget.isListening
              //       //     ? const ListeningIcon()
              //       //     :
              //       Icon(
              //     micIcon,
              //     color: Theme.of(context).hintColor,
              //   ),
              // ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onBackground,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 0),
                    suffixIcon: IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        widget.textEditingController.clear();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(28),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                      ),
                    ),
                    hintText:
                        widget.isListening ? 'Listening...' : 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(28),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      ),
                    ),
                  ),
                  controller: widget.textEditingController,
                  onSubmitted: (value) {
                    widget.onSubmitted.call();
                  },
                ),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).buttonTheme.colorScheme!.primary,
                  ),
                ),
                padding: const EdgeInsets.only(left: 0, right: 4),
                icon: const Icon(Icons.send_rounded),
                color: Colors.white,
                onPressed: () {
                  if (!widget.isListening) {
                    widget.onSubmitted.call();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
