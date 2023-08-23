import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list/explore_quizzes_page.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/user_quiz_history_list.dart';
import 'package:transparent_image/transparent_image.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override

  
  Widget build(BuildContext context) {
    final random = Random();

    return GetBuilder<QuizScreenController>(
      builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                SizedBox(
                    height: 260,
                    child: GetBuilder<QuizScreenController>(
                        init: QuizScreenController(),
                        builder: (controller) {
                          return Stack(
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      AssetConst.CIRCLES,
                                      errorBuilder: (context, error, map) {
                                        return Container(
                                          height: 200,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(75)),
                                        );
                                      },
                                      height: 250.0,
                                      width: 350.0,
                                    ),
                                  ),
                                  Positioned(
                                    top: MediaQuery.of(context).size.height * 0.065,
                                    left: MediaQuery.of(context).size.width * 0.35,
                                    child: ClipRRect(
                                        // borderRadius: BorderRadius.circular(75),
                                        child: controller.badge == ''
                                            ? const ShimmerBox(
                                                height: 150, width: 150, radius: 75)
                                            : Image.asset(
                                                AssetConst.BADGES[controller.badge]
                                                    .toString(),
                                                errorBuilder: (context, error, map) {
                                                  return Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(75)),
                                                  );
                                                },
                                                height: 100.0,
                                                width: 100.0,
                                              )),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: height(context)! * 0.23,
                                left: MediaQuery.of(context).size.width * 0.38,
                                child: controller.bestScore != ''
                                    ? Container(
                                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: greyColor,
                                                blurRadius: 5,
                                                spreadRadius: 3,
                                              )
                                            ],
                                            color: whiteColor,
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "${(controller.bestScore == 'null' ? '0' : controller.bestScore)}/100",
                                          style: TextStyle(
                                            // letterSpacing: 1.7,
                                            color: darkBlueGreyColor,
                                            fontSize: width(context)! * 0.03,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: AssetConst.QUICKSAND_FONT,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              Positioned(
                                top: height(context)! * 0.23,
                                left: MediaQuery.of(context).size.width *
                                    (controller.bestScore == '' ? 0.22 : 0.3),
                                child: controller.bestScore == ''
                                    ? Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: darkSkyBlueColor,
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          "You haven't taken any quiz yet",
                                          style: TextStyle(
                                            // letterSpacing: 1.7,
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 14,

                                            fontWeight: FontWeight.w800,
                                            fontFamily: AssetConst.QUICKSAND_FONT,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                left: MediaQuery.of(context).size.width * 0.62,
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: greyColor,
                                              blurRadius: 4,
                                              spreadRadius: 3)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: whiteColor),
                                    // margin: const EdgeInsets.fromLTRB(180, 100, 0, 0),
                                    child: Text(
                                      controller.badge != ''
                                          ? controller.badge
                                          : "Digital Novice",
                                      style: TextStyle(
                                          fontFamily: AssetConst.QUICKSAND_FONT,
                                          fontSize: width(context)! * 0.030,
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueGreyColor),
                                    )),
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: GetBuilder<QuizScreenController>(builder: (controller) {
                      return Text(
                          StringConst.BADGE_WISE_CENTER_TEXT[controller.badge].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // letterSpacing: 1.7,
                            color: Theme.of(context).primaryColor,
                            fontSize: width(context)! * 0.035,
                            fontWeight: FontWeight.w800,
                            fontFamily: AssetConst.QUICKSAND_FONT,
                          ));
                    }),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  Text("Badges Earned", textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: Theme.of(context).primaryColor,
                                fsize: 23.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,
                                // underlineDecoration: quizScreenController.quizScreenType == 2 ? TextDecoration.underline: null,
                                // underlineColor: quizScreenController.quizScreenType == 2 ? Colors.orange : null,
                                // underlineThickness: quizScreenController.quizScreenType == 2 ? 5.0 : null
                              )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  controller.badgeDataList.isEmpty ? 
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1, 
                    child: Center(
                      child: Text("No badges earned yet", style: themeTextStyle(
                                    tColor: Theme.of(context).primaryColor,
                                    fsize: 16.h,
                                    fweight: FontWeight.bold,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                    context: context,
                                  ))
                      )
                    ) 
                  : 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.badgeDataList.length, 
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      final randomImage = AssetConst.TEMP_BADGES[random.nextInt(AssetConst.TEMP_BADGES.length)];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: InkWell(
                          onTap: (){
                            // successfulBadgeDialog(context);
                            print("Tapped on it");
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            // width: MediaQuery.of(context).size.width * 0.001,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // CachedNetworkImage(
                                //   imageUrl: controller.badgeDataList[index].badgeLink,
                                //   fit: BoxFit.contain,
                                //   placeholder: (context, url) => Image.asset(randomImage,
                                //     height: 80 * SizeConfig().heightScale), // Placeholder widget while loading
                                //   errorWidget: (context, url, error) => Icon(Icons.error), // Error widget when loading fails
                                //   imageBuilder: (context, imageProvider) => FadeInImage(
                                //     placeholder: MemoryImage(kTransparentImage),
                                //     image: imageProvider,
                                //     fit: BoxFit.contain,
                                //   ),
                                // ),
                                Image.asset(randomImage, height: 80 * SizeConfig().heightScale),
                                SizedBox(height: 10),
                                Text(
                                  controller.badgeDataList[index].badgeName,
                                  style: themeTextStyle(
                                    tColor: darkBlueGreyColor,
                                    fsize: 22.h,
                                    fweight: FontWeight.bold,
                                    fontFamily: AssetConst.QUICKSAND_FONT,
                                    context: context,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  )
                
              ]
            )
              ),
              
          );
      }
        );

  }
}