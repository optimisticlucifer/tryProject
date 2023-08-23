import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/quiz_data.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/presentation/home/home_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuizListController extends GetxController {
  // List<QuizItemModel> QuizList = [];

  List<QuizData> QuizList = [];

  bool isUpdating = false;
  bool isProcess = false;

  String odenId = Get.find<HomeController>().user!.value.odenId!;
  final quizScreenController = Get.find<QuizScreenController>();

  @override
  onInit() {
    fetchQuizList(odenId, '');
    super.onInit();
  }

  updateIsUpdating(bool value) {
    isUpdating = value;
    update();
  }

  fetchQuizList(String odenId, String topic) async {
    try {
      isUpdating = true;

      print("invoking fetchQuizList");
      // List<QuizItemModel> data = await getActivity(odenId, topic = '');
      var data = await getActivity(odenId, topic = '');
      print("This is the active data: $data");
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
}
