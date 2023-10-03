import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:taskmmquiz/Api/quizget_api.dart';
import 'package:taskmmquiz/Model/Quiz_model.dart';
import 'package:taskmmquiz/Presentation/Resultpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QuizModel>? _quizModel;
  bool quizdata = true;
  int lastSequence = 0;
  int totallength = 0;
  String rightanswer = "";
  // String Options = "";
  Map<int, String> selectedOptions = {};
  int currentIndex = 0;

  int totalQuestions = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  double scorePercentage = 0.0;
  String result = '';
  final SwiperController swiperController = SwiperController();

  @override
  void initState() {
    QuizAPPPP();
    super.initState();
  }

  QuizAPPPP() {
    setState(() {
      QuizApi().quizap().then((value) {
        setState(() {
          _quizModel = value;
          log(value.toString());
          log("===== Quiz APi Calling =====");
          quizdata = false;
          totallength = _quizModel!.length;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromARGB(31, 76, 103, 139),
        // appBar: AppBar(title: Text("Quiz")),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 23, 132, 222),
                Color.fromARGB(255, 142, 87, 215)
              ],
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 30,
            ),
            Container(
              // padding: EdgeInsets.only(left: 20, right: 20),
              height: 30, // Or whatever height you desire
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: generateStatusIcons(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            !quizdata
                ? Flexible(
                    child: Swiper(
                        controller: swiperController,
                        itemCount: _quizModel!.length,
                        allowImplicitScrolling: true,
                        // index: 2,
                        layout: SwiperLayout.DEFAULT,
                        itemWidth: 300.0,
                        itemHeight: 400.0,
                        transformer: ScaleAndFadeTransformer(),
                        viewportFraction: 0.8,
                        scale: 0.9,
                        onIndexChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          int sequence = index + 1;
                          lastSequence = sequence;
                          rightanswer =
                              _quizModel![index].correctAnswer.toString();
                          log("Right Answer ==> " + rightanswer);

                          // if (rightanswer == "") {
                          //   rightanswer = "answer_a";
                          // }

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Card(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Questions ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "$lastSequence / ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    totallength.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.more_vert)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                              _quizModel![index]
                                                  .question
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 142, 87, 215),
                                                  fontWeight: FontWeight.bold),
                                            ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        if (_quizModel![index]
                                                .answers!
                                                .answerA !=
                                            null)
                                          buildOption(
                                              index,
                                              'answer_a',
                                              _quizModel![index]
                                                  .answers!
                                                  .answerA),
                                        SizedBox(height: 20),
                                        if (_quizModel![index]
                                                .answers!
                                                .answerB !=
                                            null)
                                          buildOption(
                                              index,
                                              'answer_b',
                                              _quizModel![index]
                                                  .answers!
                                                  .answerB),
                                        SizedBox(height: 20),
                                        if (_quizModel![index]
                                                .answers!
                                                .answerC !=
                                            null)
                                          buildOption(
                                              index,
                                              'answer_c',
                                              _quizModel![index]
                                                  .answers!
                                                  .answerC),
                                        SizedBox(height: 20),
                                        if (_quizModel![index]
                                                .answers!
                                                .answerD !=
                                            null)
                                          buildOption(
                                              index,
                                              'answer_d',
                                              _quizModel![index]
                                                  .answers!
                                                  .answerD),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                : Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 10),
              child: Center(
                child: SizedBox(
                  width: 270,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      onPressed: () {
                        setState(() {
                          calculateResults();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Resultpage(
                                totalQuestions,
                                correctAnswers,
                                wrongAnswers,
                                scorePercentage,
                                result,
                              ),
                            ),
                          ).then((_) {
                            QuizAPPPP();
                            swiperController.move(0);

                            setState(() {
                              currentIndex = 0;
                              selectedOptions.clear();
                            });
                          });
                        });
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

//Function Created For options
  Widget buildOption(int questionIndex, String optionKey, String? optionValue) {
    Color borderColor = Color.fromARGB(255, 142, 87, 215);
    Color textColor = Colors.black;
    Color fillColor = Colors.transparent;

    bool isSelected = (selectedOptions[questionIndex] == optionKey);

    if (isSelected) {
      textColor = Colors.white;

      if (optionKey == rightanswer) {
        fillColor = borderColor;
      } else {
        fillColor = Colors.red;
      }
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!selectedOptions.containsKey(questionIndex)) {
            selectedOptions[questionIndex] = optionKey;

            if (optionKey == rightanswer) {
              log("Hurray $optionKey Was Right Answer");
            }
            if (currentIndex < _quizModel!.length - 1) {
              swiperController.next(animation: true);
            }
          }
        });
      },
      child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: fillColor,
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$optionKey. ${optionValue ?? ''}",
              style: TextStyle(color: textColor)),
        ),
      ),
    );
  }

  List<Widget> generateStatusIcons() {
    List<Widget> icons = [];

    if (_quizModel == null || _quizModel!.isEmpty) {
      return icons;
    }

    for (int i = 0; i < _quizModel!.length; i++) {
      Color backgroundColor =
          (i == currentIndex) ? Colors.white : Colors.transparent;

      if (i < currentIndex) {
        if (selectedOptions.containsKey(i)) {
          String? selectedAnswer = selectedOptions[i];
          String correctAnswer = _quizModel![i].correctAnswer.toString();

          icons.add(Container(
            color: backgroundColor,
            child: selectedAnswer == correctAnswer
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.close, color: Colors.red),
          ));
        } else {
          icons.add(Container(
            color: backgroundColor,
            child: Icon(Icons.help, color: Colors.grey),
          ));
        }
      } else {
        icons.add(Container(
          color: (i == currentIndex) ? Colors.white : Colors.transparent,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                    color: (i == currentIndex) ? Colors.black : Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
      }

      if (i < _quizModel!.length - 1) {
        icons.add(SizedBox(width: 5));
      }
    }

    return icons;
  }

  //Calculate Results

  void calculateResults() {
    correctAnswers = 0;
    wrongAnswers = 0;

    for (int i = 0; i < _quizModel!.length; i++) {
      if (selectedOptions.containsKey(i) &&
          selectedOptions[i] == _quizModel![i].correctAnswer.toString()) {
        correctAnswers++;
      } else if (selectedOptions.containsKey(i)) {
        wrongAnswers++;
      }
    }

    totalQuestions = _quizModel!.length;
    scorePercentage = (correctAnswers / totalQuestions) * 100;

    result = scorePercentage >= 70 ? 'Pass' : 'Failed';

    setState(() {});
  }
}
