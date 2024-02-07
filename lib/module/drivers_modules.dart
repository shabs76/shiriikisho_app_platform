class UnverifiedGridDrivers {
  String fname;
  String type;
  String profile;
  String driverid;
  UnverifiedGridDrivers(
      {required this.driverid,
      required this.fname,
      required this.profile,
      required this.type});
}

class OnReviewDriverId {
  String driverId;
  OnReviewDriverId({required this.driverId});
}

class OnUpdateDriverId {
  String driverId;
  OnUpdateDriverId({required this.driverId});
}

class LoginFiDataModule {
  String state;
  String info;
  String logSess;
  String logKey;

  LoginFiDataModule(
      {required this.logKey,
      required this.info,
      required this.logSess,
      required this.state});
}

class DriverDetailsModule {
  String fname;
  String mname;
  String lname;
  String email;
  String phone;
  String residence;
  String parkArea;
  String licenceNumber;
  String passport;
  String leadership;
  String parkName;
  String uniformNum;
  String leaderState;

  DriverDetailsModule({
    required this.email,
    required this.fname,
    required this.leadership,
    required this.leaderState,
    required this.licenceNumber,
    required this.lname,
    required this.mname,
    required this.parkArea,
    required this.parkName,
    required this.passport,
    required this.phone,
    required this.residence,
    required this.uniformNum,
  });

  factory DriverDetailsModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'fname': String fname,
        'mname': String mname,
        'lname': String lname,
        'email': String email,
        'phone': String phone,
        'residence': String residence,
        'park_area': String parkArea,
        'licence_number': String licenceNumber,
        'passport': String passport,
        'parkName': String parkName,
        'leadership': String leadership,
        'leaderState': String leaderState,
        'uniform': String uniformNum
      } =>
        DriverDetailsModule(
          email: email,
          fname: fname,
          leadership: leadership,
          leaderState: leaderState,
          licenceNumber: licenceNumber,
          lname: lname,
          mname: mname,
          parkArea: parkArea,
          parkName: parkName,
          passport: passport,
          phone: phone,
          residence: residence,
          uniformNum: uniformNum,
        ),
      _ => throw const FormatException('Unable to onload responses')
    };
  }
}

class FullDriverDetailsModule {
  String driverId;
  String fname;
  String mname;
  String lname;
  String email;
  String phone;
  String dob;
  String gender;
  String relationship;
  String residence;
  String parkArea;
  String vehicleNumber;
  String licenceNumber;
  String idType;
  String idNumber;
  String idPicture;
  String passport;
  String insurance;
  String chama;
  String kinName;
  String kinPhone;
  String status;
  FullDriverDetailsModule(
      {required this.chama,
      required this.dob,
      required this.driverId,
      required this.email,
      required this.fname,
      required this.gender,
      required this.idNumber,
      required this.idPicture,
      required this.idType,
      required this.insurance,
      required this.kinName,
      required this.kinPhone,
      required this.licenceNumber,
      required this.lname,
      required this.mname,
      required this.parkArea,
      required this.passport,
      required this.phone,
      required this.relationship,
      required this.residence,
      required this.status,
      required this.vehicleNumber});
  factory FullDriverDetailsModule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'driver_id': String driverId,
        'fname': String fname,
        'mname': String mname,
        'lname': String lname,
        'email': String email,
        'phone': String phone,
        'dob': String dob,
        'gender': String gender,
        'relationship': String relationship,
        'residence': String residence,
        'park_area': String parkArea,
        'vehicle_number': String vehicleNumber,
        'licence_number': String licenceNumber,
        'id_type': String idType,
        'id_number': String idNumber,
        'id_picture': String idPicture,
        'passport': String passport,
        'insurance': String insurance,
        'status': String status,
        'chama': String chama,
        'kin_name': String kinName,
        'kin_phone': String kinPhone,
      } =>
        FullDriverDetailsModule(
            chama: chama,
            dob: dob,
            driverId: driverId,
            email: email,
            fname: fname,
            gender: gender,
            idNumber: idNumber,
            idPicture: idPicture,
            idType: idType,
            insurance: insurance,
            kinName: kinName,
            kinPhone: kinPhone,
            licenceNumber: licenceNumber,
            lname: lname,
            mname: mname,
            parkArea: parkArea,
            passport: passport,
            phone: phone,
            relationship: relationship,
            residence: residence,
            status: status,
            vehicleNumber: vehicleNumber),
      _ =>
        throw const FormatException('Unable to unload driver details resposes.')
    };
  }
}
