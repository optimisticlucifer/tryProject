import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/question_option_model.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/home_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuizController extends GetxController {
  int questionIndex = 0;
  int totalScore = 0;
  RxString currentStatus = "failed".obs;
  // int answerWasSelected = -1;
  List<int> answersSelected = [];
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  QuizItemModel quiz = QuizItemModel(
      quizId: '',
      topic: '',
      count: '',
      timeLimit: '',
      timeStamp: '',
      questions: [],
      name: '');

  int noOfCorrectAnswers = 0;
  int noOfWrongAnswers = 0;
  List<int> correctlyAnsweredQuestions = [];

  List<List<int>> selectedAnswersPerQuestion = [];

  List<List<int>> correctAnswersPerQuestion = [];

  setStatus(String status){
    currentStatus.value = status;
    print("This is the status: ${currentStatus.value}");
    update();
  }

  updateQuiz(quiz) {
    this.quiz = quiz;
    update();
  }

  updateTimeStamp() {
    quiz.timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  }

  isAnswerSelected(QuestionOptionModel answer) {
    int answerIndex = quiz.questions[questionIndex].options.indexOf(answer);
    return answersSelected.contains(answerIndex);
  }

  getOptionStatus(int optionIndex, int questionIndex) {
    bool selected = false;
    bool correct = false;
    if (selectedAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      selected = true;
    }
    if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      correct = true;
    }
    return {"selected": selected, "correct": correct};
  }

  getOptionColor(int optionIndex, int questionIndex) {
    dynamic optionColor = 0;
    if (!selectedAnswersPerQuestion[questionIndex].contains(optionIndex)) {
      optionColor = Colors.grey;
      if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
        optionColor = Colors.green;

        return optionColor;
      }
    } else {
      if (correctAnswersPerQuestion[questionIndex].contains(optionIndex)) {
        optionColor = Colors.green;
      } else {
        optionColor = Colors.red;
      }
    }
    return optionColor;
  }

  questionAnswered(QuestionOptionModel answer) {
    // answer was selected
    int answerSelectedIndex =
        quiz.questions[questionIndex].options.indexOf(answer);

    if (answersSelected.contains(answerSelectedIndex)) {
      answersSelected.remove(answerSelectedIndex);
    } else {
      answersSelected
          .add(quiz.questions[questionIndex].options.indexOf(answer));
    }

    //when the quiz ends
    if ((questionIndex + 1) == quiz.questions.length) {
      endOfQuiz = true;
    }

    update();
  }

  bool areListsEqual(var list1, var list2) {
    if (!(list1 is List && list2 is List) || list1.length != list2.length) {
      return false;
    }

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }

  calculateScore() {

    int totalQuestions = quiz.questions.length;

    for (int i = 0; i < selectedAnswersPerQuestion.length; i++) {
      selectedAnswersPerQuestion[i].sort();
    }
    for (int i = 0; i < quiz.questions.length; i++) {
      print(correctAnswersPerQuestion[i]);
      if (areListsEqual(
          selectedAnswersPerQuestion[i], correctAnswersPerQuestion[i])) {
        totalScore++;
        noOfCorrectAnswers++;
        correctlyAnsweredQuestions.add(i);
      } else {
        noOfWrongAnswers++;
      }
    }

    print("Number of correct answers: ${noOfCorrectAnswers}");
    print("Number of total questiosn: ${totalQuestions}");

    // cutoff is 50%
    if(noOfCorrectAnswers >= totalQuestions / 2 && noOfCorrectAnswers != 0){
      setStatus("passed");
    }else{
      setStatus("failed");
    }
  }

  storeCorrectAnswersInMap() {
    for (var question in quiz.questions) {
      int qIndex = quiz.questions.indexOf(question);
      List<int> answerIndexList = [];
      for (var option in question.options) {
        int oIndex = quiz.questions[qIndex].options.indexOf(option);
        if (option.ans) {
          answerIndexList.add(oIndex);
        }
      }
      correctAnswersPerQuestion.add(answerIndexList);
    }
    update();
  }

  submitQuizActivity() async {

    print("inside the submit quiz activity function now");

    // commenting for now

    try {
      var profileController = Get.find<HomeController>();
      List<List<String>> selectedAnswersPerQuestionString = [];
      for (int i = 0; i < selectedAnswersPerQuestion.length; i++) {
        List<String> temp = [];
        for (int j = 0; j < selectedAnswersPerQuestion[i].length; j++) {
          temp.add(selectedAnswersPerQuestion.toString());
        }
        selectedAnswersPerQuestionString.add(temp);
      }

      var k = selectedAnswersPerQuestion;
      await submitActivity(
        selectedAnswersPerQuestion,
        "${(totalScore * 100) ~/ quiz.questions.length}",
        quiz.quizId,
        profileController.user!.value.odenId!,
      );

      var quizScreenController = Get.find<QuizScreenController>();
      String odenId = Get.find<HomeController>().user!.value.odenId!;
      quizScreenController.fetchData();
      quizScreenController.fetchBadges(odenId);
    } catch (error) {
      print(error.toString());
    }
  }

  nextQuestion() {
    selectedAnswersPerQuestion.add(answersSelected);
    questionIndex++;
    answersSelected = [];
    correctAnswerSelected = false;

    if (endOfQuiz) {
      storeCorrectAnswersInMap();
      calculateScore();
      print("Done with calculating the score now");
      print("This is the status after calculating score now: ${currentStatus.value}");
      if(currentStatus.value == "passed"){
        print("Oh yeeeeada Im supposed to submit activity now");
        submitQuizActivity();
      }
    }

    update();
  }

  resetQuiz() {
    questionIndex = 0;
    totalScore = 0;
    selectedAnswersPerQuestion = [];
    answersSelected = [];

    endOfQuiz = false;

    update();
  }
}
