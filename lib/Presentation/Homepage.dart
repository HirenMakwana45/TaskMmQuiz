import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:taskmmquiz/Api/quizget_api.dart';
import 'package:taskmmquiz/Model/Quiz_model.dart';

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

  @override
  void initState() {
    QuizApi().quizap().then((value) {
      setState(() {
        _quizModel = value;
        log(value.toString());
        log("===== Quiz APi Calling =====");
        quizdata = false;
        totallength = _quizModel!.length;
      });
    });
    super.initState();
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
            const Row(children: [
              Text(
                "TRUE FALSE",
              )
            ]),
            !quizdata
                ? Flexible(
                    child: Swiper(
                        itemCount: _quizModel!.length,
                        allowImplicitScrolling: true,
                        // index: 2,
                        layout: SwiperLayout.DEFAULT,
                        itemWidth: 300.0,
                        itemHeight: 400.0,
                        transformer: ScaleAndFadeTransformer(),
                        viewportFraction: 0.8,
                        scale: 0.9,
                        itemBuilder: (context, index) {
                          int sequence = index + 1;
                          lastSequence = sequence;

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
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 240,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 142, 87, 215))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text("A." +
                                                  _quizModel![index]
                                                      .answers!
                                                      .answerA
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 240,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 142, 87, 215))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text("B." +
                                                  _quizModel![index]
                                                      .answers!
                                                      .answerB
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 240,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 142, 87, 215))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text("C." +
                                                  _quizModel![index]
                                                      .answers!
                                                      .answerC
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 240,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 142, 87, 215))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("D." +
                                                  _quizModel![index]
                                                      .answers!
                                                      .answerD
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
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
                      onPressed: () {},
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
}
