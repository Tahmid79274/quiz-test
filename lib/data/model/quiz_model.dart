// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  List<Question> questions;

  QuizModel({
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Question {
  String question;
  Answers answers;
  String? questionImageUrl;
  String correctAnswer;
  String score;

  Question({
    required this.question,
    required this.answers,
    this.questionImageUrl,
    required this.correctAnswer,
    required this.score,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    question: json["question"].toString(),
    answers: Answers.fromJson(json["answers"],json["correctAnswer"].toString()),
    questionImageUrl: json["questionImageUrl"].toString(),
    correctAnswer: json["correctAnswer"].toString(),
    score: json["score"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answers": answers.toJson(),
    "questionImageUrl": questionImageUrl,
    "correctAnswer": correctAnswer,
    "score": score,
  };
}

class Answers {
  String? a;
  String? b;
  String? c;
  String? d;
  String? correctAnswer;
  Map<String,String>? answerMap;

  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
    this.correctAnswer,
    this.answerMap
  });

  factory Answers.fromJson(Map<String, dynamic> json,String answer) {
    Map<String,String> answers = {};
    for(int i = 65; i<69;i++){
      if(json[String.fromCharCode(i)].toString()!='null'){
        answers[String.fromCharCode(i)]=json[String.fromCharCode(i)].toString();
      }
    }
    return Answers(
        a: json["A"].toString(),
        b: json["B"].toString(),
        c: json["C"].toString(),
        d: json["D"].toString(),
        answerMap: answers,
      correctAnswer: answer
    );
  }

  Map<String, dynamic> toJson() => {
    "A": a,
    "B": b,
    "C": c,
    "D": d,
  };
}
