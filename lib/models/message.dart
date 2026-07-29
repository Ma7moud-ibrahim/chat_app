import 'package:chat_app/widgets/constant.dart';

class Message {
  final String message;
  final String? id;

  Message({required this.message, this.id});
  factory Message.fromJson(jsonData) {
    return Message(message: jsonData[kmessage], id: jsonData['id']);
  }
}
