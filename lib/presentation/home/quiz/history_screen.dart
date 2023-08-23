import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/quiz/quiz_list/explore_quizzes_page.dart';
import 'package:datacoup/presentation/home/quiz/quiz_screen_controller.dart';
import 'package:datacoup/presentation/home/quiz/quiz_history_result_controller.dart';
import 'package:datacoup/presentation/home/quiz/user_quiz_history_list.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<QuizScreenController>(
    //   builder: (controller) {
    //     return Container(
    //       height: MediaQuery.of(context).size.height,
    //       child: SingleChildScrollView(
    //         physics: AlwaysScrollableScrollPhysics(),
    //         child: Column(
    //           children: [
    //             SizedBox(height: MediaQuery.of(context).size.height * 0.025),
    //             Text("Which path do you want to take?", textAlign: TextAlign.center, style: themeTextStyle(
    //                             tColor: Theme.of(context).primaryColor,
    //                             fsize: 26.h,
    //                             fweight: FontWeight.bold,
    //                             fontFamily: AssetConst.QUICKSAND_FONT,
    //                             context: context,
    //                             // underlineDecoration: quizScreenController.quizScreenType == 2 ? TextDecoration.underline: null,
    //                             // underlineColor: quizScreenController.quizScreenType == 2 ? Colors.orange : null,
    //                             // underlineThickness: quizScreenController.quizScreenType == 2 ? 5.0 : null),
    //             )),
    //             SizedBox(height: MediaQuery.of(context).size.height * 0.025),

    //             // create search bar here 

    //             Container(
    //               height: MediaQuery.of(context).size.height - 50,
    //               child: GridView.count(
    //                 scrollDirection: Axis.vertical,
    //                 shrinkWrap: true,
    //                 crossAxisCount: 2,
    //                 mainAxisSpacing: 10,
    //                 crossAxisSpacing: 10,
    //                 children: List.generate(20, (index){
    //                   return InkWell(
    //                     onTap: (){
    //                       print("Selected index $index");
    //                       // should route to the page which will take an index as a parameter and accordingly present the quizzes which relate to that path id
    //                     },
    //                     child: Container(
    //                       height: MediaQuery.of(context).size.height * 0.1,
    //                       width: MediaQuery.of(context).size.height * 0.1,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(20),
    //                         boxShadow: [
    //                           BoxShadow(
    //                             color: Colors.grey.withOpacity(0.5),
    //                             spreadRadius: 2,
    //                             blurRadius: 7,
    //                             offset: Offset(0, 3),
    //                           ),
    //                         ],
    //                         border: Border.all(
    //                           color: Colors.grey,
    //                           width: 2,
    //                         )
    //                       ),
    //                       // color: Colors.white,
    //                       child: Center(
    //                         child: Text(
    //                           'Path $index',
    //                           textAlign: TextAlign.center, style: themeTextStyle(
    //                               tColor: Theme.of(context).primaryColor,
    //                               fsize: 22.h,
    //                               fweight: FontWeight.bold,
    //                               fontFamily: AssetConst.QUICKSAND_FONT,
    //                               context: context,
    //                         )),
    //                       ),
    //                     ),
    //                   );
    //                 })
    //               ),
    //             )
    //           ]
    //         )
    //           ),
              
    //       );
    //   }
    //     );

      return GetBuilder<HomeController>(builder: (controller) {
        return controller.user == null
            ? Text("User History",
                style: themeTextStyle(
                  context: context,
                  tColor: Theme.of(context).primaryColor,
                  fsize: width(context)! * 0.030,
                  fweight: FontWeight.w800,
                ))
            : Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05), 
                UserHistoryList(odenId: controller.user!.value.odenId!)
              ]
              );
      });
    }
}