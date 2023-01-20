import 'package:chat_c7_fri/database/database_utils.dart';
import 'package:chat_c7_fri/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? myUser;
  User? userAuth;

  UserProvider() {
    userAuth = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (userAuth != null) {
      myUser = await DataBaseUtils.readUserFromFirestore(userAuth?.uid ?? "");
    }
  }
}
