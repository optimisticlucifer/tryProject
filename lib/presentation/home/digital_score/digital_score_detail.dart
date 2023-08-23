import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_controller.dart';
import 'package:datacoup/presentation/widgets/back_button.dart';
import 'package:pie_chart/pie_chart.dart';

class DigitalScoreDetail extends StatelessWidget {
  DigitalScoreDetail({super.key});

  final scoreController = Get.find<DigitalScoreController>();
  final homeController = Get.find<HomeController>();
  final newsController = Get.find<NewsController>();

  _isPasswordStrong(String pass) {
    pass = pass.toLowerCase();
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
                    Colors.grey.shade700),
              ],
            )));
  }

  __dataMap(context) {
    Map<String, double> dataMap = {};
    // print(
    //     "domaindetail ${Map<String, double>.from(scoreController.scoresPercentage).runtimeType}");

    dataMap = Map<String, double>.from(scoreController.scoresPercentage);
    dataMap["Password Strength"] = (scoreController.passScore.toDouble() /
            scoreController.score.toDouble()) *
        100;

    return dataMap;
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
              child: Stack(
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
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Score Detail  ",
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
                                        Text(
                                          scoreController.score.toString(),
                                          style: themeTextStyle(
                                            context: context,
                                            tColor: Colors.green,
                                            fweight: FontWeight.w800,
                                            fsize: 20.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 320.h,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          PieChart(
                                            dataMap: __dataMap(context),
                                            colorList: [
                                              Colors.orange[300]!,
                                              Colors.orange[400]!,
                                              Colors.orange[500]!,
                                              Colors.orange[600]!,
                                              Colors.orange[700]!,
                                              Colors.orange[800]!,
                                            ],
                                            legendOptions: LegendOptions(
                                              legendTextStyle: themeTextStyle(
                                                context: context,
                                                tColor: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(00),
                                          topRight: Radius.circular(00),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          FactorList(
                                            icon: AssetConst.PASSWORD_STRENGTH,
                                            title: 'Password strength',
                                            text: _text(
                                              context,
                                              "Your password is ${_isPasswordStrong(controller.time) ? " strong" : "weak"}",
                                              _isPasswordStrong(controller.time)
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
                                              _isPasswordStrong(controller.time)
                                                  ? "You are using a unique password"
                                                  : "Many similar password to yours are found",
                                              _isPasswordStrong(controller.time)
                                                  ? Colors.green.shade800
                                                  : redOpacityColor,
                                            ),
                                            expandedWidget: [],
                                          ),

                                          FactorList(
                                            icon: AssetConst.DATA_BREACH,
                                            title: 'Data breaches',
                                            text: _dataBreachText(context),
                                            expandedWidget:
                                                __dataBreachList(context),
                                          ),
                                          FactorList(
                                            icon: AssetConst.OS,
                                            title: 'Device operating system',
                                            text: _osText(context),
                                            expandedWidget: [],
                                          ),

                                          // ExpansionTile(
                                          //   title: Text('List-B'),
                                          //   children: _getChildren(3, 'B-'),
                                          // ),
                                        ],
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
                                      height: 200,
                                    ),
                                  ],
                                ));
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
              ),
            )),
      ),
    );
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
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
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
