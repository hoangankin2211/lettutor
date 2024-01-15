import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/core.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/data/entities/chat/message_entity.dart';
import 'package:lettutor/ui/chat/bloc/chat_list_cubit.dart';
import 'package:lettutor/ui/chat/bloc/chat_list_state.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  ChatListCubit get _chatListCubit => BlocProvider.of<ChatListCubit>(context);

  @override
  void initState() {
    super.initState();
    if (_chatListCubit.state is ChatListInitial) {
      _chatListCubit.loadChats();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocConsumer<ChatListCubit, ChatListState>(
      bloc: _chatListCubit,
      listener: (context, state) {
        if (state is ChatListError) {
          context.showSnackBarAlert(state.message);
        }
      },
      builder: (context, state) {
        return Material(child: _buildListView(state));
      },
    );
  }

  Widget buildSupportWidget() {
    return Container(
      height: 100,
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      width: context.width,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hotline",
                style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "0945337337",
                style: context.textTheme.titleLarge
                    ?.copyWith(color: context.colorScheme.onPrimary),
              ),
            ],
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              backgroundColor: context.colorScheme.onPrimary,
              foregroundColor: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.message, color: context.colorScheme.primary),
            label: Text(
              "Messenger",
              style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListView(ChatListState chatListState) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10, top: 30),
      child: Column(
        children: [
          buildSupportWidget(),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _chatListCubit.loadChats,
              child: chatListState is ChatListLoading
                  ? const AppLoadingIndicator()
                  : chatListState.recipient.messages.isNotEmpty
                      ? ListView.separated(
                          itemCount: chatListState.recipient.messages.length,
                          separatorBuilder: (context, position) {
                            return const SizedBox(height: 5);
                          },
                          itemBuilder: (context, position) {
                            final messageEntity =
                                chatListState.recipient.messages[position];
                            return _buildListItem(
                              messageEntity,
                              isSelected: false,
                            );
                          },
                        )
                      : const Expanded(
                          child: Center(child: Text("No Thread Found"))),
            ),
          ),
          Divider(
            height: 10,
            thickness: 1,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(MessageEntity messageEntity,
      {bool isSelected = false}) {
    return ListTile(
      onTap: () {
        if (messageEntity.partner != null) {
          context.push(RouteLocation.chatScreen, extra: {
            "messageEntity": messageEntity,
            "partnerId": messageEntity.partner!.id,
          });
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      leading: CircleAvatar(
          radius: 25,
          foregroundImage: NetworkImage(messageEntity.partner!.avatar!)),
      tileColor: isSelected
          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
          : null,
      subtitle: Text(
        messageEntity.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
      ),
      title: Text(
        messageEntity.partner!.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
