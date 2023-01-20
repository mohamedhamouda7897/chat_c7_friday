import 'package:chat_c7_fri/models/room.dart';
import 'package:chat_c7_fri/modules/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName, arguments: room);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/${room.catId}.jpeg",
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * .35,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(room.roomName)
          ],
        ),
      ),
    );
  }
}
