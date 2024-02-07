import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';

class DriverIdOnReviewController extends GetxController {
  var driverIdOnReview = OnReviewDriverId(driverId: '').obs;

  void changeDriverOnReview({required String currentIdReview}) {
    driverIdOnReview.update((val) {
      val!.driverId = currentIdReview;
    });
  }
}

class DriverIDOnUpdateInfoController extends GetxController {
  var driverIdOnUpdate = OnUpdateDriverId(driverId: '').obs;

  void changeDriverOnUpdate({required String currentId}) {
    driverIdOnUpdate.update((val) {
      val!.driverId = currentId;
    });
  }
}

class DriverDetailsController extends GetxController {
  var driverDet = DriverDetailsModule(
          email: '',
          fname: '',
          leadership: '',
          leaderState: '',
          licenceNumber: '',
          lname: '',
          mname: '',
          parkArea: '',
          parkName: '',
          passport: '',
          phone: '',
          residence: '',
          uniformNum: '')
      .obs;
  void updateDriverDetails({required DriverDetailsModule driver}) {
    driverDet.update((val) {
      val!.email = driver.email;
      val.fname = driver.fname;
      val.leadership = driver.leadership;
      val.leaderState = driver.leaderState;
      val.licenceNumber = driver.licenceNumber;
      val.lname = driver.lname;
      val.mname = driver.mname;
      val.parkArea = driver.parkArea;
      val.parkName = driver.parkName;
      val.passport = driver.passport;
      val.phone = driver.phone;
      val.residence = driver.residence;
      val.uniformNum = driver.uniformNum;
    });
  }
}

class FullDriverDetailsController extends GetxController {
  var fdriverDet = <FullDriverDetailsModule>[].obs;

  void updateList({required List<FullDriverDetailsModule> liv}) {
    fdriverDet.value = liv;
    fdriverDet.refresh();
  }
}

class FullDriverMembersController extends GetxController {
  var mfDriverDet = <FullDriverDetailsModule>[].obs;
  void updateList({required List<FullDriverDetailsModule> mbr}) {
    mfDriverDet.value = mbr;
    mfDriverDet.refresh();
  }
}
