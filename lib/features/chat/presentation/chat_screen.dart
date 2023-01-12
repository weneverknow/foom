import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foom/core/constants/constants.dart';
import 'package:foom/core/widgets/dialog_widget.dart';
import 'package:foom/features/chat/presentation/components/chat_input_message_view.dart';
import 'package:foom/features/chat/presentation/components/chat_message_view.dart';
import 'package:foom/features/chat/presentation/cubit/send_message_cubit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<SendMessageCubit, String?>(
      listener: (context, state) async {
        if (state != null) {
          await showErrorDialog(context, title: "Failed", message: state);
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 14, 77, 128),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "You are on chat with Foom Admin",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: size.width, maxHeight: size.height * 0.75),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        ChatMessageView(),
                      ],
                    ),
                  ),
                ),
              ),
              ChatInputMessageView(),
            ],
          ),
        ),
        //bottomNavigationBar: Container(),
      ),
    );
  }
}
