import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class PostMainApis {
  PostMainApis();
  final String coreUrl = 'https://users.shirikisho.co.tz';
  final Map<String, String> nHeaders = {
    'Content-Type': 'application/json',
  };
  Future<VerificationResponseModule> sendPhoneForverification(
      String phone) async {
    try {
      var data = jsonEncode({
        'phone': phone,
      });
      final verResp = await http.post(
          Uri.parse('$coreUrl/drivers/phone/verification'),
          headers: nHeaders,
          body: data);

      if (verResp.statusCode == 200) {
        Map<String, dynamic> phpResp = jsonDecode(verResp.body);
        if (phpResp.containsKey('state') && phpResp['state'] == 'success') {
          return VerificationResponseModule.fromJson(phpResp);
        } else if (phpResp.containsKey('state') &&
            phpResp['state'] != 'success' &&
            phpResp.containsKey('data')) {
          return VerificationResponseModule(
              data: phpResp['data'], otpId: '', state: 'error');
        } else {
          return VerificationResponseModule(
              data: 'Tatizo lisilojulikana limejitokeza',
              otpId: '',
              state: 'error');
        }
      } else {
        return VerificationResponseModule(
            data: 'Unable to connect to the server', otpId: '', state: 'error');
      }
    } catch (e) {
      return VerificationResponseModule(
          data: 'Major error has occurred on the app',
          otpId: '',
          state: 'error');
    }
  }

  Future<VerificationCodeResponseModule> sendVerificationCodeFun(
      String code, String otpId) async {
    try {
      var data = jsonEncode({'otp_id': otpId, 'code': int.parse(code)});
      final verResp = await http.post(
          Uri.parse('$coreUrl/drivers/phone/verification/code'),
          headers: nHeaders,
          body: data);
      if (verResp.statusCode == 200) {
        Map<String, dynamic> codAns = jsonDecode(verResp.body);
        if (codAns.containsKey('state') && codAns['state'] == 'success') {
          return VerificationCodeResponseModule.fromJson(codAns);
        } else if (codAns.containsKey('state') &&
            codAns['state'] != 'success' &&
            codAns.containsKey('data')) {
          return VerificationCodeResponseModule(
              data: codAns['data'], verid: '', state: 'error');
        } else {
          return VerificationCodeResponseModule(
              data: 'Tatitizo lisilojulikana limejitokeza',
              verid: '',
              state: 'error');
        }
      } else {
        return VerificationCodeResponseModule(
            data: 'Unable to connect to the server', verid: '', state: 'error');
      }
    } catch (e) {
      return VerificationCodeResponseModule(
          data: 'Major error has occurred on the app',
          verid: '',
          state: 'error');
    }
  }

  Future<ImageUploadResponseModule> uploadingImageFun(
      {required String logSess,
      required String logKey,
      required String keyType,
      required String purpose,
      required String imagePath}) async {
    try {
      // check file length if is more than 26Mb
      var fl = File(imagePath);
      if (fl.lengthSync() > 26000000) {
        return ImageUploadResponseModule(
            imageId: '',
            info:
                'Picha unayotaka kutuma nikubwa. Hakikisha picha inaukubwa wa Mb 24',
            state: 'error');
      }
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://media.shirikisho.co.tz/upload/images'))
        ..fields['purpose'] = purpose
        ..headers['logkey'] = logKey
        ..headers['logsess'] = logSess
        ..headers['keytype'] = keyType
        ..files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();
      if (response.statusCode == 200) {
        var rspBody = await response.stream.bytesToString();
        Map<String, dynamic> imgAns = jsonDecode(rspBody);
        if (imgAns.containsKey('state') &&
            imgAns['state'] == 'success' &&
            imgAns.containsKey('data') &&
            imgAns['data'] is Map) {
          return ImageUploadResponseModule(
              imageId: imgAns['data']['image_id'],
              info: imgAns['data']['info'],
              state: imgAns['state']);
        } else if (imgAns.containsKey('state') &&
            imgAns['state'] == 'success' &&
            (!imgAns.containsKey('data') || imgAns['data'] is! Map)) {
          return ImageUploadResponseModule(
              imageId: '',
              info:
                  'Major error on response sent by the server. If app update exist please update your application',
              state: 'error');
        } else if (imgAns.containsKey('state') &&
            imgAns['state'] != 'success' &&
            imgAns.containsKey('data') &&
            imgAns['data'] is String) {
          return ImageUploadResponseModule(
              imageId: '', info: imgAns['data'], state: 'error');
        } else if (imgAns.containsKey('state') &&
            imgAns['state'] != 'success') {
          return ImageUploadResponseModule(
              imageId: '',
              info:
                  'Tatizo lisilotazamiwa limejitokeza. Tafadhali jaribu tena baadae',
              state: 'error');
        }
        return ImageUploadResponseModule(
            imageId: '',
            info: 'Tatizo lisilotazamiwa limejitokeza.',
            state: 'error');
      } else {
        return ImageUploadResponseModule(
            imageId: '',
            info: 'Tatizo la kimtandao limejitokeza',
            state: 'error');
      }
    } catch (e) {
      return ImageUploadResponseModule(
          imageId: '',
          info: 'Major error has occurred while uploading image',
          state: 'error');
    }
  }

  Future<DriversRegresponseModule> sendDriverInfo() async {
    try {
      SubmitDriverDetailsController subDa =
          Get.put(SubmitDriverDetailsController());
      SubmitDriverDetailsModule drData = subDa.subData.value;
      Map<String, String> sendData = {
        "fname": drData.fname,
        "mname": drData.mname,
        "lname": drData.lname,
        "email": drData.email,
        "password": drData.password,
        "dob": drData.dob,
        "gender": drData.gender,
        "relation": drData.relation,
        "residence": drData.residence,
        "park_area": drData.parkArea,
        "vehicle_number": drData.vehicleNumber,
        "licence_number": drData.licenceNumber,
        "tin_number": drData.tinNumber,
        "id_type": drData.idType,
        "id_number": drData.idNumber,
        "id_picture": drData.idPicture,
        "passport": drData.passport,
        "verid": drData.verid,
        "insurance": drData.insurance,
        "kin_phone": drData.kinPhone,
        "kin_name": drData.kinName,
        "chama": drData.chama,
      };
      var resp = await http.post(Uri.parse('$coreUrl/drivers/registration'),
          headers: nHeaders, body: jsonEncode(sendData));
      if (resp.statusCode == 200) {
        Map<String, dynamic> rspBody = jsonDecode(resp.body);
        if (rspBody.containsKey('state') &&
            rspBody['state'] == 'success' &&
            rspBody.containsKey('data') &&
            rspBody['data'] is Map) {
          return DriversRegresponseModule(
              info: rspBody['data']['info'], state: rspBody['state']);
        } else if (rspBody.containsKey('state') &&
            rspBody['state'] == 'success' &&
            (!rspBody.containsKey('data') || rspBody['data'] is! Map)) {
          return DriversRegresponseModule(
              info:
                  'Major error on response sent by the server. If app update exist please update your application',
              state: 'error');
        } else if (rspBody.containsKey('state') &&
            rspBody['state'] != 'success' &&
            rspBody.containsKey('data') &&
            rspBody['data'] is String) {
          return DriversRegresponseModule(
              info: rspBody['data'], state: 'error');
        } else if (rspBody.containsKey('state') &&
            rspBody['state'] != 'success') {
          return DriversRegresponseModule(
              info:
                  'Tatizo lisilotazamiwa limejitokoeza. Tafadhali jaribu tena baadae.',
              state: 'error');
        }
        return DriversRegresponseModule(
            info: 'Tatizo limejitokoeza. Tafadhali jaribu tena baadae.',
            state: 'error');
      } else {
        return DriversRegresponseModule(
            info: 'Tatizo la kimtandao limejitokeza, tafadhali jaribu tena',
            state: 'error');
      }
    } catch (e) {
      return DriversRegresponseModule(
          info: 'Major program error has occurred while sending driver details',
          state: 'error');
    }
  }

  // LOGIN FUNCTIONS

  Future<VerificationResponseModule> loginInitPhone(
      {required String phone, required String password}) async {
    try {
      Map<String, String> sendData = {"phone": phone, "password": password};
      var resp = await http.post(Uri.parse('$coreUrl/auth/login/init'),
          headers: nHeaders, body: jsonEncode(sendData));
      if (resp.statusCode == 200) {
        Map<String, dynamic> rsData = jsonDecode(resp.body);
        if (rsData.containsKey('state') &&
            rsData['state'] == 'success' &&
            rsData.containsKey('data') &&
            rsData.containsKey('otp_id')) {
          return VerificationResponseModule.fromJson(rsData);
        } else if (rsData.containsKey('state') &&
            rsData['state'] != 'success' &&
            rsData.containsKey('data')) {
          return VerificationResponseModule(
              data: rsData['data'], otpId: '', state: 'error');
        } else {
          return VerificationResponseModule(
              data: 'Tatizo lisilotarajiwa limejitokeza. Tafadhali jaribu tena',
              otpId: '',
              state: 'error');
        }
      } else {
        return VerificationResponseModule(
            data: 'Tatitizo la kimtandao limejitokeza',
            otpId: '',
            state: 'error');
      }
    } catch (e) {
      return VerificationResponseModule(
          data:
              'Major program error has occurred while sending initial login information',
          otpId: '',
          state: 'error');
    }
  }

  Future<LoginFiDataModule> loginCodeverification(
      {required String code, required String otpId}) async {
    try {
      Map<String, dynamic> sendData = {
        "code": int.parse(code),
        "otp_id": otpId
      };
      var respx = await http.post(Uri.parse('$coreUrl/auth/login/code'),
          headers: nHeaders, body: jsonEncode(sendData));
      if (respx.statusCode == 200) {
        Map<String, dynamic> ansBdy = jsonDecode(respx.body);
        if (ansBdy.containsKey('state') &&
            ansBdy['state'] == 'success' &&
            ansBdy.containsKey('data') &&
            ansBdy['data'] is Map) {
          return LoginFiDataModule(
              logKey: ansBdy['data']['logKey'],
              info: ansBdy['data']['info'],
              logSess: ansBdy['data']['logSess'],
              state: ansBdy['state']);
        } else if (ansBdy.containsKey('state') &&
            ansBdy['state'] != 'success' &&
            ansBdy.containsKey('data') &&
            ansBdy['data'] is String) {
          return LoginFiDataModule(
              logKey: '', info: ansBdy['data'], logSess: '', state: 'error');
        }

        return LoginFiDataModule(
            logKey: '',
            info: 'Tatizo lisilotarajiwa limejitokeza. Tafadhali jaribu tena',
            logSess: '',
            state: 'error');
      } else {
        return LoginFiDataModule(
            logKey: '',
            info: 'Tatitizo la kimtandao limejitokeza',
            logSess: '',
            state: 'error');
      }
    } catch (e) {
      return LoginFiDataModule(
          logKey: '',
          info:
              'Major program error has occurred while sending verification code.',
          logSess: '',
          state: 'error');
    }
  }

  // VALIDATION DRIVER FUNCTIONS
  Future<StateDataModule> validateDriver({required String driverId}) async {
    try {
      Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
      if (!logData.containsKey(DriverPrefences.logKey) ||
          logData[DriverPrefences.logKey] == null ||
          !logData.containsKey(DriverPrefences.logSess) ||
          logData[DriverPrefences.logSess] == null) {
        DriverPrefences.removeLoggedinDetails();
        throw Exception('Missing login details. Please login first');
      }
      Map<String, String> lHeaders = {
        'Content-Type': 'application/json',
        'drlogkey': logData[DriverPrefences.logKey],
        'drlogsess': logData[DriverPrefences.logSess]
      };

      Map<String, dynamic> sendData = {"driver_id": driverId};
      var repsx = await http.post(Uri.parse('$coreUrl/drivers/validation'),
          headers: lHeaders, body: jsonEncode(sendData));

      if (repsx.statusCode == 200) {
        Map<String, dynamic> rbdoy = jsonDecode(repsx.body);
        if (rbdoy.containsKey('state') &&
            rbdoy['state'] == 'success' &&
            rbdoy.containsKey('data') &&
            rbdoy['data'] is String) {
          return StateDataModule(data: rbdoy['data'], state: rbdoy['state']);
        } else if (rbdoy.containsKey('state') &&
            rbdoy['state'] == 'success' &&
            (!rbdoy.containsKey('data') || rbdoy['data'] is! String)) {
          return StateDataModule(
              data:
                  'Tatizo kwenye taarifa zilizotumwa. Lakini zoezi limekamilika',
              state: rbdoy['state']);
        } else if (rbdoy.containsKey('state') &&
            rbdoy['state'] != 'success' &&
            rbdoy.containsKey('data') &&
            rbdoy['data'] is String) {
          return StateDataModule(data: rbdoy['data'], state: rbdoy['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilotegemewa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza. Tafadhali jaribu tena',
            state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data: 'Major program error has occurred while validating driver',
          state: 'error');
    }
  }

  // invalidating driver
  Future<StateDataModule> invalidateDriver({required String driverId}) async {
    try {
      Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
      if (!logData.containsKey(DriverPrefences.logKey) ||
          logData[DriverPrefences.logKey] == null ||
          !logData.containsKey(DriverPrefences.logSess) ||
          logData[DriverPrefences.logSess] == null) {
        DriverPrefences.removeLoggedinDetails();
        throw Exception('Missing login details. Please login first');
      }
      Map<String, String> lHeaders = {
        'Content-Type': 'application/json',
        'drlogkey': logData[DriverPrefences.logKey],
        'drlogsess': logData[DriverPrefences.logSess]
      };

      Map<String, dynamic> sendData = {"driver_id": driverId};
      var repsx = await http.post(Uri.parse('$coreUrl/drivers/invalidate'),
          headers: lHeaders, body: jsonEncode(sendData));

      if (repsx.statusCode == 200) {
        Map<String, dynamic> rbdoy = jsonDecode(repsx.body);
        if (rbdoy.containsKey('state') &&
            rbdoy['state'] == 'success' &&
            rbdoy.containsKey('data') &&
            rbdoy['data'] is String) {
          return StateDataModule(data: rbdoy['data'], state: rbdoy['state']);
        } else if (rbdoy.containsKey('state') &&
            rbdoy['state'] == 'success' &&
            (!rbdoy.containsKey('data') || rbdoy['data'] is! String)) {
          return StateDataModule(
              data:
                  'Tatizo kwenye taarifa zilizotumwa. Lakini zoezi limekamilika',
              state: rbdoy['state']);
        } else if (rbdoy.containsKey('state') &&
            rbdoy['state'] != 'success' &&
            rbdoy.containsKey('data') &&
            rbdoy['data'] is String) {
          return StateDataModule(data: rbdoy['data'], state: rbdoy['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilotegemewa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza. Tafadhali jaribu tena',
            state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data: 'Major program error has occurred while validating driver',
          state: 'error');
    }
  }

  // logout driver
  Future<StateDataModule> logoutDriver() async {
    try {
      Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
      if (!logData.containsKey(DriverPrefences.logKey) ||
          logData[DriverPrefences.logKey] == null ||
          !logData.containsKey(DriverPrefences.logSess) ||
          logData[DriverPrefences.logSess] == null) {
        DriverPrefences.removeLoggedinDetails();
        throw Exception('Missing login details. Please login first');
      }
      Map<String, String> lHeaders = {
        'Content-Type': 'application/json',
        'drlogkey': logData[DriverPrefences.logKey],
        'drlogsess': logData[DriverPrefences.logSess]
      };

      var respx = await http.post(Uri.parse('$coreUrl/auth/logout'),
          headers: lHeaders, body: jsonEncode({}));
      if (respx.statusCode == 200) {
        Map<String, dynamic> dbody = jsonDecode(respx.body);
        if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            (!dbody.containsKey('data') || dbody['data'] is! String)) {
          return StateDataModule(
              data: 'Umejitoa kwenye akaunti yako.', state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] != 'success' &&
            dbody.containsKey('adv') &&
            dbody['data'] is String) {
          DriverPrefences.removeLoggedinDetails();
          return StateDataModule(
              data:
                  'Unahitaji kuingia upya kwenye akaunti yako kufanya tendo hili',
              state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] != 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilo tarajiwa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza.', state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data: 'Major program error has occurred while loging out driver',
          state: 'error');
    }
  }

  // forget password initial
  Future<VerificationResponseModule> forgetPassInitProce(
      {required String phone}) async {
    try {
      var data = jsonEncode({
        'phone': phone,
      });
      var bb = await http.post(Uri.parse('$coreUrl/auth/forget/pass/init'),
          headers: nHeaders, body: data);
      if (bb.statusCode == 200) {
        Map<String, dynamic> bdody = jsonDecode(bb.body);
        if (bdody.containsKey('state') && bdody['state'] == 'success') {
          return VerificationResponseModule.fromJson(bdody);
        } else if (bdody.containsKey('state') &&
            bdody['state'] != 'success' &&
            bdody.containsKey('data')) {
          return VerificationResponseModule(
              data: bdody['data'], otpId: '', state: 'error');
        } else {
          return VerificationResponseModule(
              data: 'Tatizo lisilojulikana limejitokeza',
              otpId: '',
              state: 'error');
        }
      } else {
        return VerificationResponseModule(
            data: 'Unable to connect to the server', otpId: '', state: 'error');
      }
    } catch (e) {
      return VerificationResponseModule(
          data: 'Major error has occurred on the app #22',
          otpId: '',
          state: 'error');
    }
  }

  // forget password last
  Future<StateDataModule> forgetPassLastProcess(
      {required String code,
      required String password,
      required String otpId}) async {
    try {
      Map<String, dynamic> sendData = {
        'code': int.parse(code),
        'otp_id': otpId,
        'password': password
      };
      var snnd = await http.post(Uri.parse('$coreUrl/auth/forget/pass/last'),
          headers: nHeaders, body: jsonEncode(sendData));
      if (snnd.statusCode == 200) {
        Map<String, dynamic> dbody = jsonDecode(snnd.body);
        if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            (!dbody.containsKey('data') || dbody['data'] is! String)) {
          return StateDataModule(
              data: 'Umefanikiwa kubadili neno la siri', state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] != 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilo tarajiwa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza.', state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data: 'Major program error has occurred while changing password.',
          state: 'error');
    }
  }

  // resend code
  Future<StateDataModule> resendCodeProce({required String otpId}) async {
    try {
      var data = jsonEncode({
        'otp_id': otpId,
      });
      var ansx = await http.post(Uri.parse('$coreUrl/auth/code/resend'),
          headers: nHeaders, body: data);
      if (ansx.statusCode == 200) {
        Map<String, dynamic> dbody = jsonDecode(ansx.body);
        if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            (!dbody.containsKey('data') || dbody['data'] is! String)) {
          return StateDataModule(
              data: 'Umefanikiwa kutuma namba ya uthibitisho',
              state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] != 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilo tarajiwa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza.', state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data: 'Major program error has occurred while resending code.',
          state: 'error');
    }
  }

  /// fetch driver details for update
  Future<List<FullDriverDetailsModule>> fetchUpdateDriverDetails(
      driverId) async {
    try {
      Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
      if (!logData.containsKey(DriverPrefences.logKey) ||
          logData[DriverPrefences.logKey] == null ||
          !logData.containsKey(DriverPrefences.logSess) ||
          logData[DriverPrefences.logSess] == null) {
        DriverPrefences.removeLoggedinDetails();
        throw Exception('Missing login details. Please login first');
      }
      Map<String, String> lHeaders = {
        'Content-Type': 'application/json',
        'drlogkey': logData[DriverPrefences.logKey],
        'drlogsess': logData[DriverPrefences.logSess]
      };
      var data = jsonEncode({
        'driverId': driverId,
      });
      final resp = await http.post(
          Uri.parse('$coreUrl/auth/update/driver/major/init'),
          headers: lHeaders,
          body: data);
      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        if (body.containsKey('state') &&
            body['state'] == 'success' &&
            body.containsKey('data') &&
            body['data'] is List) {
          List<FullDriverDetailsModule> members = [];
          for (var i = 0; i < body['data'].length; i++) {
            FullDriverDetailsModule mbr =
                FullDriverDetailsModule.fromJson(body['data'][i]);
            members.add(mbr);
          }
          return members;
        } else if (body.containsKey('state') &&
            body['state'] == 'success' &&
            body.containsKey('data') &&
            body['data'] is! List) {
          List<FullDriverDetailsModule> drivers = [];
          return drivers;
        } else if (body.containsKey('state') &&
            body['state'] != 'success' &&
            body.containsKey('adv') &&
            body['adv'] == 'logout') {
          throw Exception('logout');
        } else if (body.containsKey('state') &&
            body['state'] != 'success' &&
            body.containsKey('data') &&
            body['data'] is String) {
          throw Exception(body['data']);
        }
        throw Exception(
            'Tatizo lisilotarajiwa limejitokeza. Tafadhali jaribu tena baadae');
      } else {
        throw Exception('Unable to connected to the server');
      }
    } catch (e) {
      throw Exception('Network error, #112');
    }
  }

  // send update details
  Future<StateDataModule> sendUpdateDetails(
      {required Map<String, dynamic> updDets}) async {
    try {
      Map<String, dynamic> logData = DriverPrefences.getLoggedinDetails();
      if (!logData.containsKey(DriverPrefences.logKey) ||
          logData[DriverPrefences.logKey] == null ||
          !logData.containsKey(DriverPrefences.logSess) ||
          logData[DriverPrefences.logSess] == null) {
        DriverPrefences.removeLoggedinDetails();
        throw Exception('Missing login details. Please login first');
      }
      Map<String, String> lHeaders = {
        'Content-Type': 'application/json',
        'drlogkey': logData[DriverPrefences.logKey],
        'drlogsess': logData[DriverPrefences.logSess]
      };
      final ansx = await http.post(
          Uri.parse('$coreUrl/auth/update/driver/major/last'),
          headers: lHeaders,
          body: jsonEncode(updDets));
      if (ansx.statusCode == 200) {
        Map<String, dynamic> dbody = jsonDecode(ansx.body);
        if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] == 'success' &&
            (!dbody.containsKey('data') || dbody['data'] is! String)) {
          return StateDataModule(
              data: 'Umefanikiwa kufanya usahihi wa taarifa zako',
              state: dbody['state']);
        } else if (dbody.containsKey('state') &&
            dbody['state'] != 'success' &&
            dbody.containsKey('data') &&
            dbody['data'] is String) {
          return StateDataModule(data: dbody['data'], state: dbody['state']);
        }
        return StateDataModule(
            data: 'Tatizo lisilo tarajiwa limejitokeza', state: 'error');
      } else {
        return StateDataModule(
            data: 'Tatizo la kimtandao limejitokeza.', state: 'error');
      }
    } catch (e) {
      return StateDataModule(
          data:
              'Major program error has occurred while sending update details.',
          state: 'error');
    }
  }
}
