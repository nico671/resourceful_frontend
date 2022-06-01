import 'package:flutter/material.dart';

import 'package:resourceful/src/models/colormodel.dart';
import 'onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static List<String> possibleInterests = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late List<Pages> onboardingPagesList = [
      Pages(
        widget: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      bottom: 5, top: 20, left: 10, right: 50),
                  width: double.infinity,
                  child: const Text('Welcome To Resourceful',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'CenturyGothic',
                        color: Colors.blueGrey,
                      ))),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 50),
                width: double.infinity,
                child: const Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontFamily: 'CenturyGothic',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Pages(
        widget: SafeArea(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(
                      bottom: 5, top: 20, left: 10, right: 50),
                  width: double.infinity,
                  child: const Text('Lorem Ipsum',
                      style: TextStyle(
                        fontFamily: 'CenturyGothic',
                        fontSize: 25,
                        color: Colors.blueGrey,
                      ))),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 50),
                width: double.infinity,
                child: const Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: 'CenturyGothic',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Pages(
          widget: SafeArea(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    bottom: 5, top: 20, left: 10, right: 50),
                width: double.infinity,
                child: const Text('To Get Started',
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 25,
                      color: Colors.blueGrey,
                    ))),
            Container(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 50),
              width: double.infinity,
              child: const Text(
                'Enter 4-6 Interests or Skills so we can build you a personalized experience',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: 'CenturyGothic',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Input...',
                  hintStyle: TextStyle(
                    color: accentColor,
                  ),
                ),
                onSubmitted: (value) {
                  if (value != '') {
                    setState(() {
                      possibleInterests.add(value);
                      textEditingController.clear();
                    });
                  } else {}
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: possibleInterests.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (possibleInterests.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: gradientColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 0),
                                  child: Text(
                                    possibleInterests.elementAt(index),
                                  ),
                                ),
                                FloatingActionButton.small(
                                    heroTag: 'btn1',
                                    elevation: 0,
                                    backgroundColor:
                                        (const Color.fromARGB(255, 83, 83, 83)),
                                    onPressed: () {
                                      setState(() {
                                        possibleInterests
                                            .remove(possibleInterests[index]);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                          ));
                    }
                  }),
            ),
          ],
        ),
      ))
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Onboarding(
        possibleInterests: possibleInterests,
        backgroundColor: backgroundColor,
        pages: onboardingPagesList,
      ),
    );
  }
}
