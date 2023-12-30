import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';

class SubmitDriverDetailsController extends GetxController {
  var subData = SubmitDriverDetailsModule(
          dob: '',
          email: '',
          fname: '',
          gender: '',
          idNumber: '',
          idPicture: '',
          idType: '',
          insurance: '',
          licenceNumber: '',
          lname: '',
          mname: '',
          parkArea: '',
          passport: '',
          password: '',
          phone: '',
          relation: '',
          residence: '',
          tinNumber: '',
          vehicleNumber: '',
          verid: '')
      .obs;
  void updateContactInfo(
      {required String fname,
      required String mname,
      required String lname,
      required String phone,
      required email,
      required password}) {
    subData.update((val) {
      val!.fname = fname;
      val.mname = mname;
      val.lname = lname;
      val.phone = phone;
      val.email = email;
      val.password = password;
    });
  }

  void updateVeridInfo({required String verid}) {
    subData.update((val) {
      val!.verid = verid;
    });
  }

  void updatePersonalInfo({
    required String residence,
    required String relation,
    required String tinNumber,
    required String licenceNumber,
    required String parkArea,
    required String dob,
    required String gender,
  }) {
    subData.update((val) {
      val!.dob = dob;
      val.residence = residence;
      val.relation = relation;
      val.tinNumber = tinNumber;
      val.licenceNumber = licenceNumber;
      val.parkArea = parkArea;
      val.gender = gender;
    });
  }

  void updateVehicleInfo(
      {required String vehicleNumber, required String insurance}) {
    subData.update((val) {
      val!.insurance = insurance;
      val.vehicleNumber = vehicleNumber;
    });
  }

  void updateCardsDetailsInfo(
      {required String idType,
      required String idPicture,
      required String idNumber,
      required String passport}) {
    subData.update((val) {
      val!.idType = idType;
      val.idPicture = idPicture;
      val.idNumber = idNumber;
      val.passport = passport;
    });
  }
}

class PhoneInitVerificationCodeResponseController extends GetxController {
  var phoneVerRespo =
      VerificationResponseModule(data: '', otpId: '', state: '').obs;
  updateRespos(VerificationResponseModule resp) {
    phoneVerRespo.update((val) {
      val!.data = resp.data;
      val.otpId = resp.otpId;
      val.state = resp.state;
    });
  }
}
