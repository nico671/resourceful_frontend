import 'package:animated_login/animated_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:resourceful/src/screens/loginscreen/components/loginscreenfunctions.dart';
import 'package:resourceful/src/screens/loginscreen/loginscreen.dart';
import 'package:resourceful/src/screens/onboardingscreen/onboardingcontrol.dart';

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
            try {
              final newUser = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: data.email, password: data.password);
              newUser.user!.updateDisplayName(data.name);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CheckOnboarding()));
            } on FirebaseAuthException catch (e) {
              if (e.code == 'email-already-in-use') {
                Toasta(context).toast(Toast(
                    duration: const Duration(milliseconds: 8000),
                    title: 'Email Already Exists',
                    subtitle: 'Try Logging in Or Resetting Your Password'));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            }
            return null;
          },
        );
      }),
    );
  }
}
