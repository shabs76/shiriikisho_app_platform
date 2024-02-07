import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/major_screens/verifying/subs/driver_personal_info.dart';
import 'package:shirikisho_drivers/major_screens/verifying/subs/residence_info.dart';
import 'package:shirikisho_drivers/major_screens/verifying/subs/vehicle_info_review.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';

class VerifyDriverDetails extends StatefulWidget {
  const VerifyDriverDetails({super.key});

  @override
  State<VerifyDriverDetails> createState() => _VerifyDriverDetailsState();
}

class _VerifyDriverDetailsState extends State<VerifyDriverDetails> {
  final DriverIdOnReviewController _driverIdOnReviewController =
      Get.put(DriverIdOnReviewController());
  final FullDriverDetailsController _fullDriverDetailsController =
      Get.put(FullDriverDetailsController());
  KishoStyles appStyles = KishoStyles();
  final TinyComponents tinyComponents = TinyComponents();
  late FullDriverDetailsModule undriver;

  final PostMainApis _postMainApis = PostMainApis();

  bool _loadingState = false;

  @override
  void initState() {
    super.initState();
    checkForDriverInList();
  }

  int checkForDriverInList() {
    if (_fullDriverDetailsController.fdriverDet.isEmpty) {
      undriver = FullDriverDetailsModule(
          chama: '',
          dob: '',
          driverId: '',
          email: '',
          fname: '',
          gender: '',
          idNumber: '',
          idPicture: '',
          idType: '',
          insurance: '',
          kinName: '',
          kinPhone: '',
          licenceNumber: '',
          lname: '',
          mname: '',
          parkArea: '',
          passport: '',
          phone: '',
          relationship: '',
          residence: '',
          status: 'empty',
          vehicleNumber: '');
      return 0;
    }
    for (var i = 0; i < _fullDriverDetailsController.fdriverDet.length; i++) {
      // search for driver
      if (_fullDriverDetailsController.fdriverDet[i].driverId ==
          _driverIdOnReviewController.driverIdOnReview.value.driverId) {
        final FullDriverDetailsModule drv =
            _fullDriverDetailsController.fdriverDet[i];
        undriver = FullDriverDetailsModule(
            chama: drv.chama,
            dob: drv.dob,
            driverId: drv.driverId,
            email: drv.email,
            fname: drv.fname,
            gender: drv.gender,
            idNumber: drv.idNumber,
            idPicture: drv.idPicture,
            idType: drv.idType,
            insurance: drv.insurance,
            kinName: drv.kinName,
            kinPhone: drv.kinPhone,
            licenceNumber: drv.licenceNumber,
            lname: drv.lname,
            mname: drv.mname,
            parkArea: drv.parkArea,
            passport: drv.passport,
            phone: drv.phone,
            relationship: drv.relationship,
            residence: drv.residence,
            status: drv.status,
            vehicleNumber: drv.vehicleNumber);
        return 0;
      }
    }
    undriver = FullDriverDetailsModule(
        chama: '',
        dob: '',
        driverId: '',
        email: '',
        fname: '',
        gender: '',
        idNumber: '',
        idPicture: '',
        idType: '',
        insurance: '',
        kinName: '',
        kinPhone: '',
        licenceNumber: '',
        lname: '',
        mname: '',
        parkArea: '',
        passport: '',
        phone: '',
        relationship: '',
        residence: '',
        status: 'empty',
        vehicleNumber: '');
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: const Color.fromARGB(100, 0, 0, 0),
        title: const Text('Taarifa za Dereva',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
      body: driverDetailNfound(),
      bottomNavigationBar: Container(
        height: 18,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }

  Widget statusActionShow({required String statx}) {
    if (statx == 'active') {
      return const SizedBox();
    } else if (statx == 'blocked') {
      return ElevatedButton(
          onPressed: () {
            sendValidationFun(driverId: undriver.driverId);
          },
          style: appStyles.defaultButtonStyles().copyWith(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.maxFinite, 45)),
              ),
          child: const Text('Hakikisha'));
    }
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              sendInValidationFun(driverId: undriver.driverId);
            },
            style: appStyles.defaultBorderedButtonStyles().copyWith(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 45))),
            child: const Text('Kataa')),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              sendValidationFun(driverId: undriver.driverId);
            },
            style: appStyles.defaultButtonStyles().copyWith(
                  minimumSize: const MaterialStatePropertyAll(
                      Size(double.maxFinite, 45)),
                ),
            child: const Text('Hakikisha')),
      ],
    );
  }

  Widget loadingNButtons({required bool loading, required String astatus}) {
    if (loading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      );
    }
    return statusActionShow(statx: astatus);
  }

  Future<int> sendValidationFun({required String driverId}) async {
    if (driverId.length < 6) {
      tinyComponents.popupWithInfo(
        heading: "Tatizo",
        nDescreption: 'Namba ya utambulisho wa dereva sio sahihi',
        icon: Symbols.close_rounded,
        closeFun: () {
          Get.back();
        },
        okayFun: () => Get.back(),
        iColor: const Color(0xFFFF3636),
        onColor: const Color.fromARGB(142, 238, 70, 70),
      );
      return 0;
    }
    setState(() {
      _loadingState = true;
    });
    StateDataModule ans =
        await _postMainApis.validateDriver(driverId: driverId);
    if (ans.state == 'error') {
      setState(() {
        _loadingState = false;
      });
      tinyComponents.popupWithInfo(
          heading: "Tatizo",
          nDescreption: ans.data,
          icon: Symbols.close_rounded,
          closeFun: () {
            Get.back();
          },
          okayFun: () => Get.back(),
          iColor: const Color(0xFFFF3636),
          onColor: const Color.fromARGB(142, 238, 70, 70));
      return 0;
    }
    tinyComponents.popupWithInfo(
        heading: 'Imefanikiwa',
        nDescreption: ans.data,
        icon: Symbols.done_all_rounded,
        closeFun: () {
          Get.back();
          Get.offAndToNamed('/veri/list');
        },
        okayFun: () {
          Get.back();
          Get.offAndToNamed('/veri/list');
        });
    return 1;
  }

  Future<int> sendInValidationFun({required String driverId}) async {
    if (driverId.length < 6) {
      tinyComponents.popupWithInfo(
        heading: "Tatizo",
        nDescreption: 'Namba ya utambulisho wa dereva sio sahihi',
        icon: Symbols.close_rounded,
        closeFun: () {
          Get.back();
        },
        okayFun: () => Get.back(),
      );
      return 0;
    }
    setState(() {
      _loadingState = true;
    });
    StateDataModule ans =
        await _postMainApis.invalidateDriver(driverId: driverId);
    if (ans.state == 'error') {
      setState(() {
        _loadingState = false;
      });
      tinyComponents.popupWithInfo(
        heading: "Tatizo",
        nDescreption: ans.data,
        icon: Symbols.close_rounded,
        closeFun: () {
          Get.back();
        },
        okayFun: () => Get.back(),
      );
      return 0;
    }
    tinyComponents.popupWithInfo(
        heading: 'Imefanikiwa',
        nDescreption: ans.data,
        icon: Symbols.done_all_rounded,
        closeFun: () {
          Get.back();
          Get.toNamed('/veri/list');
        },
        okayFun: () {
          Get.back();
          Get.toNamed('/veri/list');
        });
    return 1;
  }

  Widget driverDetailNfound() {
    if (undriver.status == 'empty') {
      return tinyComponents.notFoundWidget(
          context, 'Mfumo umeshindwa kupata taarifa za dereva', 'Sawa', () {
        Get.offNamed('/mobile');
      });
    }
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      children: [
        DriverPersonalDetailsReview(
            driverName: '${undriver.fname} ${undriver.mname} ${undriver.lname}',
            driverProfile: imageProcessorFromID(undriver.passport),
            gender: undriver.gender,
            rank: 'Mwanachama',
            relation: undriver.relationship),
        const SizedBox(
          height: 30,
        ),
        DriverResidenceInfoReview(
          residenceInfo: undriver.residence,
          kinName: undriver.kinName,
          chama: undriver.chama,
        ),
        const SizedBox(
          height: 20,
        ),
        Image.network(
          imageProcessorFromID(undriver.idPicture),
          width: MediaQuery.of(context).size.width * 0.9,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(assest404Image, fit: BoxFit.contain);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        VehicleInfoDriverReview(
            bimaCode: undriver.insurance == 'no' ? 'Sina' : 'Ninayo',
            lNumber: undriver.licenceNumber,
            vNumber: undriver.vehicleNumber,
            vType: 'Kama kituo'),
        const SizedBox(
          height: 30,
        ),
        loadingNButtons(loading: _loadingState, astatus: undriver.status),
      ],
    );
  }
}
