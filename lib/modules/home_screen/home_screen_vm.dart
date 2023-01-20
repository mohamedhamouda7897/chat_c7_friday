import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/database/database_utils.dart';
import 'package:chat_c7_fri/modules/home_screen/home_navigator.dart';

import '../../models/room.dart';

class HomeScreenViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void getRoom() async {
    try {
      rooms = await DataBaseUtils.getRoomFromFirebase();

      print(rooms.length);
    } catch (e) {
      navigator!.showMessage(e.toString());
    }
  }
}
