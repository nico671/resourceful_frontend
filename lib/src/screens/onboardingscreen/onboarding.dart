import 'dart:ui';
import '../homescreen/homescreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  final possibleInterests;

  const Onboarding(
      {Key? key,
      required this.backgroundColor,
      required this.pages,
      required this.possibleInterests})
      : super(key: key);
  final Color? backgroundColor;

  final List<Pages> pages;
  @override
  OnboardingState createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> colorsList = const [
    Color.fromARGB(82, 233, 30, 98),
    Color.fromARGB(82, 195, 255, 126),
    Color.fromARGB(81, 96, 125, 139),
  ];
  int indexter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.pages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (!_controller.position.hasContentDimensions) {
                  return widget.pages[index].widget;
                }
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final progress = _controller.page! - index;
                    if (.5 != 0) {
                      child = Opacity(
                        opacity: (1 - (progress.abs() * .5)).clamp(0.0, 1.0),
                        child: widget.pages[index].widget,
                      );
                    }
                    if (2 != 0) {
                      child = Transform.scale(
                        scale: (1 - (progress.abs() * 2)).clamp(0.0, 1.0),
                        child: widget.pages[index].widget,
                      );
                    }
                    return widget.pages[index].widget;
                  },
                  child: widget.pages[index].widget,
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  indexter = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 24,
            right: MediaQuery.of(context).size.width / 2,
            child: Container(
              color: Colors.grey[999],
              padding: const EdgeInsets.all(20.0),
              child: AnimatedSmoothIndicator(
                onDotClicked: (index) {
                  _controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInCirc);
                },
                activeIndex: indexter,
                count: widget.pages.length,
                effect: const WormEffect(
                  activeDotColor: Colors.blueGrey,
                  dotHeight: 16,
                  spacing: 3,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width / 2,
            right: MediaQuery.of(context).size.width / 24,
            child: Container(
              color: Colors.grey[999],
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                onPressed: () {
                  if (widget.pages.length - 1 == indexter) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homescreen()));
                  } else {
                    _controller.animateToPage(widget.pages.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  }
                },
                child: const Text(
                  'Finish',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: widget.backgroundColor,
    );
  }
}

class Pages {
  final Widget widget;

  Pages({
    required this.widget,
  });
}
