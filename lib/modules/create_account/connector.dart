import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/models/my_user.dart';

abstract class CreateAccountNavigator extends BaseNavigator {
  void goToHome(MyUser user);
}
