import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class LoginCodePageMiddleware extends GetMiddleware {
  final PhoneInitVerificationCodeResponseController _phoneInitVerification =
      Get.put(PhoneInitVerificationCodeResponseController());
  @override
  RouteSettings? redirect(String? route) {
    if (_phoneInitVerification.phoneVerRespo.value.state == 'success') {
      return null;
    } else {
      return const RouteSettings(name: '/');
    }
  }
}

// middleware to not allow going to login screen if logged in.
class LogggedHOMEInUserMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    Map<String, dynamic> inf = DriverPrefences.getLoggedinDetails();
    if (inf.containsKey(DriverPrefences.logKey) &&
        inf[DriverPrefences.logKey] != null &&
        inf.containsKey(DriverPrefences.logSess) &&
        inf[DriverPrefences.logSess] != null) {
      return const RouteSettings(name: '/mobile');
    } else {
      return null;
    }
  }
}

// middlewares for users who have logged in only

class LogggedInUserMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    Map<String, dynamic> inf = DriverPrefences.getLoggedinDetails();
    if (inf.containsKey(DriverPrefences.logKey) &&
        inf[DriverPrefences.logKey] != null &&
        inf.containsKey(DriverPrefences.logSess) &&
        inf[DriverPrefences.logSess] != null) {
      return null;
    } else {
      return const RouteSettings(name: '/');
    }
  }
}
