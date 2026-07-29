import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:flutter/material.dart';

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({super.key, required this.meassage});

  final Message meassage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),

          color: kPrimaryColor,
        ),

        child: Text(
          meassage.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
