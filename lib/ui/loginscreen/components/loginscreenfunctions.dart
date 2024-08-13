import 'package:animated_login/animated_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:toasta/toasta.dart';

import '../../onboardingscreen/onboardingcontrol.dart';
import '../loginscreen.dart';

class LoginScreenFunctions {
  static void login(BuildContext context, LoginData data) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.email, password: data.password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CheckOnboarding()),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  static void signUp(BuildContext context, SignUpData data) async {
    try {
      final newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.email, password: data.password);
      newUser.user!.updateDisplayName(data.name);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CheckOnboarding()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }
}
