import 'package:datacoup/export.dart';

class NewsOfTheDayWidget extends StatefulWidget {
  const NewsOfTheDayWidget({super.key});

  @override
  State<NewsOfTheDayWidget> createState() => NewsOfTheDayWidgetState();
}

class NewsOfTheDayWidgetState extends State<NewsOfTheDayWidget> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    loadNewofDay();
    super.initState();
  }

  loadNewofDay() async {
    newsController.newsOfDayLoader(true);
    newsModel = null;
    newsModel = await newsController.getAllNews(
      type: StringConst.newsOfTheDay,
      count: newsController.newsOfDayCount.value,
    );
    newsController.newsOfDayLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => newsController.newsOfDayLoader.value
          ? const ShimmerBox(height: double.infinity, width: double.infinity)
          : PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsModel!.items!.length,
              itemBuilder: (context, index) {
                final data = newsModel!.items![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        CacheImageWidget(
                          imageUrl: data.headerMultimedia,
                          color: Colors.black54,
                          cFit: BoxFit.cover,
                          imgheight: double.infinity,
                          imgwidth: double.infinity,
                          colorBlendMode: BlendMode.darken,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: width(context)! * 0.7,
                                child: Text(
                                  data.title!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: themeTextStyle(
                                    context: context,
                                    tColor: whiteColor,
                                    fweight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(() => WebViewWidget(
                                        data: data,
                                        url: data.content!.link,
                                        showAppbar: true,
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  backgroundColor: Colors.transparent,
                                  shape: const StadiumBorder(
                                      side: BorderSide(color: Colors.grey)),
                                ),
                                child: const Text(
                                  "Read",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Positioned(
                        //   right: 10.0,
                        //   bottom: 20.0,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       Get.to(() => WebViewWidget(
                        //             data: data,
                        //             url: data.content!.link,
                        //             showAppbar: true,
                        //           ));
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       elevation: 10,
                        //       backgroundColor: Colors.transparent,
                        //       shape: const StadiumBorder(
                        //           side: BorderSide(color: Colors.grey)),
                        //     ),
                        //     child: const Text(
                        //       "Learn more",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
