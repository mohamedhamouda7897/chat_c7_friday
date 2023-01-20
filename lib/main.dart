import 'package:chat_c7_fri/modules/add_room/add_room_screen.dart';
import 'package:chat_c7_fri/modules/chat/chat_screen.dart';
import 'package:chat_c7_fri/modules/home_screen/home_screen.dart';
import 'package:chat_c7_fri/modules/login/login_screen.dart';
import 'package:chat_c7_fri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/create_account/create_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    return MaterialApp(
      initialRoute: provider.userAuth == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
      routes: {
        CreateAccountScreen.routeName: (context) => CreateAccountScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
        AddRoomScreen.routeName: (context) => AddRoomScreen()
      },
    );
  }
}
