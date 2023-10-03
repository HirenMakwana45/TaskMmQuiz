import 'package:flutter/material.dart';

class Resultpage extends StatefulWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double scorePercentage;
  final String result;
  Resultpage(this.totalQuestions, this.correctAnswers, this.wrongAnswers,
      this.scorePercentage, this.result,
      {super.key});

  @override
  State<Resultpage> createState() => _ResultpageState();
}

class _ResultpageState extends State<Resultpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Questions: ' + widget.totalQuestions.toString()),
            Text('Correct Answers: ' + widget.correctAnswers.toString()),
            Text('Wrong Answers: ' + widget.wrongAnswers.toString()),
            Text('Score: ' + widget.scorePercentage.toStringAsFixed(2) + "%"),
            Text('Result:' + widget.result.toString()),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Ateempt Quiz Again'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
