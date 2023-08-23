import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_binding.dart';

// defining routes
class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String verifyOtp = "/verifyOtp";
  static const String home = "/home";
  static const String editProfile = "/editProfile";
  static const String videoScreen = "/videoScreen";
  static const String quizScreen = "/QuizScreen";
  static const String allQuizScreen = "/allQuizScreen";
}

class AppPages {
  //pages list
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      bindings: [MainBinding(), SplashBinding(), AuthenticationBinding()],
      //defines what controller we have to use
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => Login(),
      bindings: [MainBinding(), LoginBinding(), AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignUp(),
      bindings: [MainBinding(), SignupBinding(), AuthenticationBinding()],
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      bindings: [
        MainBinding(),
        HomeBinding(),
        NewsBindings(),
        QuizBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.videoScreen,
      page: () => const VideoScreen(),
    ),
  ];
}
