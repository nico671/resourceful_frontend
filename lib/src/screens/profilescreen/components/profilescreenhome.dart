import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:resourceful/src/models/profilescreenbuttons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import '../../loginscreen/loginscreen.dart';
import '../../../models/colormodel.dart';
import '../../../models/totitlecase.dart';
import '../../../services/databaseservices.dart';

class ProfileHomescreen {
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
                                  future: DatabaseServices.createBookMarkList(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<List<dynamic>>
                                          firstSnapshot) {
                                    switch (firstSnapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return const Text('Loading....');
                                      case ConnectionState.done:
                                        return ListView.builder(
                                            clipBehavior: Clip.antiAlias,
                                            itemCount:
                                                firstSnapshot.data!.length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              print(firstSnapshot.data!.length);
                                              return Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8.0),
                                                    child: LinkPreviewGenerator(
                                                        link:
                                                            firstSnapshot.data![
                                                                listViewIndex]),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: FutureBuilder<bool>(
                                                        future: DatabaseServices
                                                            .checkIfBookmarked(
                                                                firstSnapshot
                                                                        .data![
                                                                    listViewIndex]),
                                                        builder: ((context,
                                                            snapshot) {
                                                          if (snapshot.data ==
                                                              true) {
                                                            return Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: FloatingActionButton
                                                                  .small(
                                                                      heroTag:
                                                                          'btn6$listViewIndex',
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          FirebaseDatabase
                                                                              .instance
                                                                              .ref()
                                                                              .child("${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
                                                                              .orderByChild('url')
                                                                              .equalTo(firstSnapshot.data![listViewIndex])
                                                                              .ref
                                                                              .remove();
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .bookmark,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            );
                                                          } else if (snapshot
                                                                  .data ==
                                                              false) {
                                                            return Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child: FloatingActionButton
                                                                  .small(
                                                                      heroTag:
                                                                          'btn7$listViewIndex',
                                                                      elevation:
                                                                          0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          DatabaseReference
                                                                              bookmarkListRef =
                                                                              FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser!.uid}/bookmarks");
                                                                          late DatabaseReference
                                                                              newBookmarkRef =
                                                                              bookmarkListRef.push();
                                                                          newBookmarkRef
                                                                              .set(firstSnapshot.data![listViewIndex]);
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .bookmark_add_outlined,
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                            );
                                                          } else {
                                                            return const SizedBox
                                                                .shrink();
                                                          }
                                                        })),
                                                  ),
                                                ],
                                              );
                                            });
                                      case ConnectionState.none:
                                        return Text('loading....');

                                      case ConnectionState.active:
                                        return Text('loading....');
                                    }
                                  }),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 15)),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ProfileScreenButtons(
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
                                      titleText: 'Clear Bookmarks')),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ProfileScreenButtons(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
                                      },
                                      titleText: 'Sign Out')),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: ProfileScreenButtons(
                                      onPressed: () {
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
                                                  controller:
                                                      emailTextController,
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
                                      titleText: 'Delete Account')),
                            ),
                          ]))))
        ]);
      });
    } else {
      return SizedBox.shrink();
    }
  }
}
