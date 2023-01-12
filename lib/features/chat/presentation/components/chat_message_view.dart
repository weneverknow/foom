import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/core/format/format.dart';
import 'package:foom/features/chat/domain/entities/chat.dart';
import 'package:foom/features/profile/domain/entities/member.dart';
import 'package:foom/features/profile/presentation/bloc/member_bloc.dart';
import 'package:foom/service_locator.dart';

import '../../domain/usecase/stream_user_chat.dart';

class ChatMessageView extends StatelessWidget {
  ChatMessageView({this.isMe = true, super.key});
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Member? member = context.select<MemberBloc, Member?>((bloc) =>
        (bloc.state is MemberUpdateSuccess)
            ? (bloc.state as MemberUpdateSuccess).member
            : null);
    return Container(
      width: size.width,
      height: size.height * 0.75,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 226, 230, 235),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(defaultPadding / 2),
      child: StreamBuilder<List<Chat>?>(
          stream: sl<StreamUserChat>().stream(member?.id ?? ''),
          builder: (context, snapshot) {
            if (!snapshot.hasData || (snapshot.data ?? []).isEmpty) {
              return Center(
                child: Text("chat not found"),
              );
            }
            List<Chat> chats = snapshot.data!;
            print("[ChatMessageView] $chats");
            chats.sort((chat1, chat2) => chat1.date!.compareTo(chat2.date!));
            return SingleChildScrollView(
              reverse: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: chats
                      .map((chat) => buildMessageCard(context, size,
                          message: chat.message ?? '',
                          timeMessage: chat.date ?? DateTime.now(),
                          isMe: chat.isMe!))
                      .toList()),
            );
            // return ListView.builder(
            //   controller: scrollController,
            //   shrinkWrap: true,
            //   itemCount: chats.length,
            //   itemBuilder: (context, index) => buildMessageCard(context, size,
            //       message: chats[index].message ?? '',
            //       timeMessage: chats[index].date ?? DateTime.now(),
            //       isMe: chats[index].isMe!),
            // );
          }),
    );
  }

  Widget buildMessageCard(
    BuildContext context,
    Size size, {
    required String message,
    required DateTime timeMessage,
    required bool isMe,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding / 2,
        vertical: defaultPadding / 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: defaultPadding / 2,
              bottom: defaultPadding / 4,
            ),
            child: Text(
              Format.inHour(timeMessage),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Container(
            //width: size.width * 0.6,
            constraints: BoxConstraints(
              maxWidth: size.width * 0.6,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2,
              vertical: defaultPadding / 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isMe ? Color.fromARGB(255, 14, 77, 128) : Colors.white,
            ),
            //alignment: Alignment.topLeft,
            child: Text(
              "$message",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        isMe ? Colors.white : Color.fromARGB(255, 14, 77, 128),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
