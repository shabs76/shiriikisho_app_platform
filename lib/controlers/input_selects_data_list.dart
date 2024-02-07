import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';

class RegistrationInputListController extends GetxController {
  var regiList = RegistrationGetInfo(
          park: [],
          vehicles: [],
          districts: [],
          regions: [],
          wards: [],
          chamas: [],
          message: '')
      .obs;

  void updateRegInputList(RegistrationGetInfo inpList) {
    regiList.update((val) {
      val!.vehicles = inpList.vehicles;
      val.park = inpList.park;
      val.districts = inpList.districts;
      val.wards = inpList.wards;
      val.regions = inpList.regions;
      val.chamas = inpList.chamas;
      val.message = inpList.message;
    });
  }
}


/*
void changeState1(String status) {
    fakerInitState.update((val) {
      val!.state1 = status;
    });
  }
*/