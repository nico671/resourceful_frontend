import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import '../../models/colormodel.dart';

import 'components/homescreenmodal.dart';
import '../profilescreen/profilescreen.dart';
import '../../services/databaseservices.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  bool bookmarked = false;
  DatabaseReference bookmarkListRef = FirebaseDatabase.instance
      .ref("${FirebaseAuth.instance.currentUser!.uid}/bookmarks");
  late DatabaseReference newBookmarkRef = bookmarkListRef.push();

  @override
  Widget build(BuildContext context) {
    DatabaseServices.createBookMarkList();
    return Scaffold(
      body: Stack(
        children: [
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
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Featured',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: accentColor,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                              FloatingActionButton.small(
                                heroTag: 'btn2',
                                elevation: 8,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    side: BorderSide(
                                      color: Colors.blueGrey,
                                      width: 2.0,
                                    )),
                                backgroundColor: backgroundColor,
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileScreen()))
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width / 1,
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (_, listViewIndex) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 8),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: const LinkPreviewGenerator(
                                              bodyMaxLines: 2,
                                              bodyTextOverflow:
                                                  TextOverflow.fade,
                                              graphicFit: BoxFit.contain,
                                              link:
                                                  'https://github.com/ghpranav/link_preview_generator',
                                              linkPreviewStyle:
                                                  LinkPreviewStyle.large,
                                              removeElevation: true,
                                              showBody: false,
                                              showTitle: false,
                                              showGraphic: true),
                                        ),
                                      ),
                                      FutureBuilder<bool>(
                                          future: DatabaseServices
                                              .checkIfBookmarked(
                                                  'https://github.com/ghpranav/link_preview_generator'),
                                          builder: ((context, snapshot) {
                                            if (snapshot.data == true) {
                                              return Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    FloatingActionButton.small(
                                                        heroTag:
                                                            'btn10$listViewIndex',
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          setState(() {
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    "${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
                                                                .orderByChild(
                                                                    'url')
                                                                .equalTo(
                                                                    'https://github.com/ghpranav/link_preview_generator')
                                                                .ref
                                                                .remove();
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.star,
                                                          color: Colors.black,
                                                        )),
                                              );
                                            } else if (snapshot.data == false) {
                                              return Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    FloatingActionButton.small(
                                                        heroTag:
                                                            'btn11$listViewIndex',
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          setState(() {
                                                            newBookmarkRef
                                                                .update({
                                                              'url':
                                                                  'https://github.com/ghpranav/link_preview_generator'
                                                            });
                                                            bookmarked == true;
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          color: Colors.black,
                                                        )),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          })),
                                    ],
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Suggested',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: accentColor,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (_, verticalListViewIndex) {
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 8),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          child: const LinkPreviewGenerator(
                                              bodyMaxLines: 2,
                                              bodyTextOverflow:
                                                  TextOverflow.fade,
                                              graphicFit: BoxFit.contain,
                                              link:
                                                  'https://github.com/ghpranav/link_preview_generator',
                                              linkPreviewStyle:
                                                  LinkPreviewStyle.small,
                                              removeElevation: true,
                                              showGraphic: true),
                                        ),
                                      ),
                                      FutureBuilder<bool>(
                                          future: DatabaseServices
                                              .checkIfBookmarked(
                                                  'https://github.com/ghpranav/link_preview_generator'),
                                          builder: ((context, snapshot) {
                                            if (snapshot.data == true) {
                                              return Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    FloatingActionButton.small(
                                                        heroTag:
                                                            'btn6$verticalListViewIndex',
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          setState(() {
                                                            FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    "${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
                                                                .orderByChild(
                                                                    'url')
                                                                .equalTo(
                                                                    'https://github.com/ghpranav/link_preview_generator')
                                                                .ref
                                                                .remove();
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons.star,
                                                          color: Colors.black,
                                                        )),
                                              );
                                            } else if (snapshot.data == false) {
                                              return Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    FloatingActionButton.small(
                                                        heroTag:
                                                            'btn7$verticalListViewIndex',
                                                        elevation: 0,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        onPressed: () {
                                                          setState(() {
                                                            newBookmarkRef
                                                                .update({
                                                              'url':
                                                                  'https://github.com/ghpranav/link_preview_generator'
                                                            });
                                                            bookmarked == true;
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .star_border_outlined,
                                                          color: Colors.black,
                                                        )),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          })),
                                    ],
                                  );
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey),
                              ),
                              onPressed: () {
                                HomescreenModal.showSearchScreen(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Search'),
                                  Icon(Icons.search_sharp),
                                ],
                              ),
                            ),
                          )
                        ])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
