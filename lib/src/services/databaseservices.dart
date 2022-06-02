import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseServices {
  static Future<bool> checkIfBookmarked(String input) async {
    List<dynamic> bookmarkList = await DatabaseServices.createBookMarkList();
    if (bookmarkList.contains(input)) {
      return true;
    }
    return false;
  }

  static List<dynamic> bookmarkList = [];
  static Future<List<dynamic>> createBookMarkList() async {
    bookmarkList.clear();
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
        .get();
    if (snapshot.exists) {
      var map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      map.forEach((key, value) {
        bookmarkList.add(value.toString().split(': ')[1].split('}')[0]);
      });
    } else {}

    return bookmarkList;
  }
}
