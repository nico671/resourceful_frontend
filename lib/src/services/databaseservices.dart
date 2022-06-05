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

  static Future<List<dynamic>> createBookMarkList() async {
    List<dynamic> globalBookmarkList = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
        .get();
    if (snapshot.exists) {
      var map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      map.values.forEach((element) {
        globalBookmarkList.add(element);
      });
    } else {}

    return globalBookmarkList;
  }
}
