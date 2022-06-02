import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/firebase_options.dart';
import 'src/screens/onboardingscreen/onboardingsetup.dart';
//TODO:fucking fix the project structure such as result screen, just look through everything to split it up

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.grey,
      ),
      home: const OnboardingScreen(),
    );
  }
}
