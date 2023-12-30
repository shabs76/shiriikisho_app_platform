class VehiclesTypesModule {
  final String vehicleId;
  final String vTypeName;
  final int vCapacity;

  VehiclesTypesModule(
      {required this.vCapacity,
      required this.vTypeName,
      required this.vehicleId});

  factory VehiclesTypesModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'v_type_id': String vTypeId,
        'v_type_name': String vTypeName,
        'people_capacity': int peopleCapacity,
      } =>
        VehiclesTypesModule(
            vCapacity: peopleCapacity,
            vTypeName: vTypeName,
            vehicleId: vTypeId),
      _ => throw const FormatException('Failed to load vehiles types'),
    };
  }
}

class ParkAreaModule {
  final String parkId;
  final String parkName;
  final int parkSize;
  ParkAreaModule(
      {required this.parkId, required this.parkName, required this.parkSize});

  factory ParkAreaModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'park_id': String parkId,
        'park_name': String parkName,
        'park_size': int parkSize,
      } =>
        ParkAreaModule(parkId: parkId, parkName: parkName, parkSize: parkSize),
      _ => throw const FormatException('Failed to unload parking areas'),
    };
  }
}

class RegistrationGetInfo {
  List<VehiclesTypesModule> vehicles;
  List<ParkAreaModule> park;
  String message;
  RegistrationGetInfo(
      {this.message = '', required this.park, required this.vehicles});
}

class SubmitDriverDetailsModule {
  String fname;
  String mname;
  String lname;
  String email;
  String password;
  String phone;
  String dob;
  String gender;
  String relation;
  String residence;
  String parkArea;
  String vehicleNumber;
  String licenceNumber;
  String tinNumber;
  String idType;
  String idNumber;
  String idPicture;
  String insurance;
  String passport;
  String verid;
  SubmitDriverDetailsModule(
      {required this.dob,
      required this.email,
      required this.fname,
      required this.gender,
      required this.idNumber,
      required this.idPicture,
      required this.idType,
      required this.insurance,
      required this.licenceNumber,
      required this.lname,
      required this.mname,
      required this.parkArea,
      required this.passport,
      required this.password,
      required this.phone,
      required this.relation,
      required this.residence,
      required this.tinNumber,
      required this.vehicleNumber,
      required this.verid});
}

// verification phone number initial response

class VerificationResponseModule {
  String state;
  String data;
  String otpId;

  VerificationResponseModule(
      {required this.data, required this.otpId, required this.state});

  factory VerificationResponseModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'state': String state,
        'data': String data,
        'otp_id': String otpId,
      } =>
        VerificationResponseModule(data: data, otpId: otpId, state: state),
      _ => VerificationResponseModule(
          data: 'Unable to unload response data', otpId: '', state: 'error')
    };
  }
}

// verification response codeid Module

class VerificationCodeResponseModule {
  String state;
  String data;
  String verid;

  VerificationCodeResponseModule(
      {required this.data, required this.verid, required this.state});

  factory VerificationCodeResponseModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'state': String state,
        'data': String data,
        'verid': String otpId,
      } =>
        VerificationCodeResponseModule(data: data, verid: otpId, state: state),
      _ => VerificationCodeResponseModule(
          data: 'Unable to unload response data', verid: '', state: 'error')
    };
  }
}

// image upload response module

class ImageUploadResponseModule {
  String state;
  String info;
  String imageId;

  ImageUploadResponseModule({
    required this.imageId,
    required this.info,
    required this.state,
  });
}

// driver registration
class DriversRegresponseModule {
  String state;
  String info;
  DriversRegresponseModule({
    required this.info,
    required this.state,
  });
}
