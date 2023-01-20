import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/models/my_user.dart';
import 'package:chat_c7_fri/modules/create_account/create_account.dart';
import 'package:chat_c7_fri/modules/home_screen/home_screen.dart';
import 'package:chat_c7_fri/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_navigator.dart';
import 'login_screen_vm.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text('Login'),
          ),
          body: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue))),
                    validator: (text) {
                      if (text == null || text == "") {
                        return "Please Enter Email";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(text);
                      if (!emailValid) {
                        return "Please enter Valid email";
                      }
                      print(text);
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue))),
                    validator: (text) {
                      if (text == null || text == "") {
                        return "Please Enter First name";
                      }
                      print(text);
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
                      child: Text('Login')),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, CreateAccountScreen.routeName);
                      },
                      child: Text("Don't Have An Account ?"))
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  void goToHome(MyUser myUser) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.myUser = myUser;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
