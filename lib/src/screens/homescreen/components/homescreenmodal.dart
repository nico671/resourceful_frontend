import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/language_picker.dart';
import 'package:language_picker/languages.dart';
import 'package:resourceful/src/screens/homescreen/components/homescreenroute.dart';
import '../../../models/colormodel.dart';

class HomescreenModal {
  static String inPersonVirtualText = 'In Person/Virtual';
  static int currentStepIndexter = 0;
  static String typeOfOppurtunityText = 'Type Of Oppurtunity';
  static String selectLanguageText = 'Language';
  static var gradesList = [
    'Pre-K',
    'Kindergarten',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    'Post-Grad'
  ];
  static var oppurtunitiesList = [
    'Courses',
    'Volunteer',
    'Sports',
    'Tutoring',
    'Scholarship'
  ];
  static List<String> categories = [
    'Type Of Opportunity',
    'In Person/Virtual',
    'Skills',
    'Interests',
    'Languages',
  ];
  static var sportsList = [
    'Archery',
    'Badminton',
    'Baseball',
    "Basketball - Women's",
    'Basketball-Boys',
    'Basketball-Girls',
    "Basketball-Men's",
    'Baton Twirling',
    'Bowling',
    'Cheerleading',
    'Chess',
    'Cornhole',
    'Cricket',
    'Dance',
    'Diving',
    'Esports',
    'Fencing',
    'Field Hockey',
    'Football - Flag, 7v7',
    'Football Cheer',
    'Football Tackle',
    'Futsal',
    "Girls & Women's Flag Football",
    'Golf',
    'Gymnastics',
    'Gymnastics - Acrobatic',
    'Hockey - Collegiate',
    'Hockey - Ice',
    'Hockey - Inline',
    'Hockey - Junior A Hockey',
    'Jiu Jitsu',
    'Judo',
    'Jump Rope',
    'Karate',
    'Kung-Fu',
    'Lacrosse',
    'Paddle Board',
    'Pickleball',
    'Powerlifting',
    'Rhythmic Gymnastics',
    'Skateboarding',
    'Soccer',
    'Softball',
    'Special Needs',
    'Sport Stacking',
    'Surfing',
    'Swimming',
    'Table Tennis',
    'Taekwondo',
    'Target Shooting',
    'Team Handball',
    'Tennis',
    'Track and Field',
    'Trampoline - Tumbling',
    'Volleyball',
    'Water Polo',
    'Weightlifting',
    'Wrestling'
  ];
  static int indexter = 0;
  static var _selected = '';
  static var _selectedGrade = '';
  bool coolnessEnabled = true;
  static TextEditingController textEditingController = TextEditingController();
  static final infoSelectionController = TextEditingController();
  static final secondInfoSelectionController = TextEditingController();
  static final thirdInfoSelectionController = TextEditingController();
  static var _selectedSports = '';
  static String _inPersonOrVirtual = '';
  static List<String> skillsList = [];
  static List<String> interestsList = [];
  static List<String> languagesList = [];
  static List<String> oppurtunityTypeList = [];
  static List<String> virtualOrInPersonList = [];
  static var searchedItems = [
    oppurtunityTypeList,
    virtualOrInPersonList,
    skillsList,
    interestsList,
    languagesList,
  ];

  static void showSearchScreen(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Material(
                  child: Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                        const ColorScheme.light(primary: Colors.blueGrey)),
                child: Stepper(
                    onStepTapped: (stepperIndex) {
                      setModalState(() {
                        currentStepIndexter = stepperIndex;
                      });
                    },
                    onStepContinue: () {
                      if (currentStepIndexter < 3) {
                        setModalState(() {
                          currentStepIndexter++;
                        });
                      } else {
                        homescreenAPISearch(searchedItems, context);
                      }
                    },
                    onStepCancel: () {
                      if (currentStepIndexter > 0) {
                        setModalState(() {
                          currentStepIndexter--;
                        });
                      } else {}
                    },
                    currentStep: currentStepIndexter,
                    type: StepperType.vertical,
                    steps: [
                      Step(
                          isActive: currentStepIndexter >= 0,
                          title: Text(typeOfOppurtunityText),
                          content:
                              StatefulBuilder(builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomDropdown(
                                            items: oppurtunitiesList,
                                            controller: infoSelectionController,
                                            onChanged: (selected) {
                                              setModalState(() {
                                                if (selected.toLowerCase() !=
                                                        'sports' ||
                                                    selected.toLowerCase() !=
                                                        'tutoring' ||
                                                    selected.toLowerCase() !=
                                                        'scholarship') {
                                                  _selected = selected;
                                                  typeOfOppurtunityText =
                                                      selected;
                                                } else {
                                                  setModalState(() {
                                                    currentStepIndexter++;
                                                  });
                                                  _selected = selected;
                                                  typeOfOppurtunityText =
                                                      selected;
                                                }
                                              });
                                            }),
                                        if (_selected.toLowerCase() ==
                                            'sports') ...[
                                          CustomDropdown(
                                              hintText: 'Select Sport',
                                              items: sportsList,
                                              controller:
                                                  secondInfoSelectionController,
                                              onChanged: (selected) {
                                                setModalState(() {
                                                  currentStepIndexter++;
                                                });
                                                _selectedSports = selected;
                                              }),
                                        ] else if (_selected.toLowerCase() ==
                                                'tutoring' ||
                                            _selected.toLowerCase() ==
                                                'scholarship') ...[
                                          CustomDropdown(
                                              hintText: 'Select Grade',
                                              items: gradesList,
                                              controller:
                                                  secondInfoSelectionController,
                                              onChanged: (selected) {
                                                if (selected == 'Pre-K') {
                                                  _selectedGrade = 'pre';
                                                }
                                                if (selected ==
                                                    'Kindergarten') {
                                                  _selectedGrade = 'k';
                                                }
                                                if (selected == 'Post-Grad') {
                                                  _selectedGrade = 'Post';
                                                } else {
                                                  _selectedGrade = selected;
                                                }
                                                setModalState(() {
                                                  currentStepIndexter++;
                                                });
                                              })
                                        ] else ...[
                                          const SizedBox.shrink()
                                        ]
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })),
                      Step(
                          isActive: currentStepIndexter >= 1,
                          title: Text(inPersonVirtualText),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      CustomDropdown(
                                          items: const [
                                            'In-Person',
                                            'Virtual',
                                            'No Preference'
                                          ],
                                          controller:
                                              thirdInfoSelectionController,
                                          onChanged: (selected) {
                                            setModalState(() {
                                              inPersonVirtualText = selected;
                                              currentStepIndexter++;
                                              _inPersonOrVirtual = selected;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Step(
                          isActive: currentStepIndexter >= 2,
                          title: const Text('Interests/Skills'),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
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
                                            setModalState(() {
                                              searchedItems[2].add(value);
                                              textEditingController.clear();
                                            });
                                          } else {}
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                SizedBox(
                                  height: 30,
                                  child: ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: searchedItems[2].length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        if (searchedItems[2].isEmpty) {
                                          return const SizedBox.shrink();
                                        } else {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: gradientColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 0),
                                                      child: Text(
                                                        searchedItems[2]
                                                            .elementAt(index),
                                                      ),
                                                    ),
                                                    FloatingActionButton.small(
                                                        heroTag: 'btn1$index',
                                                        elevation: 0,
                                                        backgroundColor:
                                                            (const Color
                                                                    .fromARGB(
                                                                255,
                                                                83,
                                                                83,
                                                                83)),
                                                        onPressed: () {
                                                          setModalState(() {
                                                            searchedItems[2]
                                                                .remove(
                                                                    searchedItems[
                                                                            2][
                                                                        index]);
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
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
                          )),
                      Step(
                          isActive: currentStepIndexter >= 3,
                          title: Text(selectLanguageText),
                          content: LanguagePickerDropdown(
                              onValuePicked: (Language language) {
                            setModalState(
                              () {
                                searchedItems[3].add(language.name.toString());
                                selectLanguageText = language.name;
                              },
                            );
                          }))
                    ]),
              )),
            );
          });
        });
  }

  Widget firstInstanceChange() {
    if (_selected.toLowerCase() == 'sports') {
      return CustomDropdown(
          hintText: 'Select Sport',
          items: sportsList,
          controller: secondInfoSelectionController,
          onChanged: (selected) {
            _selectedSports = selected;
          });
    } else if (_selected.toLowerCase() == 'tutoring' ||
        _selected.toLowerCase() == 'scholarship') {
      return CustomDropdown(
          hintText: 'Select Grade',
          items: gradesList,
          controller: secondInfoSelectionController,
          onChanged: (selected) {
            if (selected == 'Pre-K') {
              _selectedGrade = 'pre';
            }
            if (selected == 'Kindergarten') {
              _selectedGrade = 'k';
            }
            if (selected == 'Post-Grad') {
              _selectedGrade = 'Post';
            } else {
              _selectedGrade = selected;
            }
          });
    } else {
      return const SizedBox.shrink();
    }
  }

  static void homescreenAPISearch(
      List<List<String>> value, BuildContext context) async {
    // Location location = Location();

    // bool serviceEnabled;
    // PermissionStatus permissionGranted;
    // LocationData locationData;

    // serviceEnabled = await location.serviceEnabled();
    // if (!serviceEnabled) {
    //   serviceEnabled = await location.requestService();
    //   if (!serviceEnabled) {
    //     return;
    //   }
    // }

    // permissionGranted = await location.hasPermission();
    // if (permissionGranted == PermissionStatus.denied) {
    //   permissionGranted = await location.requestPermission();
    //   if (permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // locationData = await location.getLocation();
    // List<geocoder.Placemark> placemarks =
    //     await geocoder.placemarkFromCoordinates(
    //         locationData.latitude!, locationData.longitude!);
    // var locationDataString;
    // if (placemarks[0].isoCountryCode! == 'US') {
    //   locationDataString =
    //       '${placemarks[0].name!} ${placemarks[0].administrativeArea!} USA';
    // } else {
    //   locationDataString =
    //       '${placemarks[0].name!} ${placemarks[0].administrativeArea!} ${placemarks[0].isoCountryCode!}';
    // }

    // if (_selectedSports.isNotEmpty) {
    //   locationDataString = locationDataString + ' ' + placemarks[0].postalCode;
    // }

    // if (_inPersonOrVirtual.toLowerCase() == 'no preference') {
    //   _inPersonOrVirtual = 'all';
    // }

    // var skillsLowercaseList = [];
    // for (String i in value[2]) {
    //   skillsLowercaseList.add('"${i.toLowerCase()}"');
    // }

    // var interestsLowercaseList = [];
    // for (String i in value[3]) {
    //   interestsLowercaseList.add('"${i.toLowerCase()}"');
    // }

    // var langaugesLowercaseList = [];
    // for (String i in value[4]) {
    //   langaugesLowercaseList.add('"${i.toLowerCase()}"');
    // }

    // Map<String, dynamic> passingToAPIMap = {};
    // if (_selectedSports.isNotEmpty) {
    //   passingToAPIMap["sport"] = _selectedSports;
    //   passingToAPIMap["location"] = locationDataString;
    // } else if (_selected == 'Scholarship') {
    //   passingToAPIMap["skills"] = skillsLowercaseList;
    //   passingToAPIMap["interests"] = interestsLowercaseList;
    //   passingToAPIMap["languages"] = langaugesLowercaseList;
    //   passingToAPIMap["type_of_oppurtunity"] = '"${_selected.toLowerCase()}"';
    //   passingToAPIMap["in_person_online"] = 'in-person';
    //   passingToAPIMap["grade_level"] = '"${_selectedGrade.toLowerCase()}"';
    //   print(passingToAPIMap);
    // } else {
    //   passingToAPIMap["skills"] = skillsLowercaseList;
    //   passingToAPIMap["interests"] = interestsLowercaseList;
    //   passingToAPIMap["languages"] = langaugesLowercaseList;
    //   passingToAPIMap["type_of_oppurtunity"] = '"${_selected.toLowerCase()}"';
    //   passingToAPIMap["in_person_online"] =
    //       '"${_inPersonOrVirtual.toLowerCase()}"';
    //   passingToAPIMap["location"] = '${'"' + locationDataString}"';
    //   passingToAPIMap["sport"] = '"$_selectedSports"';
    //   passingToAPIMap["grade_level"] = '"${_selectedGrade.toLowerCase()}"';
    // }
    // Dio dio = Dio();
    // var queryParameters = passingToAPIMap;
    // var data = await dio.get(
    //     'https://coronasafe-flask-app.herokuapp.com/getPlaces',
    //     queryParameters: queryParameters);
    Navigator.of(context).pop();
    Navigator.of(context).push(HomescreenRoute.createRoute());
  }
}
