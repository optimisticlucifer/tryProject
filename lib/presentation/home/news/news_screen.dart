import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_controller.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsScreen extends GetWidget<NewsController> {
  NewsScreen({super.key});

  final scoreController = Get.find<DigitalScoreController>();

  @override
  Widget build(BuildContext context) {
    var orange = Colors.orange;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 248.h,
            child: NewsOfTheDayWidget(),
          ),
          // SizedBox(height: 20.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 15.h),
          //   child: Row(
          //     children: [
          //       Icon(FontAwesomeIcons.link),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Text(
          //         "Quick Links",
          //         style: themeTextStyle(
          //             context: context, fweight: FontWeight.w700, fsize: 17),
          //       )
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 15.h),
          //   height: 50,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: greyColor, width: 2),
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: InkWell(
          //     onTap: () {
          //       Get.to(() => DigitalSoreScreen());
          //     },
          //     child: Row(children: [
          //       Icon(
          //         FontAwesomeIcons.boltLightning,
          //         color: deepOrangeColor,
          //       ),
          //       SizedBox(
          //         width: 10.w,
          //       ),
          //       Text(
          //         "Digital Score",
          //         style: TextStyle(
          //           color: Theme.of(context).primaryColor,
          //           fontFamily: AssetConst.QUICKSAND_FONT,
          //         ),
          //       )
          //     ]),
          //   ),
          // ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.fromLTRB(15.h, 0.h, 15.h, 5.h),
            margin: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
            decoration: BoxDecoration(
              // color: greyColor,
              border: Border.all(color: greyColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: GetBuilder<DigitalScoreController>(
              builder: (scoreController) {
                return SizedBox(
                  height: 75.h,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => DigitalSoreScreen());
                        },
                        child: Container(
                          height: 75.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: greyColor,
                            // border: Border.all(color: greyColor, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  AssetConst.DSICON,
                                  width: 55.w,
                                ),
                              ),
                              // SizedBox(
                              //   height: 5.h,
                              // ),
                              Text(
                                scoreController.score.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: orange,
                                  fontFamily: AssetConst.QUICKSAND_FONT,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      flex: 4,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => DigitalSoreScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Improve your digital score now",
                              style: themeTextStyle(
                                context: context,
                                tColor: Theme.of(context).primaryColor,
                                fweight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "  ${scoreController.suggestions.length.toString()} areas need attention.  ",
                                  style: themeTextStyle(
                                    context: context,
                                    fweight: FontWeight.w800,
                                    tColor: Theme.of(context).primaryColor,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.to(() => SocialMediaFeedWidget());
                    //     },
                    //     child: Container(
                    //         height: 70.h,
                    //         decoration: BoxDecoration(
                    //           // color: greyColor,
                    //           border: Border.all(color: greyColor, width: 2),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(
                    //               FontAwesomeIcons.boltLightning,
                    //               color: deepOrangeColor,
                    //             ),
                    //             SizedBox(
                    //               height: 5.h,
                    //             ),
                    //             Text(
                    //               "Latest Feeds",
                    //               style: TextStyle(
                    //                 color: Theme.of(context).primaryColor,
                    //                 fontWeight: FontWeight.w600,
                    //                 fontFamily: AssetConst.QUICKSAND_FONT,
                    //               ),
                    //             )
                    //           ],
                    //         )),
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.to(VideoReelsScreen());
                    //     },
                    //     child: Container(
                    //         height: 70.h,
                    //         decoration: BoxDecoration(
                    //           // color: greyColor,
                    //           border: Border.all(color: greyColor, width: 2.5),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(
                    //               FontAwesomeIcons.play,
                    //               color: deepOrangeColor,
                    //             ),
                    //             SizedBox(
                    //               height: 5.h,
                    //             ),
                    //             Text(
                    //               "Short Videos",
                    //               style: TextStyle(
                    //                 color: Theme.of(context).primaryColor,
                    //                 fontWeight: FontWeight.w600,
                    //                 fontFamily: AssetConst.QUICKSAND_FONT,
                    //               ),
                    //             )
                    //           ],
                    //         )),
                    //   ),
                    // ),
                  ]),
                );
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          NewsByInterest(),
          // NewsByInterest(),
          // SizedBox(
          //   height: height(context)! * 0.32,
          //   child: const NewsByInterest(),
          // ),
          // SizedBox(
          //   height: height(context)! * 0.31,
          //   child: const VideoOfTheDayWidget(),
          // ),
          // SizedBox(
          //   height: height(context)! * 0.3,
          //   child: const TrendingVideosWidget(),
          // ),
        ],
      ),
    );
  }
}
