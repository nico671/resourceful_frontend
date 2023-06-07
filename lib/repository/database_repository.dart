import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseRepository {
  Future<bool> checkIfBookmarked(String input) async {
    var bookmarkList = await createBookMarkList();
    for (int i = 0; i < bookmarkList.length; i++) {
      if (bookmarkList[i] == input) {
        DatabaseReference bookmarkListRef = FirebaseDatabase.instance
            .ref("${FirebaseAuth.instance.currentUser!.uid}/bookmarks");
        late DatabaseReference newBookmarkRef = bookmarkListRef.push();
        newBookmarkRef.set(input);

        return true;
      }
    }
    FirebaseDatabase.instance
        .ref()
        .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
        .equalTo(input)
        .ref
        .remove();
    return false;
  }

  Future<List<dynamic>> createBookMarkList() async {
    List<dynamic> globalBookmarkList = [];
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref
        .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
        .get();
    if (snapshot.exists) {
      var map =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
      for (var element in map.values) {
        globalBookmarkList.add(element);
      }
    } else {}

    return globalBookmarkList;
  }
}
