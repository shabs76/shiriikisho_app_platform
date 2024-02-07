import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';

class CheckIfDriverIdIsSet extends GetMiddleware {
  final DriverIDOnUpdateInfoController _driverIDOnUpdateInfoController =
      Get.put(DriverIDOnUpdateInfoController());

  @override
  RouteSettings? redirect(String? route) {
    if (_driverIDOnUpdateInfoController.driverIdOnUpdate.value.driverId != '') {
      return null;
    } else {
      return const RouteSettings(name: '/sign');
    }
  }
}
