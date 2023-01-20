import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/modules/chat/chat_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../models/room.dart';
import '../../providers/user_provider.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = "Chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatViewModel>
    implements ChatNavigator {
  var contentMessageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;

    var provider = Provider.of<UserProvider>(context);
    viewModel.room = room;
    viewModel.myUser = provider.myUser!;
    viewModel.readMessages();
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(room.roomName),
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 62, horizontal: 18),
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
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.readMessages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }
                      var messages =
                          snapshot.data?.docs.map((doc) => doc.data()).toList();

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return MessageWidget(messages![index]);
                        },
                        itemCount: messages?.length ?? 0,
                      );
                    },
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: contentMessageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "Type a message",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            viewModel.SendMessage(
                              contentMessageController.text,
                            );
                          },
                          child: Row(
                            children: [
                              Text("Send"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.send)
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatViewModel initViewModel() => ChatViewModel();

  @override
  void clearContent() {
    contentMessageController.clear();
    setState(() {});
  }
}
