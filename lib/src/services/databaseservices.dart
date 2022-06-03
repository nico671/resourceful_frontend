import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseServices {
  static Future<bool> checkIfBookmarked(String input) async {
    var bookmarkList = await createBookMarkList();
    for (int i = 0; i < bookmarkList.length; i++) {
      if (bookmarkList[i].toString() == input) {
        return true;
      }
    }
    if (bookmarkList.contains(input)) {
      return true;
    }
    return false;
  }

  static List<dynamic> globalBookmarkList = [];
  static Future<List<dynamic>> createBookMarkList() async {
    globalBookmarkList.clear();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
        .get();
    if (snapshot.exists) {
      var map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      map.forEach((key, value) {
        globalBookmarkList.add(value.toString().split(': ')[1].split('}')[0]);
      });
    } else {}
    for (int i = 0; i < globalBookmarkList.length - 1; i++) {
      print(globalBookmarkList[i]);
    }
    return globalBookmarkList;
  }
}
