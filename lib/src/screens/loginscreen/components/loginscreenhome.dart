import 'package:animated_login/animated_login.dart';

import 'package:flutter/material.dart';

import 'loginscreenfunctions.dart';

import 'package:toasta/toasta.dart';

class LoginScreenHome {
  static Widget loginScreenHome(BuildContext context) {
    return ToastaContainer(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AnimatedLogin(
          loginMobileTheme: LoginViewTheme(
            welcomeTitleStyle: const TextStyle(color: Colors.black),
            welcomeDescriptionStyle: const TextStyle(color: Colors.black),
            formFieldBackgroundColor: Colors.white,
            changeActionTextStyle: const TextStyle(color: Colors.black),
            backgroundColor: Colors.white,
            enabledBorderColor: Colors.black,
            focusedBorderColor: Colors.black,
          ),
          loginTexts: LoginTexts(
            welcome: 'Welcome To Resourceful',
            welcomeDescription: 'Sign In to Start Your Experience',
            welcomeBack: 'Login!',
            welcomeBackDescription: 'Login Here To Access Your Account',
          ),
          onLogin: (LoginData data) async {
            LoginScreenFunctions.login(context, data);
            return null;
          },
          onSignup: (data) async {
            LoginScreenFunctions.signUp(context, data);
            return null;
          },
        );
      }),
    );
  }
}
