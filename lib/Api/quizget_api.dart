// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskmmquiz/Model/Quiz_model.dart';

class QuizApi {
  Future<QuizModel> apimobileinvitation() async {
    var url = Uri.parse(
        'https://quizapi.io/api/v1/questions?apiKey=F9MkiwyCJhWufKoAscZGQwTdNdB4RjzNBO2jEUQQ&category=linux&difficulty=Hard&limit=20');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    

    Map<String, dynamic> map = await jsonDecode(response.body);

    print(response.body);

    final data = QuizModel.fromJson(map);
    return data;
  }
}
