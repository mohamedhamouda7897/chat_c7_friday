import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/database/database_utils.dart';
import 'package:chat_c7_fri/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/my_user.dart';
import '../../models/room.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void SendMessage(String content) {
    Message message = Message(
        content: content,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        roomId: room.id,
        senderName: myUser.userName,
        senderId: myUser.id);
    DataBaseUtils.addMessageToFirestore(message).then((value) {
      navigator!.clearContent();
    });
  }

  Stream<QuerySnapshot<Message>> readMessages() {
    return DataBaseUtils.readMessagesFromFirebase(room.id);
  }
}

abstract class ChatNavigator extends BaseNavigator {
  void clearContent();
}
