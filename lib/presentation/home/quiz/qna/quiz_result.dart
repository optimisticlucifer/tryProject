import 'dart:math';

import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_result_list.dart';

class QuizResult extends StatelessWidget {
  final List<String> quizResultText = [
    "SCORE GAINED",
    "CORRECT ANSWERS",
    "WRONG ANSWERS"
  ];
  final List<String> quizResultLogo = [
    AssetConst.SCORE_GAINED,
    AssetConst.CORRECT_ANSWERS,
    AssetConst.WRONG_ANSWERS
  ];
  final _scrollController = ScrollController();

// @override
// @mustCallSuper
//   void didPopNext() {
//     print('HomePage: Called didPopNext');
//     super.didPopNext();
//   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(builder: (quizController) {
      final List<int> quizResultScore = [
        quizController.totalScore,
        quizController.correctlyAnsweredQuestions.length,
        quizController.quiz.questions.length -
            quizController.correctlyAnsweredQuestions.length
      ];
      // _quizController.calculateScore();
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: blueGreyLight,
                          ),
                          child: InkWell(
                              onTap: () {
                                // var profileController =
                                //     Get.find<UserProfileController>();
                                // var QuizScreenController =
                                //     Get.find<QuizScreenController>();
                                // await QuizScreenController.fetchUserHistory(
                                //     profileController.user!.odenId, '');
                                // await QuizScreenController.fetchBestScore(
                                //     profileController.user!.odenId);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back_ios,
                                  color: darkBlueGreyColor))),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(75),
                        child: Image.asset(AssetConst.QUIZ_RESULT,
                            width: 150, height: 200),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 20),
                  Container(
                      child: Text("Results of ${quizController.quiz.topic}",
                          style: TextStyle(
                            // letterSpacing: 1.7,
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          ))),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        children: List.generate(3, (index) {
                      return Container(
                          child: Column(
                        children: [
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  quizResultLogo[index],
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(quizResultText[index],
                                  style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.9,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                  )),
                              const Spacer(),
                              Text(quizResultScore[index].toString(),
                                  style: TextStyle(
                                    color: darkGreyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.9,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 2),
                          if (index != 2)
                            Divider(
                              color: lightGreyColor,
                            )
                        ],
                      ));
                    })),
                  ),
                  const SizedBox(height: 20),
                  Center(
                      child: Text("Here is what you got right and wrong.",
                          style: TextStyle(
                            // letterSpacing: 1.7,
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          ))),
                  const SizedBox(height: 10),
                  Center(
                      child: Column(
                    children: [
                      Text("Scroll Below",
                          style: TextStyle(
                            // letterSpacing: 1.7,
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          )),
                      const SizedBox(height: 10),
                      Transform.rotate(
                        angle: -pi / 2,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.blue,
                          ),
                          child: IconButton(
                            // splashColor: Colors.grey.shade200,
                            highlightColor: lightGreyColor,
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: whiteColor,
                            ),
                            onPressed: () {
                              final screenHeight =
                                  MediaQuery.of(context).size.height;

                              // If you don't want any animation, use this:
                              // _controller.jumpTo(screenHeight);

                              // Otherwise use this:
                              _scrollController.animateTo(screenHeight,
                                  curve: Curves.easeOut,
                                  duration: const Duration(seconds: 1));
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(height: 15),
                  const QuizHistoryResultList(),
                ]),
              )),
        )),
      );
    });
  }
}
