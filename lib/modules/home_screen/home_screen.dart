import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/modules/add_room/add_room_screen.dart';
import 'package:chat_c7_fri/modules/home_screen/home_navigator.dart';
import 'package:chat_c7_fri/modules/home_screen/home_screen_vm.dart';
import 'package:chat_c7_fri/modules/home_screen/room_widget.dart';
import 'package:chat_c7_fri/modules/login/login_screen.dart';
import 'package:chat_c7_fri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeScreenViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.getRoom();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
        create: (c) => viewModel,
        child: Stack(children: [
          Image.asset(
            'assets/images/main_bg.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRoomScreen.routeName);
                },
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text('Chat App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.routeName,
                        );
                      },
                      icon: Icon(Icons.logout))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Consumer<HomeScreenViewModel>(
                  builder: (_, homescreenviewmodel, c) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return RoomWidget(homescreenviewmodel.rooms[index]);
                      },
                      itemCount: homescreenviewmodel.rooms.length,
                    );
                  },
                ),
              ))
        ]));
  }

  @override
  HomeScreenViewModel initViewModel() {
    return HomeScreenViewModel();
  }
}
