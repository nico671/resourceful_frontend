import 'dart:ui';

import 'package:creator/creator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:resourceful/creator/database_creator.dart';
import '../../databaseservices.dart';
import '../profilescreen/profilescreen.dart';
import 'components/homescreenmodal.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    DatabaseServices.createBookMarkList();
    return Scaffold(
      backgroundColor: Colors.white,
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
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      NameAndProfile(),
                      Featured(),
                      Suggested(),
                      SearchButton()
                    ])),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget NameAndProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Featured',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 30,
              ),
            ),
          ),
        ),
        FloatingActionButton.small(
          heroTag: 'btn2',
          elevation: 8,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              side: BorderSide(
                color: Colors.blueGrey,
                width: 2.0,
              )),
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()))
                .then((value) {
              setState(() {});
            });
          },
          child: const Icon(
            CupertinoIcons.person_fill,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  Widget Featured() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (_, listViewIndex) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: const LinkPreviewGenerator(
                        bodyMaxLines: 2,
                        bodyTextOverflow: TextOverflow.fade,
                        graphicFit: BoxFit.contain,
                        link: 'https://www.coursera.org/',
                        linkPreviewStyle: LinkPreviewStyle.large,
                        removeElevation: true,
                        showBody: false,
                        showTitle: false,
                        showGraphic: true),
                  ),
                ),
                Watcher(((context, ref, child) {
                  bool? isBookmarked =
                      ref.watch(checkIfBookmarked.asyncData).data;

                  return Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.small(
                        heroTag: 'btn10$listViewIndex',
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          ref.set(givenLink, 'https://www.coursera.org/');
                        },
                        child: Icon(
                          true == isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          color: Colors.black,
                        )),
                  );
                }))
              ],
            );
          }),
    );
  }

  Widget SuggestedText() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Suggested',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget Suggested() {
    return Expanded(
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, verticalListViewIndex) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: const LinkPreviewGenerator(
                        bodyMaxLines: 2,
                        bodyTextOverflow: TextOverflow.fade,
                        graphicFit: BoxFit.contain,
                        link: 'https://www.coursera.org/',
                        linkPreviewStyle: LinkPreviewStyle.small,
                        removeElevation: true,
                        showGraphic: true),
                  ),
                ),
                Watcher(((context, ref, child) {
                  bool? isBookmarked =
                      ref.watch(checkIfBookmarked.asyncData).data;

                  return Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton.small(
                        heroTag: 'btn1$verticalListViewIndex',
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          ref.set(givenLink,
                              'https://github.com/ghpranav/link_preview_generator');
                        },
                        child: Icon(
                          true == isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_add_outlined,
                          color: Colors.black,
                        )),
                  );
                }))
              ],
            );
          }),
    );
  }

  Widget SearchButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blueGrey),
        ),
        onPressed: () {
          HomescreenModal.showSearchScreen(context);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Search'),
            Icon(Icons.search_sharp),
          ],
        ),
      ),
    );
  }
}
