import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list/explore_quizzes_page.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/user_quiz_history_list.dart';

class PathScreen extends StatelessWidget {
  PathScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return GetBuilder<QuizScreenController>(
      builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Text("Which path do you want to take?", textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: Theme.of(context).primaryColor,
                                fsize: 26.h,
                                fweight: FontWeight.bold,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,
                )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                // create search bar here 

                Container(
                  height: MediaQuery.of(context).size.height - 50,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: List.generate(controller.pathDataList.length, (index){
                      final pathData = controller.pathDataList[index];
                      final randomImage = AssetConst.PATH_IMAGES[random.nextInt(AssetConst.PATH_IMAGES.length)];
                      return InkWell(
                        onTap: (){
                          print("Selected path Id ${pathData.pathId}");

                          // set the current pathId to pathId instead of index
                          controller.setCurrentPathId(pathData.pathId.toString());
                          controller.setCurrentPathName(pathData.pathName.toString());
                          controller.setCurrentLevel(pathData.current_level.toString());
                          controller.setTotalLevel(pathData.quizzes_total.toString());

                          // change the quiz list function to take pathId and accordingly render the quizzes related to path id only.
                          Get.to(() => QuizList(
                            // odenId: homeController.user!.value.odenId!,
                            pathId: pathData.pathId.toString()
                          ));
                          // should route to the page which will take an index as a parameter and accordingly present the quizzes which relate to that path id
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            )
                          ),
                          // color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.asset(randomImage)
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '${pathData.pathName}',
                                  textAlign: TextAlign.center, style: themeTextStyle(
                                      tColor: darkBlueGreyColor,
                                      fsize: 22.h,
                                      fweight: FontWeight.bold,
                                      fontFamily: AssetConst.QUICKSAND_FONT,
                                      context: context,
                                )),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: LinearProgressIndicator(
                                  color: deepOrangeColor,
                                  backgroundColor: deepOrangeColor.withOpacity(0.2),
                                  value: int.parse(pathData.quizzes_taken) /
                                      int.parse(pathData.quizzes_total),
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  '${pathData.quizzes_taken} / ${pathData.quizzes_total}',
                                  textAlign: TextAlign.center, style: themeTextStyle(
                                      tColor: darkBlueGreyColor,
                                      fsize: 18.h,
                                      fweight: FontWeight.bold,
                                      fontFamily: AssetConst.QUICKSAND_FONT,
                                      context: context,
                                )),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ),
                )
              ]
            )
              ),
              
          );
      }
    );
  }
}