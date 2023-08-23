import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:datacoup/export.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:dartpy/dartpy.dart';
// import 'dart:html';

class DigitalScoreController extends GetxController {
  String time = '';
  int score = 0;
  int passScore = 0;
  List<dynamic> compromisedDomains = [];
  Map scoresPercentage = {};
  int scoreChange = 0;
  List<dynamic> suggestions = [];

  int deviceOSVersion = 0;
  double availableVersion = 0;

  String deviceName = '';

  bool scoreLoading = true;
  String tagLine = "Guarding Digital Trust.";
  Color tagLineColor = Colors.orange;

  final UserProfileController _userController =
      Get.find<UserProfileController>();

  @override
  onInit() {
    getData();
    // print("cokkies ${document.cookie}");
    super.onInit();
  }

  getData() async {
    try {
      scoreLoading = true;

      update();
      await _getOsVersion();
      String deviceType = Platform.isAndroid ? "Android" : "iPhone";
      String version =
          "${Platform.isAndroid ? "Android" : "iOS"} $deviceOSVersion";
      String contactType = _userController.user!.primary ?? '';
      String contact = (contactType == "email")
          ? (_userController.user!.email ?? '')
          : (_userController.user!.phone ?? '');
      String odenId = (_userController.user!.odenId ?? '');
      String digest =
          sha1.convert(utf8.encode(GetStorage().read("pass"))).toString();
      var reqBody = {
        'contact': contact,
        'contactType': contactType,
        'odenId': odenId,
        'password': digest,
        'type': deviceType,
        'version': version,
      };

      print("reqBody $reqBody");

      var data = await ApiRepositoryImpl().getDigitalScoreApi(
        // contact: contact,
        contact: "hello@example.com",
        contactType: contactType,
        odenId: odenId,
        password: digest,
        type: deviceType,
        version: version,
      );

      print("Got the data $data");
      Map<String, dynamic> strength =
          passwordStrength(GetStorage().read("pass"));
      // print("strength $strength");
      scoreChange = data['scoreChange'];
      // scoreChange = -2;
      // print("scorechange $scoreChange");
      time = strength['time'];
      score = data["Score"] + (strength['Score']).toInt();
      passScore = strength['Score'].toInt();
      // score = int.parse(strength['Score']) + tempScore;
      // print("scoretip $score ${data["Score"] + strength['Score']}");
      print("scoretip $passScore ");
      // print("I am here right now");
      compromisedDomains = List<dynamic>.from(data["domain"] as List);
      scoresPercentage = data["scoresPercentage"];
      // print("domainlist ${compromisedDomains[0]["name"]}");
      print("domainlist ${scoresPercentage}");
      scoreLoading = false;

      suggestions = data["suggestions"];
      print("suggestions ${suggestions[0]["title"]}");

      update();
    } catch (e) {
      scoreLoading = false;
      print("I am in catch digit ${e}");
      update();
    }
  }

  _getOsVersion() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceOSVersion = int.parse(androidInfo.version.release);
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      deviceName = '$manufacturer $model';
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      deviceOSVersion = int.tryParse(iosInfo.systemVersion!) ?? 0;
      var name = iosInfo.name;
      var model = iosInfo.model;
      deviceName = name!;
      // print('$systemName $version, $name $model');
      // // iOS 13.1, iPhone 11 Pro Max iPhone
    }
    // print(object)
    update();
  }

  Color getScoreColor(int score) {
    return score > 900
        ? Colors.green.shade400
        : score >= 800
            ? Colors.green
            : score >= 600
                ? Colors.orange
                : score >= 300
                    ? Colors.yellow.shade600
                    : Colors.red;
  }

  Map<String, dynamic> passwordStrength(String password) {
    try {
      List<List<String>> arr = [
        [
          "0",
          "0",
          "0",
          "0",
          "0",
          "0",
          "0",
          "2 secs",
          "25 secs",
          "4 min",
          "41 min",
          "6 hours",
          "2 days",
          "4 weeks",
          "9 months"
        ],
        [
          '0',
          '0',
          '0',
          '0',
          '5 secs',
          '2 min',
          '58 min',
          '1 day',
          '3 weeks',
          '1 year',
          '51 years',
          '1k years',
          '34k years',
          '800k years',
          '23 million years'
        ],
        [
          '0',
          '0',
          '0',
          '25 secs',
          '22 min',
          '19 hours',
          '1 month',
          '5 years',
          '300 years',
          '16k years',
          '800k years',
          '43 million years',
          '2 billion years',
          '100 billion years',
          '6 trillion years'
        ],
        [
          '0',
          '0',
          '1 secs',
          '1 min',
          '1 hour',
          '3 days',
          '7 months',
          '41 years',
          '2k years',
          '100k years',
          '9 million years',
          '600 million years',
          '37 billion years',
          "2 trillion years'",
          '100 trillion years'
        ],
        [
          '0',
          '0',
          '5 secs',
          '6 min',
          '8 hours',
          '3 weeks',
          '5 years',
          '400 years',
          '34k years',
          '2 million years',
          '200 million years',
          '15 billion years',
          '1 trillion years',
          '93 trillion years',
          '7 quadrillion years'
        ]
      ];

      int len = password.length;

      List<RegExp> patterns = [
        RegExp(r"[0-9]+"),
        RegExp(r"[a-z]+"),
        RegExp(r"[A-Za-z]+"),
        RegExp(r"[A-Za-z0-9]+"),
        RegExp(
            r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{6,30}")
      ];

      String time = "";
      int x = 0;
      for (int j = patterns.length - 1; j >= 0; j--) {
        if (patterns[j].hasMatch(password)) {
          time = arr[j][len - 4];
          x = j;
          break;
        }
      }

      double score1 = 5;
      if (time.contains("million") || time.contains("millions")) {
        score1 = 5;
      } else if (time.contains("year") || time.contains("years")) {
        score1 = 4;
      } else if (time.contains("day") ||
          time.contains("days") ||
          time.contains("weeks") ||
          time.contains("week") ||
          time.contains("month") ||
          time.contains("months")) {
        score1 = 3;
      } else if (time.contains("min") ||
          time.contains("mins") ||
          time.contains("hours") ||
          time.contains("hour") ||
          time.contains("sec") ||
          time.contains("secs")) {
        score1 = 1;
      }

      double score = 0;

      if (password.contains(RegExp(r'[A-Z]'))) {
        score += 0.5;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        score += 0.5;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        score += 0.5;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        score += 1;
      }
      if (len >= 8) {
        score += 0.5;
      }
      if (len >= 12) {
        score += 0.5;
      }
      if (len >= 16) {
        score += 0.5;
      }
      if (len >= 20) {
        score += 1;
      }

      return {
        "Score": (score + score1) * 20,
        "time": time,
      };
    } catch (e) {
      Map<String, dynamic> responseBody = {
        "message": "Unknown error $e",
        "status": "error"
      };
      Map<String, dynamic> response = {
        "statusCode": 503,
        "body": jsonEncode(responseBody),
      };
      return {};
    }
  }
}
