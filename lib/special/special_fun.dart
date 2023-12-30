import 'package:shirikisho_drivers/static_data/consts.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

List<String> extractThreeNames(String input) {
  List<String> names = input.split(' ');

  if (names.length == 3) {
    RegExp nameRegex = RegExp(r"^[a-zA-Z.'-]{3,}$");

    bool isValid = names.every((name) => nameRegex.hasMatch(name));
    if (isValid) {
      return names;
    }
  }

  return [];
}

bool hasThreeNames(String input) {
  List<String> names = input.split(' ');

  if (names.length != 3) {
    return false;
  }

  RegExp nameRegex = RegExp(r"^[a-zA-Z.'-]{3,}$");

  for (String name in names) {
    if (!nameRegex.hasMatch(name)) {
      return false;
    }
  }

  return true;
}

bool isValidPhoneNumber(String input) {
  if (input.length != 13) {
    return false;
  }

  return input.startsWith("+2556") || input.startsWith("+2557");
}

bool isValidEmail(String email) {
  if (email.isEmpty) {
    return false;
  }

  RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  if (password.length < 6) {
    return false;
  }

  RegExp letterRegex = RegExp(r'[a-zA-Z]');
  RegExp digitRegex = RegExp(r'[0-9]');

  bool hasLetter = letterRegex.hasMatch(password);
  bool hasDigit = digitRegex.hasMatch(password);

  return hasLetter && hasDigit;
}

bool hasOnlyNumbersAndLength(String input, int length) {
  RegExp numbersRegex = RegExp(r'^[0-9]+$');

  if (input.length != length) {
    return false;
  }

  return numbersRegex.hasMatch(input);
}

bool checkSelectedInputsFun(
    Map<String, String> selectVals, List<String> testKeys) {
  for (var i = 0; i < testKeys.length; i++) {
    if (!selectVals.containsKey(testKeys[i]) ||
        selectVals[testKeys[i]] == '' ||
        selectVals[testKeys[i]] == 'Chagua') {
      return false;
    }
  }
  return true;
}

bool validatePlateNumber(String plateNumber) {
  RegExp pattern1 = RegExp(r'^[A-Z]\s\d{3}\s[A-Z]{3}$'); // T 123 ABC pattern
  RegExp pattern2 = RegExp(r'^MC\s\d{3}\s[A-Z]{3}$'); // MC 123 ABC pattern

  if (pattern1.hasMatch(plateNumber) || pattern2.hasMatch(plateNumber)) {
    return true;
  } else {
    return false;
  }
}

// image id urlProcessor
String imageProcessorFromID(String imageD) {
  Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
  String logKey = logData[DriverPrefences.logKey];
  String logSess = logData[DriverPrefences.logSess];
  String urlx = '$mediaUrlCore/get/image/$imageD/$logKey/$logSess/drivers';
  return urlx;
}
