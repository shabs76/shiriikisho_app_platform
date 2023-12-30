import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/account/subs/driver_short_details.dart';
import 'package:shirikisho_drivers/major_screens/account/top_account_header.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class AccountMain extends StatefulWidget {
  const AccountMain({super.key});

  @override
  State<AccountMain> createState() => _AccountMainState();
}

class _AccountMainState extends State<AccountMain> {
  final DriverDetailsController _driverDetailsController =
      Get.put(DriverDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: DelegateaccountTopSect(
                      profilePic: imageProcessorFromID(
                          _driverDetailsController.driverDet.value.passport),
                      userName:
                          '${_driverDetailsController.driverDet.value.fname} ${_driverDetailsController.driverDet.value.lname}')),
            ];
          },
          body: ListView(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 60),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              DriverDetailsShort(
                  driverNumber:
                      _driverDetailsController.driverDet.value.uniformNum,
                  fname:
                      '${_driverDetailsController.driverDet.value.fname} ${_driverDetailsController.driverDet.value.mname} ${_driverDetailsController.driverDet.value.lname}',
                  parkName: _driverDetailsController.driverDet.value.parkName,
                  rank: _driverDetailsController.driverDet.value.leadership,
                  residence:
                      _driverDetailsController.driverDet.value.residence),
              const SizedBox(
                height: 60,
              ),
              Text(
                'More Services, Coming Soon',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Image(image: AssetImage('assets/images/chat.png'))
            ],
          )),
    );
  }
}
