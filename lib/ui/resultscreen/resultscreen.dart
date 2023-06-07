import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import '../../databaseservices.dart';
import '../../models/activitymodel.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  List<Map<String, List<Map<String, List<dynamic>>>>> fakeData = [
    {
      "courses cs all Rockville MD USA": [
        {
          "https://www.coursera.org/learn/introcss": [
            "The web today is almost unrecognizable from the early days of white pages with lists of blue links.  Now, sites are designed with complex layouts, unique fonts, and customized color schemes.   This course will show you the basics of Cascading Style Sheets (CSS3).  The emphasis will be on learning how to write CSS rules, how to test code, and how to establish good programming habits.",
            {"cs": 5, "md": 4, "courses": 1, "usa": 1}
          ]
        },
        {
          "https://www.coursera.org/learn/duke-programming-web": [
            "Learn foundational programming concepts (e.g., functions, for loops, conditional statements) and how to solve problems like a programmer. In addition, learn basic web development as you build web pages using HTML, CSS, JavaScript. By the end of the course, will create a web page where others can upload their images and apply image filters that you create.",
            {"cs": 2, "md": 2, "usa": 1, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/learn/html-css-javascript-for-web-developers":
              [
            "Do you realize that the only functionality of a web application that the user directly interacts with is through the web page? Implement it poorly and, to the user, the server-side becomes irrelevant! Todayâ\\x80\\x99s user expects a lot out of the web page: it has to load fast, expose the desired service, and be comfortable to view on all devices: from a desktop computers to tablets and mobile phones.",
            {"usa": 3}
          ]
        },
        {
          "https://www.coursera.org/learn/introduction-to-web-development-with-html-css-javacript":
              [
            "Want to take the first steps to become a Cloud Application Developer? This course will lead you through the languages and tools you will need to develop your own Cloud Apps.",
            {"courses": 1}
          ]
        },
        {
          "https://www.montgomerycollege.edu/academics/programs/computer-science-and-technologies/index.html":
              ["False", {}]
        }
      ],
      "courses machine-learning all Rockville MD USA": [
        {
          "https://www.coursera.org/learn/machine-learning-introduction-for-everyone":
              [
            "This three-module course introduces machine learning and data science for everyone with a foundational understanding of machine learning models. Youâ\\x80\\x99ll learn about the history of machine learning, applications of machine learning, the machine learning model lifecycle, and tools for machine learning. Youâ\\x80\\x99ll also learn about supervised versus unsupervised learning, classification, regression, evaluating machine learning models, and more. Our labs give you hands-on experience with these machine learning and data science concepts. You will develop concrete machine learning skills as well as create a final project demonstrating your proficiency.",
            {"courses": 1, "machine": 9, "learning": 12}
          ]
        },
        {
          "https://www.coursera.org/specializations/machine-learning": [
            "Learners will implement and apply predictive, classification, clustering, and information retrieval machine learning algorithms to real datasets throughout each course in the specialization. They will walk away with applied machine learning and Python programming experience.",
            {"machine": 2, "learning": 2, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/learn/machine-learning": [
            "Machine learning is the science of getting computers to act without being explicitly programmed. In the past decade, machine learning has given us self-driving cars, practical speech recognition, effective web search, and a vastly improved understanding of the human genome. Machine learning is so pervasive today that you probably use it dozens of times a day without knowing it. Many researchers also think it is the best way to make progress towards human-level AI. In this class, you will learn about the most effective machine learning techniques, and gain practice implementing them and getting them to work for yourself. More importantly, you'll learn about not only the theoretical underpinnings of learning, but also gain the practical know-how needed to quickly and powerfully apply these techniques to new problems. Finally, you'll learn about some of Silicon Valley's best practices in innovation as it pertains to machine learning and AI.",
            {"machine": 5, "learning": 9, "md": 3, "usa": 2, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/professional-certificates/ibm-machine-learning":
              [
            "This Professional Certificate has a strong emphasis on developing the skills that help you advance a career in Machine Learning. All the courses include a series of hands-on labs and final projects that help you focus on a specific project that interests you. Throughout this Professional Certificate, you will gain exposure to a series of tools, libraries, cloud services, datasets, algorithms, assignments and projects that will provide you with practical skills with applicability to Machine Learning jobs. These skills include:",
            {"machine": 2, "learning": 2, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/specializations/machine-learnin-theory-and-hands-on-practice-with-pythong-cu":
              [
            "In this specialization, you will build a movie recommendation system, identify cancer types based on RNA sequences, utilize CNNs for digital pathology, practice NLP techniques on disaster tweets, and even generate your images of dogs with GANs. You will complete a final supervised, unsupervised, and deep learning project to demonstrate course mastery.",
            {"usa": 1, "learning": 1, "courses": 1}
          ]
        }
      ],
      "courses math all Rockville MD USA": [
        {
          "https://www.coursera.org/learn/tsi-math-prep": [
            "The purpose of this course is to review and practice key concepts in preparation for the math portion of the Texas Success Initiative Assessment 2.0 (TSI2).Â\\xa0 The TSI2 is series of placement tests for learners enrolling in public universities in Texas.Â\\xa0 This MOOC will cover the four main categories of the Mathematics portion:Â\\xa0 Quantitative Reasoning, Algebraic Reasoning, Geometric & Spatial Reasoning, and Probabilistic & Statistical Reasoning.Â",
            {"courses": 1, "math": 3, "md": 2}
          ]
        },
        {
          "https://www.oercommons.org/authoring/29013-math-routines/view#summary-tab":
              [
            "Students enter our math classrooms with anxiety about performance, misconceptions about what math is, and a lack of confidence that can limit their ability to have meaningful learning experiences. In response to this challenge, Stanford researcher Jo Boaler has focused on some key tenants to help students transform their mindset to find more success with math teaching and learning. Some of these mindset shifts include recognizing that: (1) anyone can learn math, (2) making mistakes is essential to learning, (3) math is about fluency and not speed, (4) math is visual, (5) being successful in math requires creativity, flexibility, problem solving, and number sense.\r\n\r\nIn order to start building these mindsets, Boaler advocates, among other strategies, that students build a habit of being mathematical through common routines, tasks, and puzzles.\r\n\r\nThis guide will introduce 3 of those routines/puzzles including tips on how to successfully implement these tasks in a face to face, blended, or distance learning setting.\r\n\r\nThe Need\r\nMany adult education students had difficult (and often negative) experiences with math teaching and learning during their time in the K-12 system. Without addressing their math trauma and helping them to build a mathematical mindset, our students may continue to struggle and be limited in their ability to succeed in math class, on the equivalency exam, and in college and career settings. So our program views math mindsets as the greatest challenge and largest opportunity for transforming the experience our students have when returning to school. Without this shift, we could share the best lesson plans, the most engaging OERs, and the most transformative teachers, and students will continue to be held back by self-limiting perceptions about math and about their ability to succeed.",
            {"math": 13, "md": 2, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/specializations/precalculus-data-modelling":
              [
            "In each module, learners will be provided with solved sample problems that they can use to build their skills and confidence followed by graded quizzes to demonstrate what they've learned. Finally, each course in the specialization concludes with a final exam that learners can use to demonstrate their mastery of the material.",
            {"usa": 2, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/specializations/algebra-elementary-to-advanced":
              [
            "Instead of a single large project, there are many smaller applied and algebra problems throughout the modules of the courses. Practice problems with worked solutions are provided throughout the course to prepare students and allow them to be successful. Problems range in difficulty to allow students to be challenged as they apply the knowledge gained from the course.",
            {"math": 1, "courses": 3}
          ]
        },
        {
          "https://www.coursera.org/learn/mathematical-thinking": [
            "Learn how to think the way mathematicians do â\\x80\\x93 a powerful cognitive process developed over thousands of years.",
            {"md": 1}
          ]
        }
      ],
      "courses probability all Rockville MD USA": [
        {
          "https://www.coursera.org/learn/introductiontoprobability": [
            "This course will provide you with a basic, intuitive and practical introduction into Probability Theory. You will be able to learn how to apply Probability Theory in different scenarios and you will earn a \"toolbox\" of methods to deal with uncertainty in your daily life.",
            {"courses": 1, "probability": 2}
          ]
        },
        {
          "https://www.coursera.org/learn/probability-theory-foundation-for-data-science":
              [
            "Understand the foundations of probability and its relationship to statistics and data science.Â\\xa0 Weâ\\x80\\x99ll learn what it means to calculate a probability, independent and dependent outcomes, and conditional events.Â\\xa0 Weâ\\x80\\x99ll study discrete and continuous random variables and see how this fits with data collection.Â\\xa0 Weâ\\x80\\x99ll end the course with Gaussian (normal) random variables and the Central Limit Theorem and understand its fundamental importance for all of statistics and data science.",
            {"probability": 2, "md": 1, "courses": 1}
          ]
        },
        {
          "https://www.coursera.org/specializations/advanced-statistics-data-science":
              [
            "The Advanced Statistics for Data Science Specialization incorporates a series of rigorous graded quizzes to test the understanding of key concepts such as probability, distribution, and likelihood concepts to hypothesis testing and case-control sampling.",
            {"probability": 1}
          ]
        },
        {
          "https://www.coursera.org/specializations/probabilistic-graphical-models":
              [
            "Through various lectures, quizzes, programming assignments and exams, learners in this specialization will practice and master the fundamentals of probabilistic graphical models. This specialization has three five-week courses for a total of fifteen weeks.",
            {"courses": 1}
          ]
        },
        {
          "https://www.coursera.org/learn/stanford-statistics": [
            "Stanford\\'s \"Introduction to Statistics\" teaches you statistical thinking concepts that are essential for learning from data and communicating insights. By the end of the course,Â\\xa0you will be able to perform exploratory data analysis, understand key principles of sampling, and select appropriate tests of significance for multiple contexts. You will gain the foundational skills that prepare you to pursue more advanced topics in statistical thinking and machine learning.",
            {"md": 1}
          ]
        }
      ]
    }
  ];
  var indexter = 0;
  List<Activity> activityList = [];

  List<Activity> createActivityList(int ind) {
    activityList.clear();
    for (int i = 0; i < fakeData[0].values.length; i++) {
      activityList.insert(
          i,
          Activity(
              url: fakeData[0].values.elementAt(ind).elementAt(i).keys.first,
              frequencyTags: fakeData[0]
                  .values
                  .elementAt(ind)
                  .elementAt(i)
                  .values
                  .first
                  .elementAt(1)));
    }

    return activityList;
  }

  @override
  Widget build(BuildContext context) {
    createActivityList(indexter);
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Results',
              style: TextStyle(
                color: Colors.black,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Stack(children: [
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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 2),
                    child: SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: fakeData[0].length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey),
                                ),
                                onPressed: () {
                                  setState(() {
                                    indexter = index;
                                    activityList.clear();
                                    activityList = createActivityList(indexter);
                                  });
                                },
                                child: Text(fakeData[0]
                                    .keys
                                    .elementAt(index)
                                    .split(" ")[1]
                                    .toUpperCase())),
                          );
                        }),
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: ImplicitlyAnimatedList<Activity>(
                        items: activityList,
                        areItemsTheSame: (a, b) => a.url == b.url,
                        itemBuilder: (context, animation, item, index) {
                          return Stack(
                            children: [
                              FadeTransition(
                                key: Key(item.url),
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                    reverseCurve: Curves.easeIn,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            child: LinkPreviewGenerator(
                                                bodyMaxLines: 2,
                                                bodyTextOverflow:
                                                    TextOverflow.visible,
                                                graphicFit: BoxFit.fill,
                                                link: item.url,
                                                linkPreviewStyle:
                                                    LinkPreviewStyle.large,
                                                removeElevation: true,
                                                showGraphic: true),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8, top: 8),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  25,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: item.frequencyTags
                                                      .keys.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            shape:
                                                                MaterialStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .blueGrey),
                                                          ),
                                                          onPressed: () {},
                                                          child: Text(
                                                              '${item.frequencyTags.keys.elementAt(index).toString().toUpperCase()} [${item.frequencyTags.values.elementAt(index)}]')),
                                                    );
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //       ),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 8,
                                right: 0,
                                child: FutureBuilder<bool>(
                                    future: DatabaseServices.checkIfBookmarked(
                                        item.url),
                                    builder: ((context, snapshot) {
                                      if (snapshot.data == true) {
                                        return Align(
                                          alignment: Alignment.topRight,
                                          child: FloatingActionButton.small(
                                              heroTag: 'btn6$index',
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              onPressed: () {
                                                setState(() {
                                                  FirebaseDatabase.instance
                                                      .ref()
                                                      .child(
                                                          "${FirebaseAuth.instance.currentUser!.uid}/bookmarks")
                                                      .orderByChild('url')
                                                      .equalTo(item.url)
                                                      .ref
                                                      .remove();
                                                });
                                              },
                                              child: const Icon(
                                                Icons.bookmark,
                                                color: Colors.black,
                                              )),
                                        );
                                      } else if (snapshot.data == false) {
                                        return Align(
                                          alignment: Alignment.topRight,
                                          child: FloatingActionButton.small(
                                              heroTag: 'btn7$index',
                                              elevation: 0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              onPressed: () {
                                                setState(() {
                                                  DatabaseReference
                                                      bookmarkListRef =
                                                      FirebaseDatabase.instance.ref(
                                                          "${FirebaseAuth.instance.currentUser!.uid}/bookmarks");
                                                  late DatabaseReference
                                                      newBookmarkRef =
                                                      bookmarkListRef.push();
                                                  newBookmarkRef.set(item.url);
                                                });
                                              },
                                              child: const Icon(
                                                Icons.bookmark_add_outlined,
                                                color: Colors.black,
                                              )),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    })),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ]),
              ))
        ]));
  }
}
