import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/models/room_category.dart';
import 'package:chat_c7_fri/modules/add_room/add_room_navigator.dart';
import 'package:chat_c7_fri/modules/add_room/add_rrom_viewmodel.dart';
import 'package:chat_c7_fri/modules/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "Rooms";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseView<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  var roomNameController = TextEditingController();
  var roomDescriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var categories = RoomCategory.getCategories();
  late RoomCategory roomCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    roomCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
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
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text('Add Room'),
            ),
            body: Card(
              margin: EdgeInsets.symmetric(horizontal: 21, vertical: 42),
              elevation: 16,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Create New Room",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Image.asset("assets/images/create_room_bg.png"),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: roomNameController,
                        decoration: InputDecoration(
                            hintText: "Room Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                        validator: (text) {
                          if (text == null || text == "") {
                            return "Please Enter Room name";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<RoomCategory>(
                        value: roomCategory,
                        items: categories
                            .map((cat) => DropdownMenuItem<RoomCategory>(
                                value: cat,
                                child: Row(
                                  children: [
                                    Image.asset(cat.image),
                                    Text(cat.name)
                                  ],
                                )))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          roomCategory = value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: roomDescriptionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: "Room Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue))),
                        validator: (text) {
                          if (text == null || text == "") {
                            return "Please Enter Room Description";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            validateForm();
                          },
                          child: Text('Create'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.CreateRoom(roomNameController.text,
          roomDescriptionController.text, roomCategory.id);
    }
  }

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();

  @override
  void roomCreated() {
    Navigator.pop(context);
  }
}
