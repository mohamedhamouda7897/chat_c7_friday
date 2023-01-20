import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/database/database_utils.dart';
import 'package:chat_c7_fri/models/my_user.dart';
import 'package:chat_c7_fri/shared/components/firebase_errors.dart';
import 'package:chat_c7_fri/shared/components/ui_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'connector.dart';

class CreateAccountViewModel extends BaseViewModel<CreateAccountNavigator> {
  String? message;

  void createAccount(String fName, String lName, String userName, String email,
      String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // add user to database
      MyUser myUser = MyUser(
          id: credential.user?.uid ?? "",
          fName: fName,
          lName: lName,
          userName: userName,
          email: email);
      DataBaseUtils.addUserToFirestore(myUser);
      navigator!.goToHome(myUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrors.weakPassword) {
        message = "The password provided is too weak.";
      } else if (e.code == FireBaseErrors.email_In_Use) {
        message = "The account already exists for that email.";
      }
    } catch (e) {
      message = "Something went wrong";
      print(e);
    }
    if (message != null) {
      navigator!.hideDialog();
      navigator!.showMessage(message!);
    }
  }
}
