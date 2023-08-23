import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:datacoup/export.dart';
import 'package:transparent_image/transparent_image.dart';

passwordResetDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(.9),
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
            title: SizedBox(
          height: 160,
          width: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.greenAccent),
                  color: Colors.greenAccent.shade100,
                ),
                child: const Icon(Icons.done, color: Colors.greenAccent)),
            const SizedBox(height: 10),
            const Text("You have successfully reset your password !",
                style: TextStyle(
                    fontFamily: AssetConst.QUICKSAND_FONT,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  fixedSize: const Size(50, 10),
                  backgroundColor: Colors.greenAccent),
              onPressed: () {
                Get.offAll(() => Login());
              },
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: AssetConst.RALEWAY_FONT,
                ),
              ),
            ),
          ]),
        )),
      );
    },
  );
}

removeFavoriteContentDialog(BuildContext context, controller, Item data) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Warning!"),
          content: const Text("This content would be removed from favourites."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop();
                controller.likeAndUnlikeNews(
                  data: data,
                  isLiked: controller.allFavouriteNewsItem
                          .any((element) => element.newsId == data!.newsId)
                      ? false
                      : true,
                );
              },
            ),
          ],
        );
      });
}

addToFavoritesDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Added to Favorites!"),
          // content: const Text("This content would be removed from favourites."),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // TextButton(
            //   child: const Text("Confirm"),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     controller.likeAndUnlikeNews(
            //       data: data,
            //       isLiked: controller.allFavouriteNewsItem
            //               .any((element) => element.newsId == data!.newsId)
            //           ? false
            //           : true,
            //     );
            //   },
            // ),
          ],
        );
      });
}



// for whenever the user completes a quiz and there is a badge available to be given
successfulBadgeDialog(BuildContext context, String badgeLink, String badgeName){
  final random = Random();
  return showDialog(
    context: context,
    builder: (BuildContext context){
      final randomImage = AssetConst.TEMP_BADGES[random.nextInt(AssetConst.TEMP_BADGES.length)];
      return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      insetPadding: EdgeInsets.all(50),
      backgroundColor: Colors.white,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Congratulations! You have won the following badge",
              textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: darkBlueGreyColor,
                                fsize: 23.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,)
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              // child: CachedNetworkImage(
              //   imageUrl: badgeLink,
              //   fit: BoxFit.contain,
              //   placeholder: (context, url) => Image.asset(randomImage,
              //     height: 80 * SizeConfig().heightScale), // Placeholder widget while loading
              //   errorWidget: (context, url, error) => Icon(Icons.error), // Error widget when loading fails
                // imageBuilder: (context, imageProvider) => FadeInImage(
                  // placeholder: MemoryImage(kTransparentImage),
                  // image: imageProvider,
                  // fit: BoxFit.contain,
                // ),
              // ),

              child: Image.asset(randomImage, height: 80 * SizeConfig().heightScale),
            ),
            SizedBox(height: 20.0),
            Text(
              "${badgeName}",
              textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: darkBlueGreyColor,
                                fsize: 18.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,)
            ),
            SizedBox(height: 20.0),
            Text("View your badge in the Badges section of the Quiz dashboard", textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: darkBlueGreyColor,
                                fsize: 18.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,)),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              
              child: Text(
                "Close",
              ),
            ),
          ],
      ),
        );
    }
  );
}

failedQuizDialog(BuildContext context){
  return showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0.0,
      insetPadding: EdgeInsets.all(50),
      backgroundColor: Colors.white,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Oops! you need 50% or more to clear the quiz.",
              textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: darkBlueGreyColor,
                                fsize: 23.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,)
            ),
            SizedBox(height: 20.0),

            Text(
              "Reattempt the quiz again when you're ready.",
              textAlign: TextAlign.center, style: themeTextStyle(
                                tColor: darkBlueGreyColor,
                                fsize: 23.h,
                                fweight: FontWeight.w800,
                                fontFamily: AssetConst.QUICKSAND_FONT,
                                context: context,)
            ),
            SizedBox(height: 20.0),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.3,
            //   width: MediaQuery.of(context).size.width * 0.3,
            //   child: Center(child: Text("Badge image")),
            // ),
            // SizedBox(height: 20.0),
            // Text(
            //   "Data Privacy Expert",
            //   textAlign: TextAlign.center, style: themeTextStyle(
            //                     tColor: Theme.of(context).primaryColor,
            //                     fsize: 18.h,
            //                     fweight: FontWeight.w800,
            //                     fontFamily: AssetConst.QUICKSAND_FONT,
            //                     context: context,)
            // ),
            // SizedBox(height: 20.0),
            // Text("View your badge in the Badges section of the Quiz dashboard", textAlign: TextAlign.center, style: themeTextStyle(
            //                     tColor: Theme.of(context).primaryColor,
            //                     fsize: 18.h,
            //                     fweight: FontWeight.w800,
            //                     fontFamily: AssetConst.QUICKSAND_FONT,
            //                     context: context,)),
            // SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              
              child: Text(
                "Close",
              ),
            ),
          ],
      ),
        );
    }
  );
}