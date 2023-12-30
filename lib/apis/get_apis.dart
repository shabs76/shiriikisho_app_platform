import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shirikisho_drivers/module/drivers_modules.dart';

import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class GetApisClass {
  GetApisClass();
  final String coreUrl = 'https://users.shirikisho.co.tz';
  Future<RegistrationGetInfo> fetchRegistListInfo() async {
    final regResponse =
        await http.get(Uri.parse('$coreUrl/get/reqistration/info'));
    if (regResponse.statusCode == 200) {
      final Map<String, dynamic> hdg = jsonDecode(regResponse.body);
      if (hdg.containsKey('state') && hdg['state'] == 'success') {
        final dataReg = hdg['data'];
        if (dataReg['vehilces'] is List && dataReg['parks'] is List) {
          List<VehiclesTypesModule> vehi = [];
          // add vehicle list
          for (var i = 0; i < dataReg['vehilces'].length; i++) {
            VehiclesTypesModule veh =
                VehiclesTypesModule.fromJson(dataReg['vehilces'][i]);
            vehi.add(veh);
          }
          List<ParkAreaModule> parki = [];
          // now add park areas
          for (var l = 0; l < dataReg['parks'].length; l++) {
            ParkAreaModule prk = ParkAreaModule.fromJson(dataReg['parks'][l]);
            parki.add(prk);
          }
          final sLv =
              RegistrationGetInfo(park: parki, vehicles: vehi, message: '');
          return sLv;
        } else {
          final eTesh = RegistrationGetInfo(
              park: [], vehicles: [], message: 'Unable to format data correct');
          return eTesh;
        }
      } else {
        final eTesh = RegistrationGetInfo(
            park: [], vehicles: [], message: hdg['data'].toString());
        return eTesh;
      }
    } else {
      throw Exception('Unable to connect to the server');
    }
  }

  Future<DriverDetailsModule> fetchDriverDetails() async {
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
      final resp = await http.get(Uri.parse('$coreUrl/get/driver/details'),
          headers: lHeaders);
      if (resp.statusCode == 200) {
        Map<String, dynamic> rsBdy = jsonDecode(resp.body);
        if (rsBdy.containsKey('state') &&
            rsBdy['state'] == 'success' &&
            rsBdy.containsKey('data')) {
          return DriverDetailsModule.fromJson(rsBdy['data']);
        } else if (rsBdy.containsKey('state') &&
            rsBdy['state'] != 'success' &&
            rsBdy.containsKey('adv') &&
            rsBdy['adv'] == 'logout') {
          DriverPrefences.removeLoggedinDetails();
          throw Exception(rsBdy['adv']);
        } else if (rsBdy.containsKey('state') &&
            rsBdy['state'] != 'success' &&
            rsBdy.containsKey('data') &&
            rsBdy['data'] is String) {
          throw Exception(rsBdy['data']);
        }
        throw Exception(
            'Tatitizo lisilotarajiwa limejitokeza. Tafadhali ingia tena upya');
      } else {
        throw Exception('Unable to connected to the server');
      }
    } catch (e) {
      throw Exception('Application error. #77');
    }
  }

  Future<List<FullDriverDetailsModule>> fetchUnverifiedDrivers() async {
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
      final resp = await http.get(Uri.parse('$coreUrl/get/unverified/drivers'),
          headers: lHeaders);
      if (resp.statusCode == 200) {
        Map<String, dynamic> rBdy = jsonDecode(resp.body);
        if (rBdy.containsKey('state') &&
            rBdy['state'] == 'success' &&
            rBdy.containsKey('data') &&
            rBdy['data'] is List) {
          List<FullDriverDetailsModule> drivers = [];
          for (var i = 0; i < rBdy['data'].length; i++) {
            FullDriverDetailsModule dr =
                FullDriverDetailsModule.fromJson(rBdy['data'][i]);
            drivers.add(dr);
          }
          return drivers;
        } else if (rBdy.containsKey('state') &&
            rBdy['state'] == 'success' &&
            rBdy.containsKey('data') &&
            rBdy['data'] is! List) {
          List<FullDriverDetailsModule> drivers = [];
          return drivers;
        } else if (rBdy.containsKey('state') &&
            rBdy['state'] != 'success' &&
            rBdy.containsKey('adv') &&
            rBdy['adv'] == 'logout') {
          throw Exception('logout');
        } else if (rBdy.containsKey('state') &&
            rBdy['state'] != 'success' &&
            rBdy.containsKey('data') &&
            rBdy['data'] is String) {
          throw Exception(rBdy['data']);
        }
        throw Exception(
            'Tatizo lisilotarajiwa limejitokeza. Tafadhali jaribu tena baadae');
      } else {
        throw Exception('Unable to connected to the server');
      }
    } catch (e) {
      throw Exception('Application error. #99');
    }
  }

  Future<List<FullDriverDetailsModule>> fetchDriverMembers() async {
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
      final resp = await http.get(Uri.parse('$coreUrl/get/other/drivers'),
          headers: lHeaders);
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
      throw Exception('Application error, #111');
    }
  }
}
