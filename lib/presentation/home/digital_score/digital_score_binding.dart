import 'package:datacoup/export.dart';
import 'package:datacoup/presentation/home/digital_score/digital_score_controller.dart';

class DigitalScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DigitalScoreController(),
    );
  }
}
