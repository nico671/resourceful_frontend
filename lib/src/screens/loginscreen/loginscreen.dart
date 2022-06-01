import 'package:flutter/material.dart';
import 'package:resourceful/src/screens/loginscreen/components/loginscreenhome.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return LoginScreenHome.loginScreenHome(context);
  }
}
