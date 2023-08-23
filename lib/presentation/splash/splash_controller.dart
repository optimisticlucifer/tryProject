import 'dart:developer';
import 'package:datacoup/export.dart';

class SplachController extends GetxController {
  final LocalRepositoryInterface localRepositoryInterface;
  final ApiRepositoryInterface apiRepositoryInterface;
  SplachController({
    required this.localRepositoryInterface,
    required this.apiRepositoryInterface,
  });

  @override
  void onReady() {
    validateSession();
    validateTheme();
    super.onReady();
  }

  getProperDataLoad() async {
    final authController = Get.find<AuthenticationController>();
    await authController.initializeUser();
  }

  // getting the theme selected by user
  void validateTheme() async {
    final isDark = await localRepositoryInterface.isDarkMode();
    if (isDark != null) {
      Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  // handling auth flow
  void validateSession() async {
    await getProperDataLoad();
    await apiRepositoryInterface.cogintoRegister();
    bool result = await apiRepositoryInterface.checkAuthenticated();
    log("user valid $result");
    if (result) {
      Get.offNamed(AppRoutes.home);
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
}
