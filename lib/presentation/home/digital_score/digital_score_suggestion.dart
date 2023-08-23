import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_controller.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_screen.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_detail.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';

class DigitalScoreSuggestions extends StatelessWidget {
  DigitalScoreSuggestions({super.key});

  final scoreController = Get.find<DigitalScoreController>();
  final homeController = Get.find<HomeController>();
  final newsController = Get.find<NewsController>();

  _text(context, String text, Color color) {
    return Text(text,
        style: themeTextStyle(
            context: context,
            tColor: color,
            fsize: 14,
            fweight: FontWeight.bold));
  }

  var assetList = AssetConst.SUGGESTION_IMAGES;
  List unusedList = [
    {
      "name": "facebook",
      "q": "use web",
      "url": "www.facebook.com",
      "action": [
        {"authorization": "deactivate account"},
        {"deletion": "deactivate account"}
      ]
    },
    {
      "name": "dribble",
      "q": "use app",
      "url": "www.dribble.com",
      "action": [
        {"authorization": "deactivate account"},
        {"deletion": "deactivate account"}
      ]
    },
    {
      "name": "instagram",
      "q": "use web",
      "url": "www.instagram.com",
      "action": [
        {"authorization": "deactivate account"},
        {"deletion": "deactivate account"}
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
            backgroundColor: Theme.of(context).cardColor,
            appBar: PreferredSize(
                preferredSize: Size(double.infinity,
                    homeController.onIndexSelected.value == 4 ? 0 : 60.h),
                child: homeController.onIndexSelected.value == 1
                    ? NewsScreenAppBar(
                        image: AssetConst.FEED_LOGO,
                        title: "Favorites",
                        subTitle: "Find your liked items here",
                      )
                    : homeController.onIndexSelected.value == 2
                        ? NewsScreenAppBar(
                            image: AssetConst.QUIZ_LOGO,
                            title: "Quizzes",
                            subTitle: "Test your knowledge",
                          )
                        : homeController.onIndexSelected.value == 3
                            ? NewsScreenAppBar(
                                image: AssetConst.VIDEO_LOGO,
                                title: "Videos",
                                subTitle: "Watch and take action",
                              )
                            : homeController.onIndexSelected.value == 4
                                ? Container()
                                // ? NewsScreenAppBar(
                                //     image: AssetConst.LOGO,
                                //     title: "Profile",
                                //     subTitle: "",
                                //   )
                                : AppBar(
                                    elevation: 0,
                                    centerTitle: false,
                                    // backgroundColor: whiteColor,
                                    leading: const CustomBackButton(),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            scoreController.getData();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                95, 0, 0, 0),
                                            child: Image.asset(
                                              AssetConst.ODEICON,
                                              width: 60.h,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // print("hi");
                                            // Get.to(DigitalScoreDetail());
                                          },
                                          child: Image.asset(
                                            AssetConst.DSICON,
                                            width: 70.h,
                                          ),
                                        ),
                                      ],
                                    ))),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IndexedStack(
                  index: homeController.onIndexSelected.value,
                  children: [
                    SingleChildScrollView(child:
                        GetBuilder<DigitalScoreController>(
                            builder: (controller) {
                      return controller.scoreLoading
                          ? SizedBox(
                              height: 700.h,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AssetConst.SEARCH,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _text(
                                        context,
                                        "Calculating your digital score",
                                        Theme.of(context).primaryColor)
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  //suggestions
                                  Container(
                                    height: 380.h,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      // color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Suggestions",
                                          style: themeTextStyle(
                                            context: context,
                                            tColor:
                                                Theme.of(context).primaryColor,
                                            fweight: FontWeight.w800,
                                            fsize: 20.w,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Flexible(
                                          child: Container(
                                            // height: 500.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                // primary: false,
                                                itemCount: scoreController
                                                    .suggestions.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 4.0),
                                                    child: Column(
                                                      children: [
                                                        Card(
                                                          elevation: 0,
                                                          color: Colors.white,
                                                          child: ListTile(
                                                            onTap: () {},
                                                            title: Text(
                                                              scoreController
                                                                      .suggestions[
                                                                  index]["title"],
                                                              style:
                                                                  themeTextStyle(
                                                                context:
                                                                    context,
                                                                tColor:
                                                                    darkBlueGreyColor,
                                                                fweight:
                                                                    FontWeight
                                                                        .w800,
                                                                // fsize: 20.w,
                                                              ),
                                                            ),
                                                            subtitle: Text(
                                                              scoreController
                                                                      .suggestions[
                                                                  index]["des"],
                                                              style: TextStyle(
                                                                color:
                                                                    darkBlueGreyColor,
                                                              ),
                                                            ),
                                                            leading: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    assetList[
                                                                        index],
                                                                    height:
                                                                        40.h),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        index <
                                                                scoreController
                                                                        .suggestions
                                                                        .length -
                                                                    1
                                                            ? Divider(
                                                                thickness: 1,
                                                                // indent: 20,
                                                                // endIndent: 20,
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                height: 5,
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //unused account
                                  Container(
                                    height: 380.h,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 15,
                                        // ),
                                        Text(
                                          "Unused accounts",
                                          style: themeTextStyle(
                                            context: context,
                                            tColor:
                                                Theme.of(context).primaryColor,
                                            fweight: FontWeight.w800,
                                            fsize: 20.w,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Flexible(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                // primary: false,
                                                itemCount: unusedList.length,
                                                itemBuilder: (BuildContext ctxt,
                                                    int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 4.0),
                                                    child: Column(
                                                      children: [
                                                        Card(
                                                          elevation: 0,
                                                          color: Colors.white,
                                                          child: ListTile(
                                                            onTap: () {},
                                                            title: Text(
                                                              unusedList[index]
                                                                  ["name"],
                                                              style:
                                                                  themeTextStyle(
                                                                context:
                                                                    context,
                                                                tColor:
                                                                    darkBlueGreyColor,
                                                                fweight:
                                                                    FontWeight
                                                                        .w800,
                                                                // fsize: 20.w,
                                                              ),
                                                            ),
                                                            subtitle: Row(
                                                              children: [
                                                                Text(
                                                                  "unused from 3 years",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                // Text(" "),
                                                                // Text(unusedList[index]
                                                                //     ["url"])
                                                              ],
                                                            ),
                                                            leading: Image.asset(
                                                                AssetConst
                                                                        .UNUSED_IMAGES[
                                                                    unusedList[
                                                                            index]
                                                                        [
                                                                        "name"]],
                                                                // "assets/images/facebook.png",
                                                                height: 40.h),
                                                          ),
                                                        ),
                                                        index <
                                                                scoreController
                                                                        .suggestions
                                                                        .length -
                                                                    1
                                                            ? Divider(
                                                                thickness: 1,
                                                                // indent: 20,
                                                                // endIndent: 20,
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                                height: 5,
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            scoreController.tagLine,
                                            style: themeTextStyle(
                                                context: context,
                                                tColor: scoreController
                                                    .tagLineColor,
                                                fweight: FontWeight.w800,
                                                fsize: 14),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                    })),
                    FavouriteScreen(),
                    QuizScreen(),
                    VideoScreen(),
                    ProfileScreen(),
                  ],
                ),
                Obx(
                  () => SafeArea(
                    child: AppBottomNavgationBar(
                      index: homeController.onIndexSelected.value,
                      onIndexSelected: (value) {
                        homeController.updateIndexSelected(value);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
