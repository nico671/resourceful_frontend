import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:resourceful/src/screens/loginscreen/loginscreen.dart';
import 'package:resourceful/src/models/colormodel.dart';
import 'package:resourceful/src/models/totitlecase.dart';
import 'package:resourceful/src/services/databaseservices.dart';

class ProfileHomescreen {
  DatabaseReference bookmarkListRef = FirebaseDatabase.instance
      .ref("${FirebaseAuth.instance.currentUser!.uid}/bookmarks");
  late DatabaseReference newBookmarkRef = bookmarkListRef.push();
  static Widget home(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Stack(children: [
          Positioned(
              top: -150,
              left: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: const Color(0xFFD8E4FC)),
              )),
          Positioned(
              top: 200,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: const Color(0xFFE8DCFC)),
              )),
          Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: const Color(0xFFD8E4FC)),
              )),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Name',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser!.displayName!
                                  .toTitleCase(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            Text(
                              'Email',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser!.email!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
                            Text(
                              'Bookmarks',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: FutureBuilder<List<dynamic>>(
                                  initialData: const [],
                                  future: DatabaseServices.createBookMarkList(),
                                  builder: (context, snapshot) {
                                    return ListView.builder(
                                        clipBehavior: Clip.antiAlias,
                                        itemCount: DatabaseServices
                                            .bookmarkList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: LinkPreviewGenerator(
                                                link: snapshot.data![index]),
                                          );
                                        });
                                  }),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 15)),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              side: BorderSide(
                                                  width: 2.0,
                                                  color: Colors.blueGrey)),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                backgroundColor)),
                                    onPressed: () {
                                      setState(
                                        () {
                                          final ref =
                                              FirebaseDatabase.instance.ref();
                                          ref
                                              .child(
                                                  "${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
                                              .remove();
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Clear Bookmarks',
                                      style: TextStyle(color: Colors.blueGrey),
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              side: BorderSide(
                                                  width: 2.0,
                                                  color: Colors.blueGrey)),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                backgroundColor)),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Sign Out',
                                      style: TextStyle(color: Colors.blueGrey),
                                    )),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                              side: BorderSide(
                                                  width: 2.0,
                                                  color: Colors.blueGrey)),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                backgroundColor)),
                                    onPressed: () async {
                                      TextEditingController
                                          passwordTextController =
                                          TextEditingController();
                                      TextEditingController
                                          emailTextController =
                                          TextEditingController();
                                      Alert(
                                          context: context,
                                          title:
                                              "LOGIN NEEDED TO DELETE ACCOUNT",
                                          content: Column(
                                            children: <Widget>[
                                              TextField(
                                                autocorrect: false,
                                                controller: emailTextController,
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(
                                                      Icons.account_circle),
                                                  labelText: 'Email',
                                                ),
                                              ),
                                              TextField(
                                                autocorrect: false,
                                                controller:
                                                    passwordTextController,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(Icons.lock),
                                                  labelText: 'Password',
                                                ),
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              onPressed: () async {
                                                var result = await FirebaseAuth
                                                    .instance.currentUser!
                                                    .reauthenticateWithCredential(
                                                        EmailAuthProvider.credential(
                                                            email:
                                                                emailTextController
                                                                    .text,
                                                            password:
                                                                passwordTextController
                                                                    .text));
                                                await result.user!.delete();
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()),
                                                );
                                              },
                                              child: const Text(
                                                "DELETE ACCOUNT",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            )
                                          ]).show();
                                    },
                                    child: const Text(
                                      'Delete Account',
                                      style: TextStyle(color: Colors.blueGrey),
                                    )),
                              ),
                            ),
                          ]))))
        ]);
      });
    } else {
      return const SizedBox.shrink();
    }
  }
}
