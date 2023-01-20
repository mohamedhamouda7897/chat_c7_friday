import 'package:chat_c7_fri/base.dart';
import 'package:chat_c7_fri/modules/create_account/connector.dart';
import 'package:chat_c7_fri/modules/create_account/create_account_vm.dart';
import 'package:chat_c7_fri/modules/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/my_user.dart';
import '../../providers/user_provider.dart';
import '../home_screen/home_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = 'CreateAccount';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseView<CreateAccountScreen, CreateAccountViewModel>
    implements CreateAccountNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

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
              title: Text('Create Account'),
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
                      controller: fNameController,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
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
                    TextFormField(
                      controller: lNameController,
                      decoration: InputDecoration(
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue))),
                      validator: (text) {
                        if (text == null || text == "") {
                          return "Please Enter Last name";
                        }
                        print(text);
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                          hintText: "UserName",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                      validator: (text) {
                        if (text == null || text == "") {
                          return "Please Enter Username";
                        }
                        print(text);
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                        child: Text('Create Account')),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text("I Have An Account ?"))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void validateForm() async {
    if (formKey.currentState!.validate()) {
      viewModel.createAccount(
          fNameController.text,
          lNameController.text,
          userNameController.text,
          emailController.text,
          passwordController.text);
    }
  }

  @override
  CreateAccountViewModel initViewModel() {
    return CreateAccountViewModel();
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.myUser = user;
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}
