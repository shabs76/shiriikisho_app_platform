import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/input_selects_data_list.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';

class PersonMiddleware extends GetMiddleware {
  final SubmitDriverDetailsController subData =
      Get.put(SubmitDriverDetailsController());
  final RegistrationInputListController inputsList =
      Get.put(RegistrationInputListController());
  @override
  RouteSettings? redirect(String? route) {
    return subData.subData.value.verid != '' &&
            inputsList.regiList.value.park.isNotEmpty
        ? null
        : const RouteSettings(name: '/registration');
  }
}

class VehicleMiddleware extends GetMiddleware {
  final SubmitDriverDetailsController subData =
      Get.put(SubmitDriverDetailsController());
  final RegistrationInputListController inputsList =
      Get.put(RegistrationInputListController());
  @override
  RouteSettings? redirect(String? route) {
    if (subData.subData.value.gender != '' &&
        inputsList.regiList.value.vehicles.isNotEmpty) {
      return null;
    } else if (inputsList.regiList.value.vehicles.isEmpty) {
      const RouteSettings(name: '/reg/personal');
    }
    return const RouteSettings(name: '/registration');
  }
}

class CodePageMiddleware extends GetMiddleware {
  PhoneInitVerificationCodeResponseController phoneInitVerification =
      Get.put(PhoneInitVerificationCodeResponseController());
  @override
  RouteSettings? redirect(String? route) {
    if (phoneInitVerification.phoneVerRespo.value.state == 'success') {
      return null;
    } else {
      return const RouteSettings(name: '/registration');
    }
  }
}

class CardPageMiddleware extends GetMiddleware {
  final SubmitDriverDetailsController subData =
      Get.put(SubmitDriverDetailsController());
  @override
  RouteSettings? redirect(String? route) {
    if (subData.subData.value.vehicleNumber != '') {
      return null;
    } else {
      return const RouteSettings(name: '/reg/vehicle');
    }
  }
}
