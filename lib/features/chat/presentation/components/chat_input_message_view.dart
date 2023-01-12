import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/features/chat/presentation/cubit/send_message_cubit.dart';
import 'package:foom/features/profile/domain/entities/member.dart';
import 'package:foom/features/profile/presentation/bloc/member_bloc.dart';

import '../../../../core/constants/constants.dart';

class ChatInputMessageView extends StatelessWidget {
  ChatInputMessageView({super.key});

  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Member? member = context.select<MemberBloc, Member?>((bloc) =>
        (bloc.state is MemberUpdateSuccess)
            ? (bloc.state as MemberUpdateSuccess).member
            : null);
    return Positioned(
      bottom: defaultPadding,
      child: Container(
        width: size.width,
        height: 70,
        child: Row(
          children: [
            Flexible(
                child: Container(
              margin: const EdgeInsets.only(left: defaultPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromARGB(255, 49, 93, 128),
              ),
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: TextField(
                controller: _messageController,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'type your message',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            )),
            GestureDetector(
              onTap: () async {
                context
                    .read<SendMessageCubit>()
                    .send(member?.id ?? '', _messageController.text);

                _messageController.clear();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 49, 93, 128),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
