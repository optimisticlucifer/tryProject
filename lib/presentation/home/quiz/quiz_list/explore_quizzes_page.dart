import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/explore_quizzes_list.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';
import 'package:datacoup/presentation/widgets/simple_loader.dart';

class QuizList extends StatelessWidget {
  // final String odenId;
  final String pathId;
  // QuizList({Key? key, required this.odenId}) : super(key: key);
  QuizList({Key? key, required this.pathId}) : super(key: key);
  final quizListController = Get.put(QuizListController());
  final pathName = Get.find<QuizScreenController>().currentPathName;
  final currentLevel = Get.find<QuizScreenController>().currentLevel;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomBackButton(),
              const SizedBox(
                width: 20,
              ),
              Text(
                // should be the name of the path instead.
                "${pathName}",
                style: themeTextStyle(
                  // letterSpacing: 1.7,
                  context: context,
                  tColor: Theme.of(context).primaryColorDark,
                  fsize: 18,
                  fweight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 50,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: GetBuilder<QuizScreenController>(builder: (qcontroller) {
              return (qcontroller.isUpdating && qcontroller.QuizList.isEmpty)
                  ? const SimpleLoader()
                  : qcontroller.QuizList.isEmpty
                      ? Center(
                          child: Text('No new quiz available',
                              style:
                                  themeTextStyle(context: context, fsize: 18)),
                        )
                      : ListView.builder(
                          itemCount: qcontroller.QuizList.length,
                          itemBuilder: (context, index) {
                            return ExploreQuizListItem(
                                qcontroller.QuizList[index],
                                qcontroller.QuizList[index].quizId,
                                currentLevel);
                                // pass the quiz id here as well

                            // return Container(child: Text("Text"));
                          });
            }),
          ),
        ]),
      ),
    );
  }
}
