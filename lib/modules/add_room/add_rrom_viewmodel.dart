import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/models/room.dart';

import '../../database/database_utils.dart';
import 'add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void CreateRoom(String roomName, String roomDescription, String catId) {
    Room room = Room(
        roomName: roomName, roomDescription: roomDescription, catId: catId);
    DataBaseUtils.addRoomToFirebase(room).then((value) {
      navigator!.roomCreated();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
