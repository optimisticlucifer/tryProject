import 'dart:convert';

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
      "Score": score + score1,
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

void main() {
  print(jsonEncode(passwordStrength("Test@123")));
}
