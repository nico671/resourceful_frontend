import 'package:flutter/cupertino.dart';

import '../screens/homescreen/components/homescreenroute.dart';

class APIServices {
  static void homescreenAPISearch(
      List<List<String>> value, BuildContext context) async {
    // Location location = Location();

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // _locationData = await location.getLocation();
    // List<geocoder.Placemark> placemarks =
    //     await geocoder.placemarkFromCoordinates(
    //         _locationData.latitude!, _locationData.longitude!);
    // var locationDataString;
    // if (placemarks[0].isoCountryCode! == 'US') {
    //   locationDataString = placemarks[0].name! +
    //       ' ' +
    //       placemarks[0].administrativeArea! +
    //       ' ' +
    //       'USA';
    // } else {
    //   locationDataString = placemarks[0].name! +
    //       ' ' +
    //       placemarks[0].administrativeArea! +
    //       ' ' +
    //       placemarks[0].isoCountryCode!;
    // }

    // if (_selectedSports.isNotEmpty) {
    //   locationDataString = locationDataString + ' ' + placemarks[0].postalCode;
    // }

    // if (_inPersonOrVirtual.toLowerCase() == 'no preference') {
    //   _inPersonOrVirtual = 'all';
    // }

    // var skillsLowercaseList = [];
    // for (String i in value[2]) {
    //   skillsLowercaseList.add('"' + i.toLowerCase() + '"');
    // }

    // var interestsLowercaseList = [];
    // for (String i in value[3]) {
    //   interestsLowercaseList.add('"' + i.toLowerCase() + '"');
    // }

    // var langaugesLowercaseList = [];
    // for (String i in value[4]) {
    //   langaugesLowercaseList.add('"' + i.toLowerCase() + '"');
    // }

    // Map<String, dynamic> passingToAPIMap = {};
    // if (_selectedSports.isNotEmpty) {
    //   passingToAPIMap["sport"] = _selectedSports;
    //   passingToAPIMap["location"] = locationDataString;
    // } else if (_selected == 'Scholarship') {
    //   passingToAPIMap["skills"] = skillsLowercaseList;
    //   passingToAPIMap["interests"] = interestsLowercaseList;
    //   passingToAPIMap["languages"] = langaugesLowercaseList;
    //   passingToAPIMap["type_of_oppurtunity"] =
    //       '"' + _selected.toLowerCase() + '"';
    //   passingToAPIMap["in_person_online"] = 'in-person';
    //   passingToAPIMap["grade_level"] = '"' + _selectedGrade.toLowerCase() + '"';
    //   print(passingToAPIMap);
    // } else {
    //   passingToAPIMap["skills"] = skillsLowercaseList;
    //   passingToAPIMap["interests"] = interestsLowercaseList;
    //   passingToAPIMap["languages"] = langaugesLowercaseList;
    //   passingToAPIMap["type_of_oppurtunity"] =
    //       '"' + _selected.toLowerCase() + '"';
    //   passingToAPIMap["in_person_online"] =
    //       '"' + _inPersonOrVirtual.toLowerCase() + '"';
    //   passingToAPIMap["location"] = '"' + locationDataString + '"';
    //   passingToAPIMap["sport"] = '"' + _selectedSports + '"';
    //   passingToAPIMap["grade_level"] = '"' + _selectedGrade.toLowerCase() + '"';
    //   print(passingToAPIMap);
    // }
    // Dio _dio = Dio();
    // var queryParameters = passingToAPIMap;
    // var data = await _dio.get(
    //     'https://coronasafe-flask-app.herokuapp.com/getPlaces',
    //     queryParameters: queryParameters);
    Navigator.of(context).pop();
    Navigator.of(context).push(HomescreenRoute.createRoute());
  }
}
