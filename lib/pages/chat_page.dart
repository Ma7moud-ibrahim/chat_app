import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/caht_buble.dart';
import 'package:chat_app/widgets/chat_buble_friend.dart';
import 'package:chat_app/widgets/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static String id = 'chatPage';

  final TextEditingController controller = TextEditingController();

  final _controller = ScrollController();
  List<Message> messageList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          messageList = state.message;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(kLogo, width: 60, height: 60),
                const SizedBox(width: 8),
                const Text(
                  'Chat',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    if (email == messageList[index].id) {
                      return ChatBuble(meassage: messageList[index]);
                    } else {
                      return ChatBubleForFriend(meassage: messageList[index]);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) async {
                    if (data.trim().isNotEmpty) {
                      sendMessage(context, email.toString());
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        sendMessage(context, email.toString());
                      },
                      icon: const Icon(Icons.send),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void sendMessage(context, String email) {
    if (controller.text.trim().isNotEmpty) {
      BlocProvider.of<ChatCubit>(
        context,
      ).sendMesage(message: controller.text, email: email);
      controller.clear();
      _controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
