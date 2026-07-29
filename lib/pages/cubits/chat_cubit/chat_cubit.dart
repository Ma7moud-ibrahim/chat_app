import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  void sendMesage({required String message, required String email}) {
    try {
      messages.add({
        kmessage: message.trim(),
        kCreatedAt: DateTime.now(),
        kEmail: email,
      });
    } on Exception {
      //
    }
  }

  void rceveMessage() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];

      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(message: messageList));
    });
  }
}
