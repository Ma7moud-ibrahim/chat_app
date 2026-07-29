// import 'package:chat_app/models/message.dart';
// import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
// import 'package:chat_app/widgets/caht_buble.dart';
// import 'package:chat_app/widgets/chat_buble_friend.dart';
// import 'package:chat_app/widgets/constant.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// final TextEditingController controller = TextEditingController();
// var _controller = ScrollController();

// void sendMessage(String email) {
//   String message = controller.text;

//   if (message.trim().isNotEmpty) {
//     context.read<ChatCubit>().sendMesage(
//       message: message,
//       email: email,
//     );

//     controller.clear();

//     scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }
// }
