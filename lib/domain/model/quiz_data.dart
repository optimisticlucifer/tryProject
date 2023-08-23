import 'dart:convert';


class QuizData {
  String quizId;
  String level;
  String badgeName;
  String badgeLink;
  String isTaken;
  String quiz_name;
  String count;
  String timeLimit;

  QuizData({
    required this.quizId,
    required this.level,
    required this.badgeName,
    required this.badgeLink,
    required this.isTaken,
    required this.quiz_name,
    required this.count,
    required this.timeLimit,
  });
}