import 'dart:convert';


class PathData {
  String pathId;
  String pathName;
  String quizzes_taken;
  String quizzes_total;
  String current_level;

  PathData({
    required this.pathId,
    required this.pathName,
    required this.quizzes_taken,
    required this.quizzes_total,
    required this.current_level,
  });
}