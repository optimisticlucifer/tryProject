import 'package:datacoup/data/datasource/qna_api.dart';
import 'package:datacoup/domain/model/quiz_data.dart';
import 'package:datacoup/domain/model/quiz_item_model.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_question.dart';
import 'package:datacoup/presentation/home/quiz/qna/quiz_result_generic.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';

class ExploreQuizListItem extends StatelessWidget {
  final QuizData item;
  final String quizId;
  final String currentLevel;
  ExploreQuizListItem(this.item, this.quizId, this.currentLevel, {Key? key}) : super(key: key);
  final quizListController = Get.find<QuizListController>();
  final quizScreenController = Get.find<QuizScreenController>();
  final quizHistoryController = Get.find<QuizHistoryResultController>();

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
          if((item.isTaken == "True")){
            // go to it's history page instead
            // showSnackBar(context, msg: "Already attempted the quiz");
            await quizScreenController.setQuizActivityItem(quizId);
            QuizItemModel quizItem = await getQuiz(quizId);
            await quizHistoryController.updateQuiz(quizItem);
            print("This is the quiz history activity check : ${quizScreenController.quizActivity.quizId}");
            Get.to(() => QuizHistoryResult(activity: quizScreenController.quizActivity));
          }

          // should have condition for only showing the quiz results from the history if is already taken
          else if((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))){ 
            QuizItemModel quizItem = await getQuiz(quizId);
            print("This is the quiz data: $quizItem");
            quizScreenController.setCurrentQuizId(quizId);
            quizScreenController.setCurrentQuizName(quizItem.name);
            quizScreenController.setCurrentBadgeName(quizId);
            quizScreenController.setCurrentBadgeLink(quizId);
            Get.to(() => QuizQuestion(quiz: quizItem));
          }else{
            showSnackBar(context, msg: "You haven't reached that level yet");
          }
        
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (item.isTaken == "True") ? Color.fromARGB(255, 173, 246, 175) : ((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))) ? greyColor : greyColor.withOpacity(0.5)
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 260.w,
                  child: Text(item.quiz_name.tr,
                      // textAlign: alignment,
                      style: TextStyle(
                        color: (item.isTaken == "True") ? darkBlueGreyColor : ((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))) ? darkBlueGreyColor : darkBlueGreyColor.withOpacity(0.5),
                        fontSize: 16.w,
                        fontWeight: FontWeight.w800,
                        fontFamily: AssetConst.QUICKSAND_FONT,
                      )),
                ),
                const Spacer(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: (item.isTaken == "True") ? deepOrangeColor : ((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))) ? deepOrangeColor : deepOrangeColor.withOpacity(0.5),
                      ),
                      child: Text('${item.count} Questions',
                          // textAlign: alignment,
                          style: TextStyle(
                            color: (item.isTaken == "True") ? whiteColor : ((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))) ? whiteColor : whiteColor.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          )),
                    ),
                    Spacer(),
                    Text('${item.timeLimit} mins',
                        // textAlign: alignment,
                        style: TextStyle(
                          color: (item.isTaken == "True") ? darkBlueGreyColor : ((item.isTaken == "False" && int.parse(currentLevel) >= int.parse(item.level))) ? darkBlueGreyColor : darkBlueGreyColor.withOpacity(0.5),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          fontFamily: AssetConst.QUICKSAND_FONT,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),

                // TextButton(
                //     onPressed: () {
                //       Get.to(() => QuizQuestion(quiz: item));
                //     },
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //             Colors.blue.shade500),
                //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //             RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(5.0),
                //           // side: BorderSide(color: Colors.red)
                //         ))),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text("Take Quiz".tr,
                //             style: const TextStyle(
                //                 letterSpacing: 0.9,
                //                 fontSize: 14,
                //                 color: Colors.white,
                //                 fontFamily: AssetConst.RALEWAY_FONT)),
                //       ],
                //     )),
              ])),
    );
  }
}
