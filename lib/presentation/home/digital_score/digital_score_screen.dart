import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_controller.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_detail.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_suggestion.dart';

class DigitalSoreScreen extends StatelessWidget {
  DigitalSoreScreen({super.key});

  final scoreController = Get.find<DigitalScoreController>();
  final homeController = Get.find<HomeController>();
  final newsController = Get.find<NewsController>();

  // }

  //   _textPasswordStrength(){

  // }

  //   _textPasswordStrength(){

  // }

  _isPasswordStrong(String pass) {
    pass = pass.toLowerCase();
    // print(" domainprint ${scoreController.compromisedDomains}");
    return pass.contains("year") ? true : false;
  }

  _text(context, String text, Color color) {
    return Text(text,
        style: themeTextStyle(
            context: context,
            tColor: color,
            fsize: 14,
            fweight: FontWeight.bold));
  }

  _dataBreachText(context) {
    return scoreController.compromisedDomains.isEmpty
        ? _text(context, "No data breach domains found for your account!",
            Colors.green.shade800)
        : _text(
            context,
            "${scoreController.compromisedDomains.length} domains of data breaches found!",
            redOpacityColor);
  }

  _osText(context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _text(context, scoreController.deviceName, Colors.grey.shade600),
          scoreController.deviceOSVersion < scoreController.availableVersion
              ? _text(
                  context,
                  "Using outdated version - ${scoreController.deviceOSVersion}",
                  redOpacityColor)
              : _text(
                  context,
                  "Using latest version - ${scoreController.deviceOSVersion}",
                  Colors.green.shade800)
        ]);
  }

  __dataBreachList(context) {
    return List.generate(
        scoreController.compromisedDomains.length,
        (index) => Padding(
            padding: EdgeInsets.only(bottom: 5, left: 75),
            child: Row(
              children: [
                _text(
                    context,
                    scoreController.compromisedDomains[index]["name"],
                    // scoreController.compromisedDomains.length.toString(),
                    Colors.grey.shade700),
              ],
            )));
  }

  _getProgressColor(int score) {
    return score > 900
        ? Colors.green.shade400
        : score >= 600
            ? Colors.orange
            : score >= 300
                ? Colors.yellow.shade600
                : Colors.red;
  }

  _getScoreText(int score) {
    return score > 900
        ? "Excellent"
        : score >= 600
            ? "Very Good"
            : score >= 300
                ? "Good"
                : "Poor";
  }

  __getIcon(int change) {
    return change > 0
        ? Icon(
            Icons.arrow_upward,
            color: Colors.green,
          )
        : Icon(
            Icons.arrow_downward,
            color: Colors.red,
          );
  }

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
                                        margin:
                                            EdgeInsets.fromLTRB(95, 0, 0, 0),
                                        child: Image.asset(
                                          AssetConst.ODEICON,
                                          width: 60.h,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // print("hi");
                                        Get.to(DigitalScoreDetail());
                                      },
                                      child: Image.asset(
                                        AssetConst.DSICON,
                                        width: 70.h,
                                      ),
                                    ),
                                  ],
                                ))),
        body: RefreshIndicator(
          onRefresh: newsController.refreshAll,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            IndexedStack(
                index: homeController.onIndexSelected.value,
                children: [
                  SingleChildScrollView(
                    child: GetBuilder<DigitalScoreController>(
                        builder: (controller) {
                      return controller.scoreLoading
                          ? SizedBox(
                              height: 700.h,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AssetConst.DSICON,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Stack(
                                // alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          height: 330.h,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: SizedBox(
                                                  height: 250.h,
                                                  width: 350.w,
                                                  //arc
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Positioned(
                                                        bottom: 50.h,
                                                        left: 10.w,
                                                        child: Text(
                                                          "Poor",
                                                          style: themeTextStyle(
                                                              context: context,
                                                              fsize: 20,
                                                              fweight:
                                                                  FontWeight
                                                                      .w800,
                                                              tColor: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 200.h,
                                                        left: 20.w,
                                                        child: Text(
                                                          "Good",
                                                          style: themeTextStyle(
                                                              context: context,
                                                              fsize: 20,
                                                              fweight:
                                                                  FontWeight
                                                                      .w800,
                                                              tColor: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 220.h,
                                                        right: 5.w,
                                                        child: Text(
                                                          "Very Good",
                                                          style: themeTextStyle(
                                                              context: context,
                                                              fsize: 20,
                                                              fweight:
                                                                  FontWeight
                                                                      .w800,
                                                              tColor: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 50.h,
                                                        right: 0.w,
                                                        child: Text(
                                                          "Excellent",
                                                          style: themeTextStyle(
                                                              context: context,
                                                              fsize: 20,
                                                              fweight:
                                                                  FontWeight
                                                                      .w800,
                                                              tColor: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: 30.h,
                                                        left: 60.w,
                                                        child:
                                                            SleekCircularSlider(
                                                          appearance:
                                                              CircularSliderAppearance(
                                                            size: 210.w,
                                                            startAngle: 120,
                                                            angleRange: 300,
                                                            customWidths:
                                                                CustomSliderWidths(
                                                                    handlerSize:
                                                                        7,
                                                                    trackWidth:
                                                                        20,
                                                                    progressBarWidth:
                                                                        20),
                                                            customColors:
                                                                CustomSliderColors(
                                                              hideShadow: true,
                                                              trackGradientEndAngle:
                                                                  360,
                                                              trackColors: [
                                                                Colors.orange,
                                                                Colors.green
                                                                    .shade400,
                                                                Colors.green
                                                                    .shade400,
                                                                Colors.red,
                                                                Colors.red,
                                                                Colors.red,
                                                                Colors.yellow,
                                                                Colors.yellow,
                                                                Colors.yellow,
                                                                Colors.orange,
                                                                Colors.orange,
                                                                Colors.orange,
                                                              ],
                                                              progressBarColor:
                                                                  Colors
                                                                      .transparent,
                                                            ),
                                                          ),
                                                          min: 0,
                                                          max: 1000,
                                                          initialValue:
                                                              controller.score *
                                                                  1.0,
                                                          innerWidget:
                                                              (double value) {
                                                            return Center(
                                                                child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  (value.truncate())
                                                                      .toString(),
                                                                  style: themeTextStyle(
                                                                      context:
                                                                          context,
                                                                      fsize: 40,
                                                                      fweight:
                                                                          FontWeight
                                                                              .w800,
                                                                      tColor: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                ),
                                                                Text(
                                                                  "/1000",
                                                                  style: themeTextStyle(
                                                                      context:
                                                                          context,
                                                                      fsize: 15,
                                                                      fweight:
                                                                          FontWeight
                                                                              .w700,
                                                                      tColor: Theme.of(
                                                                              context)
                                                                          .primaryColor
                                                                          .withOpacity(
                                                                              0.7)),
                                                                ),
                                                              ],
                                                            ));
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Your Digital Score is",
                                                        style: themeTextStyle(
                                                            context: context,
                                                            fsize: 16,
                                                            tColor: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fweight: FontWeight
                                                                .w800),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              _getProgressColor(
                                                                      controller
                                                                          .score)
                                                                  .withOpacity(
                                                                      0.2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Text(
                                                          _getScoreText(
                                                              controller.score),
                                                          style: themeTextStyle(
                                                              context: context,
                                                              fweight:
                                                                  FontWeight
                                                                      .w800,
                                                              tColor:
                                                                  _getProgressColor(
                                                                      controller
                                                                          .score)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        child: __getIcon(
                                                            controller
                                                                .scoreChange),
                                                      ),
                                                      Text(
                                                        "${controller.scoreChange.abs()} for the past 30 days",
                                                        style: themeTextStyle(
                                                            context: context,
                                                            fsize: 16,
                                                            tColor: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fweight: FontWeight
                                                                .w800),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Score Factors",
                                        style: themeTextStyle(
                                          context: context,
                                          tColor:
                                              Theme.of(context).primaryColor,
                                          fweight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Factors that effect your digital score",
                                        style: themeTextStyle(
                                            context: context,
                                            tColor: Colors.grey.shade600,
                                            fweight: FontWeight.w800,
                                            fsize: 14),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        height: 300.h,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              FactorList(
                                                icon: AssetConst
                                                    .PASSWORD_STRENGTH,
                                                title: 'Password strength',
                                                text: _text(
                                                  context,
                                                  "Your password is ${_isPasswordStrong(controller.time) ? " strong" : "weak"}",
                                                  _isPasswordStrong(
                                                          controller.time)
                                                      ? Colors.green.shade800
                                                      : redOpacityColor,
                                                ),
                                                expandedWidget: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 72, bottom: 10),
                                                      child: _text(
                                                          context,
                                                          "It will take approx ${controller.time} to crack your password by brute-force method",
                                                          Colors.grey.shade600))
                                                ],
                                              ),
                                              FactorList(
                                                icon: AssetConst.PASSWORD_REUSE,
                                                title: 'Password reusability',
                                                text: _text(
                                                  context,
                                                  _isPasswordStrong(
                                                          controller.time)
                                                      ? "You are using a unique password"
                                                      : "Many similar password to yours are found",
                                                  _isPasswordStrong(
                                                          controller.time)
                                                      ? Colors.green.shade800
                                                      : redOpacityColor,
                                                ),
                                                expandedWidget: [],
                                              ),
                                              FactorList(
                                                icon: AssetConst.DATA_BREACH,
                                                title: 'Data breaches',
                                                text: _dataBreachText(context),
                                                expandedWidget: [],
                                              ),
                                              FactorList(
                                                icon: AssetConst.OS,
                                                title:
                                                    'Device operating system',
                                                text: _osText(context),
                                                expandedWidget: [],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          scoreController.tagLine,
                                          style: themeTextStyle(
                                              context: context,
                                              tColor:
                                                  scoreController.tagLineColor,
                                              fweight: FontWeight.w800,
                                              fsize: 14),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: 380.w,
                                          height: 40.h,
                                          child: ElevatedButton(
                                            onPressed: () => {
                                              Get.to(DigitalScoreSuggestions())
                                            },
                                            child: Text(
                                              "Improve your score",
                                              style: themeTextStyle(
                                                  context: context,
                                                  fsize: 16,
                                                  tColor: Colors.white,
                                                  fweight: FontWeight.w800),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.orange[400]),
                                                shape:
                                                    MaterialStateProperty.all(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)))),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 200.h,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    }),
                  ),
                  FavouriteScreen(),
                  QuizScreen(),
                  VideoScreen(),
                  ProfileScreen(),
                ]),
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
          ]),
        ),
      ),
    ));
  }
}

class FactorList extends StatelessWidget {
  FactorList({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
    required this.expandedWidget,
  });
  final String title;
  Widget text;
  String icon;
  List<Widget> expandedWidget;
  // List<Widget> childrens;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: IgnorePointer(
        ignoring: expandedWidget.isEmpty ? true : false,
        child: ExpansionTile(
          leading: Image.asset(
            icon,
            height: 40,
            width: 40,
            color: Theme.of(context).primaryColor,
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: themeTextStyle(
                  context: context,
                  tColor: Theme.of(context).primaryColor,
                  fweight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 5),
              text,
            ],
          ),
          children: expandedWidget,
          trailing: expandedWidget.isEmpty ? Text("") : null,
          expandedAlignment: Alignment.center,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          collapsedBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //
        ),
      ),
    );
  }
}
