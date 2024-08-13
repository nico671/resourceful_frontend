import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resourceful/ui/onboardingscreen/onboardingcontrol.dart';
import 'package:creator/creator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CreatorGraph(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CheckOnboarding(),
      ),
    );
  }
}
