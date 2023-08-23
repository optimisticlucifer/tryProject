import 'package:datacoup/export.dart';

class VideoReelsScreen extends StatefulWidget {
  const VideoReelsScreen({super.key});

  @override
  State<VideoReelsScreen> createState() => VideoReelsScreenState();
}

class VideoReelsScreenState extends State<VideoReelsScreen> {
  final newsController = Get.find<NewsController>();

  NewsModel? newsModel;

  @override
  void initState() {
    loadData();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  loadData() async {
    newsController.reelVideosLoader(true);
    newsModel = await newsController.getAllNews(
      type: newsController.selectedkeyInterestforReelVideo.value
          .replaceAll("Article", "Short_Video"),
      count: newsController.newsOfDayCount.value,
    );
    newsController.reelVideosLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => newsController.reelVideosLoader.value
              ? Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: const ShimmerBox(
                      height: double.infinity,
                      width: double.infinity,
                      radius: 12),
                )
              : newsModel == null
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: themeTextStyle(context: context),
                      ),
                    )
                  : Stack(
                      children: [
                        newsModel!.items!.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceFrownOpen,
                                      size: width(context)! * 0.15,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "No Videos Found for \n${newsController.selectedkeyInterestforReelVideo.value.replaceAll("_Article", "")}",
                                      textAlign: TextAlign.center,
                                      style: themeTextStyle(
                                        context: context,
                                        fsize: klargeFont(context),
                                        fweight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : VideoPlayerWidget(
                                startIndex: 0,
                                items: newsModel!.items!,
                              ),

                        // PageView.builder(
                        //     // gridDelegate:
                        //     //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //     //   crossAxisCount: 1,
                        //     //   mainAxisSpacing: 1,
                        //     //   crossAxisSpacing: 1,
                        //     //   childAspectRatio: 2,
                        //     // ),
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: newsModel!.items!.length,
                        //     itemBuilder: (context, index) {
                        //       final data = newsModel!.items![index];
                        //       return VideoPlayerWidget();

                        //       Container(
                        //         decoration: BoxDecoration(
                        //             border: Border.all(color: Colors.grey),
                        //             borderRadius:
                        //                 BorderRadius.circular(15)),
                        //         margin:
                        //             const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        //         child: InkWell(
                        //           customBorder: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(15),
                        //           ),
                        //           // borderRadius: BorderRadius.circular(100),
                        //           onTap: () {
                        //             Get.to(
                        //               () => VideoPlayerWidget(
                        //                 startIndex: index,
                        //                 items: newsModel!.items!,
                        //               ),
                        //             );
                        //           },
                        //           child: ClipRRect(
                        //             borderRadius: BorderRadius.circular(15),
                        //             child: CacheImageWidget(
                        //               imageUrl: data.headerMultimedia,
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        Positioned(
                          right: 15.0,
                          bottom: 100.0,
                          child: ActionChip(
                            avatar: CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: const FaIcon(
                                  FontAwesomeIcons.filter,
                                  color: deepOrangeColor,
                                  size: 14,
                                )),
                            label: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Category',
                                style: themeTextStyle(
                                    context: context, tColor: Colors.black),
                              ),
                            ),
                            onPressed: filterBottomSheet,
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  filterBottomSheet() => Get.bottomSheet(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        isScrollControlled: true,
        ignoreSafeArea: false,
        persistent: true,
        enableDrag: true,
        Obx(
          () => Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kBorderRadius),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Video category",
                          style: themeTextStyle(
                            context: context,
                            letterSpacing: 1.5,
                            fsize: klargeFont(context),
                            fweight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const FaIcon(
                            FontAwesomeIcons.xmark,
                            color: deepOrangeColor,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 20),
                    // Text(
                    //   "Video category",
                    //   style: themeTextStyle(
                    //     context: context,
                    //     letterSpacing: 1.5,
                    //     fsize: klargeFont(context),
                    //     fweight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List.generate(
                        newsController.keyInterestAreas.length,
                        (index) => ActionChip(
                          backgroundColor: newsController
                                      .selectedkeyInterestforReelVideo.value ==
                                  newsController.keyInterestAreas[index]
                              ? deepOrangeColor
                              : Colors.grey,
                          labelStyle: themeTextStyle(
                            fsize: ksmallFont(context),
                            context: context,
                            tColor: whiteColor,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          label: Text(
                            newsController.keyInterestAreas[index] ==
                                    "Protect yourself_Article"
                                ? "Protect Yourself"
                                : newsController.keyInterestAreas[index]
                                    .replaceAll("_Article", ""),
                          ),
                          onPressed: () async {
                            newsController.selectedkeyInterestforReelVideo(
                                newsController.keyInterestAreas[index]);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   "Type",
                    //   style: themeTextStyle(
                    //     context: context,
                    //     letterSpacing: 1.5,
                    //     fsize: klargeFont(context),
                    //     fweight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // Wrap(
                    //   runSpacing: 5,
                    //   spacing: 5,
                    //   children: List.generate(
                    //     newsController.reelVideosTypes.length,
                    //     (index) => ActionChip(
                    //       backgroundColor:
                    //           newsController.selectedReelVideoType.value ==
                    //                   newsController.reelVideosTypes[index]
                    //               ? deepOrangeColor
                    //               : Colors.grey,
                    //       labelStyle: themeTextStyle(
                    //         fsize: ksmallFont(context),
                    //         context: context,
                    //         tColor: whiteColor,
                    //       ),
                    //       padding: const EdgeInsets.symmetric(horizontal: 12),
                    //       label: Text(
                    //         newsController.reelVideosTypes[index],
                    //       ),
                    //       onPressed: () async {
                    //         newsController.selectedReelVideoType(
                    //             newsController.reelVideosTypes[index]);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 20),
                    Text(
                      "Popular channels",
                      style: themeTextStyle(
                        context: context,
                        letterSpacing: 1.5,
                        fsize: klargeFont(context),
                        fweight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      runSpacing: 5,
                      spacing: 5,
                      children: List.generate(
                        newsController.reelVideosChannels.length,
                        (index) => ActionChip(
                          backgroundColor:
                              newsController.selectedReelVideoChannels.value ==
                                      newsController.reelVideosChannels[index]
                                  ? deepOrangeColor
                                  : Colors.grey,
                          labelStyle: themeTextStyle(
                            fsize: ksmallFont(context),
                            context: context,
                            tColor: whiteColor,
                          ),
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const FaIcon(
                              FontAwesomeIcons.youtube,
                              color: redOpacityColor,
                              size: 14,
                            ),
                          ),
                          label: Text(
                            newsController.reelVideosChannels[index],
                          ),
                          onPressed: () async {
                            newsController.selectedReelVideoType(
                                newsController.reelVideosTypes[index]);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   "Trending",
                    //   style: themeTextStyle(
                    //     context: context,
                    //     letterSpacing: 1.5,
                    //     fsize: klargeFont(context),
                    //     fweight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // Wrap(
                    //   runSpacing: 5,
                    //   spacing: 5,
                    //   children: List.generate(
                    //     newsController.reelVideosTrendingTypes.length,
                    //     (index) => ActionChip(
                    //       backgroundColor: newsController
                    //                   .selectedReelVideoTrending.value ==
                    //               newsController.reelVideosTrendingTypes[index]
                    //           ? deepOrangeColor
                    //           : Colors.grey,
                    //       labelStyle: themeTextStyle(
                    //         fsize: ksmallFont(context),
                    //         context: context,
                    //         tColor: whiteColor,
                    //       ),
                    //       label: Text(
                    //         newsController.reelVideosTrendingTypes[index],
                    //       ),
                    //       onPressed: () async {
                    //         newsController.selectedReelVideoTrending(
                    //             newsController.reelVideosTrendingTypes[index]);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: ActionChip(
                    //     backgroundColor: deepOrangeColor,
                    //     padding: const EdgeInsets.symmetric(horizontal: 24),
                    //     labelStyle: themeTextStyle(
                    //         fsize: ksmallFont(context),
                    //         context: context,
                    //         tColor: whiteColor),
                    //     label: const Text("Apply"),
                    //     onPressed: () {
                    //       Get.back();
                    //       loadData();
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
