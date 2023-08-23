import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/domain/model/quiz_data.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:dio/dio.dart' as res;

Future<List<ActivityItemModel>> getHistory(String odenId, String topic) async {
  try {
    res.Response response =
        await DioInstance().dio.get(getHistoryUrl(odenId, topic = ''));
    List data = response.data['items'];

    print("This is the history of quizzes: $data");

    List<ActivityItemModel> other =
        data.map((item) => (ActivityItemModel.fromJson(item))).toList();

    List<ActivityItemModel> other2 = List<ActivityItemModel>.from(other);

    return other2;
  } catch (error) {
    print(error);
    rethrow;
  }
}

Future<Map<String, dynamic>?> getBestScore(String odenId) async {
  try {
    res.Response response =
        await DioInstance().dio.get(getBestScoreUrl(odenId));

    Map<String, dynamic> data = response.data;
    print("This is the best score: $data");
    return data;
  } catch (error) {
    print(error);
    return null;
  }
}

 getActivity(String odenId, String topic) async {
  try {

    print("Trying to get the activity");
    res.Response response =
        await DioInstance().dio.get(getActivityUrl(odenId, topic = ''));

    // List data = response.data['items'];
    var data = response.data;
    // data = data.cast<List<QuizItemModel>>();
    print("Currently getting activity: $data");

    // if (data[0].runtimeType == String) {
      // List<QuizItemModel> emptyQuiz = [];
      // return emptyQuiz;
    // } else {
      // List other = (data.map((item) => QuizItemModel.fromJson(item))).toList();
      // List<QuizItemModel> other2 = List<QuizItemModel>.from(other);
      // return other2;
    // }

    // return other;
    return data;
  } 
  catch (error) {
    print("failed to get activity");
    print(error);
    rethrow;
  }
}

Future<void> submitActivity(List<List<int>> selectedAnswers, String score,
    String quizId, String odenId) async {
  List<List<String>> selectedAnswersString = [];
  String currentPathId = Get.find<QuizScreenController>().currentPathId;
  String badgeName = Get.find<QuizScreenController>().currentBadgeName;
  String badgeLink = Get.find<QuizScreenController>().currentBadgeLink;
  
  for (var i in selectedAnswers) {
    List<String> temp = [];
    for (var j in i) {
      temp.add(j.toString());
    }
    selectedAnswersString.add(temp);
  }
  try {
    // res.Response response =
    print("Currently in the submit activity endpoint");


    if(badgeName != "" && badgeLink != ""){
      await DioInstance().dio.post(SUBMIT_ACTIVITY, data: {
        'selectedAnswers': selectedAnswersString,
        'score': score,
        'quizId': quizId,
        'odenId': odenId,
        'pathId': currentPathId,
        'badgeName': badgeName,
        'badgeLink': badgeLink
      });
    }
    else {
      await DioInstance().dio.post(SUBMIT_ACTIVITY, data: {
        'selectedAnswers': selectedAnswersString,
        'score': score,
        'quizId': quizId,
        'odenId': odenId,
        'pathId': currentPathId,
      });
    }

    print("Done with submitting the activity eyahhhhh");

    // List data = response.data['items'];
    // return data;
  } catch (error) {
    print(error);
    rethrow;
  }
}

Future<List<dynamic>> getProgress(String odenId) async{
  try{
    print("Trying to get progress");
    res.Response response =
        await DioInstance().dio.get(getProgressUrl(odenId));

    var data = response.data["items"];
    for(int i = 0; i < data.length; i++){
      print("This is the progress data: ${data[i]}");
    }

    return data;
    

  }catch(e){
    print("Error in getting progress: $e");
    rethrow;
  }
}


// will need to ensure only the data in which badge_url != "" should pass
Future<List<dynamic>> getBadge(String odenId) async{
  try{
    print("Trying to get progress");
    res.Response response =
        await DioInstance().dio.get(getBadgeUrl(odenId));

    var resp = response.data;
    print("This is the res: $resp");
    // var data = response.data["items"];

    // print("This is the length of the badge data: ${data.length}");
    // for(int i = 0; i < data.length; i++){
      // print("This is the badge data: ${data[i]}");
    // }

    return resp;
    

  }catch(e){
    print("Error in getting badge: $e");
    rethrow;
  }
}


getQuiz(String quizId) async{
  try{
    print("Trying to get progress");
    res.Response response =
        await DioInstance().dio.get(getQuizUrl(quizId));

    var resp = response.data;
    print("This is the res: $resp");
    // var data = response.data["items"];

    // print("This is the length of the badge data: ${data.length}");
    // for(int i = 0; i < data.length; i++){
      // print("This is the badge data: ${data[i]}");
    // }
    QuizItemModel quizItem = QuizItemModel.fromJson(resp);
    return quizItem;
    

  }catch(e){
    print("Error in getting quiz for the quiz Id: $e");
    rethrow;
  }
}