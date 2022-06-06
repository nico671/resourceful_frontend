import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resourceful/src/models/colormodel.dart';
import 'package:resourceful/src/screens/homescreen/homescreen.dart';
import 'package:resourceful/src/screens/loginscreen/loginscreen.dart';
import 'onboardingsetup.dart';
import 'package:after_layout/after_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOnboarding extends StatefulWidget {
  const CheckOnboarding({Key? key}) : super(key: key);

  @override
  CheckOnboardingState createState() => CheckOnboardingState();
}

class CheckOnboardingState extends State<CheckOnboarding>
    with AfterLayoutMixin<CheckOnboarding> {
  late StreamSubscription<User?> user;

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      if (seen) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Homescreen()));
      } else {
        prefs.setBool("seen", true);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const OnboardingScreen()));
      }
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
