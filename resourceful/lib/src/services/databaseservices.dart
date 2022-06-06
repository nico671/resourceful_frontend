import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseServices {
  static DatabaseReference bookmarkListRef = FirebaseDatabase.instance
      .ref("${FirebaseAuth.instance.currentUser!.uid}/bookmarks");

  static Future<bool> checkIfBookmarked(String input) async {
    List<dynamic> bookmarkList = await DatabaseServices.createBookMarkList();
    for (int i = 0; i < bookmarkList.length; i++) {
      if (input == bookmarkList[i]) {
        print('its true');
        return true;
      }
    }
    print('its false');
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
      for (int i = 0; i < snapshot.children.length; i++) {
        var map = Map.from(snapshot.children.elementAt(i).value as Map);
        bookmarkList.add(map.values.first);
      }
    } else {}
    return bookmarkList;
  }
}
