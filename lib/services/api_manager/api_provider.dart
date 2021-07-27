import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/category.dart';
import '../../models/question.dart';
import 'package:flutter/material.dart';

Future<List<Question>> getQuestions(
    Category category, int total, String difficulty) async {
  var quizUrl = Uri.https("opentdb.com", "/api.php", {
    "amount": "$total",
    "category": "${category.id}",
    "difficulty": difficulty,
    "type": "multiple"
  });
  http.Response res = await http.get(quizUrl);
  debugPrint(quizUrl.toString());
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}
