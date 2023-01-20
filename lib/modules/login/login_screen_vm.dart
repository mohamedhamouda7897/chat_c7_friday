import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/database/database_utils.dart';
import 'package:chat_c7_fri/models/my_user.dart';
import 'package:chat_c7_fri/modules/login/login_navigator.dart';
import 'package:chat_c7_fri/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../shared/components/firebase_errors.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? message;

  void login(String email, String password) async {
    try {
      navigator!.showLoading();
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser? myUser =
          await DataBaseUtils.readUserFromFirestore(credential.user?.uid ?? "");
      // check
      if (myUser != null) {
        navigator!.hideDialog();
        navigator!.goToHome(myUser);
        return;
      } else {
        message = "User Not found in Database";
      }
      // read user from database

    } on FirebaseAuthException catch (e) {
      message = "wrong Username Or password";
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
