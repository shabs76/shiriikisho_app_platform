import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class SettingsMinProfile extends StatefulWidget {
  const SettingsMinProfile({super.key});

  @override
  State<SettingsMinProfile> createState() => _SettingsMinProfileState();
}

class _SettingsMinProfileState extends State<SettingsMinProfile> {
  final DriverDetailsController _driverDetailsController =
      Get.put(DriverDetailsController());
  final DriverIDOnUpdateInfoController _driverIDOnUpdateInfoController =
      Get.put(DriverIDOnUpdateInfoController());

  final PostMainApis _postMainApis = PostMainApis();
  final TinyComponents _tinyComponents = TinyComponents();
  bool _loadingState = false;

  Future<int> senLogoutRequest() async {
    setState(() {
      _loadingState = true;
    });
    StateDataModule anc = await _postMainApis.logoutDriver();
    setState(() {
      _loadingState = false;
    });
    if (anc.state != 'success') {
      _tinyComponents.popupWithInfo(
        heading: 'Makosa',
        nDescreption: anc.data,
        icon: Symbols.error,
        closeFun: () {
          Get.back();
        },
        okayFun: () {
          Get.back();
        },
        onColor: const Color.fromARGB(139, 252, 98, 98),
        iColor: const Color(0xFFFF3636),
      );
      return 0;
    }
    _tinyComponents.popupWithInfo(
      heading: 'Imefanikiwa',
      nDescreption: anc.data,
      icon: Symbols.close,
      closeFun: () {
        DriverPrefences.removeLoggedinDetails();
        Get.back();
        Get.offAllNamed('/sign');
      },
      okayFun: () {
        Get.back();
        DriverPrefences.removeLoggedinDetails();
        Get.back();
        Get.offAllNamed('/sign');
      },
    );
    return 1;
  }

  Widget _lodingBtn({required bool statx}) {
    if (statx) {
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

    return IconButton(
        onPressed: () {
          senLogoutRequest();
        },
        icon: Icon(
          Icons.power_settings_new_rounded,
          size: 30,
          color: Theme.of(context).colorScheme.onError,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const Border(
          top: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
          bottom: BorderSide(color: Colors.black26)),
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: ClipOval(
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  imageProcessorFromID(
                      _driverDetailsController.driverDet.value.passport),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(assest404Image, fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_driverDetailsController.driverDet.value.fname} ${_driverDetailsController.driverDet.value.lname}',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '+${_driverDetailsController.driverDet.value.phone}',
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xFF313131)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _lodingBtn(statx: _loadingState),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        _driverIDOnUpdateInfoController.changeDriverOnUpdate(
                            currentId: 'mine');
                        Get.toNamed('/driver/update');
                      },
                      icon: Icon(Symbols.ink_marker_rounded,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
