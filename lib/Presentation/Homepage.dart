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

  @override
  void initState() {
    QuizApi().quizap().then((value) {
      setState(() {
        _quizModel = value;

        log("===== Quiz APi Calling =====");
        quizdata = false;
      });
    });
    super.initState();
  }

  //Every time data change thy che value.first ma 1st j ayo to

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
            Flexible(
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
                    return Card(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              // margin: EdgeInsets.all(10),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Questions ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "5 / ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "10 ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [Icon(Icons.more_vert)],
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
                                        _quizModel![index].question.toString()))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 20),
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
