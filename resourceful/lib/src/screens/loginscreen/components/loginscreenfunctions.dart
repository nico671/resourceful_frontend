import 'package:animated_login/animated_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resourceful/src/screens/onboardingscreen/onboardingcontrol.dart';
import 'package:toasta/toasta.dart';

class LoginScreenFunctions {
  static void login(BuildContext context, LoginData data) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.email, password: data.password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CheckOnboarding()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Toasta(context).toast(Toast(
            duration: const Duration(milliseconds: 8000),
            title: 'User Not Found',
            subtitle: 'Try Signing Up Instead'));
      } else if (e.code == 'wrong-password') {
        Toasta(context).toast(Toast(
            duration: const Duration(milliseconds: 8000),
            title: 'Incorrect Password',
            subtitle: 'Email Exists But Password Is Incorrect'));
      } else {
        print(e.code);
      }
    }
  }
}
