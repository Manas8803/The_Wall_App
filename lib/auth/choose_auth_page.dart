import 'package:flutter/material.dart';
import 'package:the_wall_app/pages/login.dart';
import 'package:the_wall_app/pages/register.dart';

class loginOrRegister extends StatefulWidget {
  const loginOrRegister({super.key});

  @override
  State<loginOrRegister> createState() => _loginOrRegisterState();
}

class _loginOrRegisterState extends State<loginOrRegister> {
  bool showLoginPage = true;
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        onTap: togglePage,
      );
    } else {
      return Register(onTap: togglePage);
    }
  }
}
