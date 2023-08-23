import 'dart:developer';

import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/activity_item_model.dart';
import 'package:datacoup/domain/model/badge_data.dart';
import 'package:datacoup/domain/model/path_data.dart';
import 'package:datacoup/domain/model/quiz_data.dart';
import 'package:datacoup/export.dart';
import 'dart:convert';

class QuizScreenController extends GetxController {
  List<ActivityItemModel> userHistory = [];
  RxBool quizMainLoader = true.obs;
  String bestScore = '';
  String badge = 'Digital Novice';
  String currentPathId = "";
  String currentPathName = "";
  String currentLevel = "";
  String currentQuizId = "";
  String currentQuizName = "";
  String currentBadgeLink = "";
  String currentBadgeName = "";
  String totalLevel = "";

  bool isUpdating = false;
  bool isProcess = false;

  RxInt quizScreenType = 1.obs;
  Map<String, List<QuizData>> pathToQuiz = {}; 
  String odenId = "";
  List<QuizData> QuizList = [];
  List<PathData> pathDataList = [];
  List<BadgeData> badgeDataList = [];
  ActivityItemModel quizActivity = ActivityItemModel(
      quizId: '',
      topic: '',
      score: '',
      badge: '',
      timestamp: '',
      odenId: '',
      selectedAnswers: [],
      questions: []);

  // @override
  // onInit() {
  //   loadUserDataFirst();
  //   super.onInit();
  // }


  setQuizActivityItem(String quizId){
    for(int i = 0; i < userHistory.length; i++){
      if(userHistory[i].quizId == quizId){
        quizActivity =  userHistory[i];
      }
    }

    print("This is the quizActivity id ${quizActivity.quizId}");
    update();
  }

  setCurrentPathId(String pathId){
    currentPathId = pathId;
    setCurrentQuizList(pathId);
    print("This is the path id: $pathId");
    update();
  }

  setCurrentPathName(String pathName){
    currentPathName = pathName;
    print("This is the path name: $currentPathName");
    update();
  }

  setCurrentLevel(String level){
    currentLevel = level;
    print("This is the level: $currentLevel");
    update();
  }

  setTotalLevel(String level){
    totalLevel = level;
    print("This is the level: $totalLevel");
    update();
  }

  setCurrentQuizId(String quizId){
    currentQuizId = quizId;
    print("This is the quiz id: $currentQuizId");
    update();
  }

  setCurrentQuizName(String quizName){
    currentQuizName = quizName;
    print("This is the quiz name: $currentQuizName");
    update();
  }

  setCurrentQuizList(String pathId){
    QuizList = pathToQuiz[pathId] ?? [];
    print("This is the quizList: $QuizList");
    update();
  }

  setCurrentBadgeName(String quizId){
    // search for the list of quizzes from the current path id
    QuizList = pathToQuiz[currentPathId] ?? [];
    for(int i = 0; i < QuizList.length; i++){
      if(QuizList[i].quizId == quizId){
        currentBadgeName = QuizList[i].badgeName;
      }
    }

    print("This is the current badge name: $currentBadgeName");
    update();
  }

  setCurrentBadgeLink(String quizId){
    QuizList = pathToQuiz[currentPathId] ?? [];
    for(int i = 0; i < QuizList.length; i++){
      if(QuizList[i].quizId == quizId){
        currentBadgeLink = QuizList[i].badgeLink;
      }
    }

    print("This is the badgeLink: $currentBadgeLink");

    update();

  }

  fetchQuizList(String odenId, String topic) async {
    try {
      isUpdating = true;

      print("invoking fetchQuizList");
      // List<QuizItemModel> data = await getActivity(odenId, topic = '');
      var data = await getActivity(odenId, topic = '');
      pathToQuiz = parsePathToQuiz(data);
      print("This is the pathToQuiz: $pathToQuiz");
      // QuizList = data;
      // print(QuizList);
      isUpdating = false;
      isProcess = false;
      update();
    } catch (error) {
      isProcess = false;
      isUpdating = false;
      update();
      print(error.toString());
    }
  }

  fetchBadges(String odenId) async{
    try{
      badgeDataList = [];
      var data = await getBadge(odenId);
      print("This is empty badges: $data");
      final List<BadgeData> tempBadgeData = [];
      for(int i = 0; i < data.length; i++){
        if(data[i]['badgeName'] != "" && data[i]['badgLink'] != ""){
          final badgeItem = BadgeData(
            quizId: data[i]['quizId'] ?? "",
            badgeName: data[i]['badgeName'],
            badgeLink: data[i]['badgLink']
          );
          tempBadgeData.add(badgeItem);
        }else{
          continue;
        }
        
        
      }
      badgeDataList = tempBadgeData;
      print("This is the badgeDataList: $badgeDataList");
      update();
    }
    catch(error){
      print("This is the badge error: $error");
    }
  }

  fetchProgress(String odenId) async{
    try{
      var data = await getProgress(odenId);
      print("This is empty progress: $data");

      final List<PathData> tempPathData = [];
      for(int i = 0; i < data.length; i++){
        print("data: ${data[i]['pathId']}");
        final pathItem = PathData(
          pathId: data[i]['pathId'] ?? "",
          pathName: data[i]['pathName'] ?? "",
          quizzes_taken: data[i]['quizzes_taken'] ?? "",
          quizzes_total: data[i]['quizzes_total'] ?? "",
          current_level: data[i]['current_level'] ?? ""
        );

        tempPathData.add(pathItem);
      }
      pathDataList = tempPathData;
      update();

    }
    catch(error){
      print("caused an error: $error");
    }
  }

  loadUserDataFirst() async {
    quizMainLoader(true);
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await ApiRepositoryImpl().fetchUserProfile().then(
          (_) async {
            odenId = Get.find<HomeController>().user!.value.odenId!;
            await fetchUserHistory(odenId, '');
            await fetchBestScore(odenId);
            await fetchQuizList(odenId, '');
            await fetchProgress(odenId);
            await fetchBadges(odenId);
            quizMainLoader(false);
          },
        );
      },
    );
  }

  setQuizScreenType(int value){
    quizScreenType.value = value;
  }

  updateIsUpdating(bool value) {
    isUpdating = value;
    update();
  }

  fetchData() async {
    var profileController = Get.find<HomeController>();

    await fetchUserHistory(profileController.user!.value.odenId!, '');
    await fetchBestScore(profileController.user!.value.odenId!);
    await fetchQuizList(profileController.user!.value.odenId!, '');
    await fetchProgress(profileController.user!.value.odenId!);
    await fetchBadges(profileController.user!.value.odenId!);
    update();
  }

  // for the list of quizzes attempted by the user already.
  fetchUserHistory(String odenId, String topic) async {
    try {
      List<ActivityItemModel> data = await getHistory(odenId, topic = '');
      data.sort((a, b) =>
          DateTime.parse(a.timestamp).compareTo(DateTime.parse(b.timestamp)));
      data = data.reversed.toList();
      userHistory = data;

      isUpdating = false;
      isProcess = false;

      update();
    } catch (error) {
      isProcess = false;
      update();
      print(error.toString());
    }
  }


  // gets the total score and basically assigns badge based on that
  fetchBestScore(String odenId) async {
    try {
      Map<String, dynamic>? data = await getBestScore(odenId);

      if (data != null || data!.isNotEmpty) {
        bestScore = data['score'].toString().split(".")[0];

        badge = data['badge'];
      }
    } catch (e) {
      log("$e");
    }
    isUpdating = false;
    isProcess = false;
    update();
  }

  Map<String, List<QuizData>> parsePathToQuiz(Map<String, dynamic> response) {
    print("This is the response ----------------- $response");

    final resultMap = <String, List<QuizData>>{};

    response.forEach((key, value) {
      final intKey = key.toString();
      
      if (intKey != null) {
        final List<QuizData> quizDataList = [];
        
        print("This worked 1");
        print("This is value: $value");
        value.forEach((item) {
          final quizData = QuizData(
            quizId: item['quizId'],
            level: item['level'],
            badgeName: item['badgeName'],
            badgeLink: item['badgeLink'],
            isTaken: item['isTaken'],
            quiz_name: item['quiz_name'],
            count: item['count'],
            timeLimit: item['timeLimit']
          );
          quizDataList.add(quizData);
          
        });

        print("This is quiz data list: $quizDataList");
        resultMap[intKey] = quizDataList;
        print("This worked 2");
      }
    });

    print("This worked 3");
    return resultMap;
  }

}

