import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/home/subs/leader_home.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
// import 'package:shirikisho_drivers/micro/styles.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final DriverDetailsController _driverDetailsController =
      Get.put(DriverDetailsController());
  final KishoStyles appStyles = KishoStyles();
  Widget leaderBoard(leaderState) {
    if (leaderState == 'yes') {
      return const Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LeaderSectionHome(),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/driver/members');
              },
              style: appStyles.defaultButtonStyles(),
              child: const Text('Ona Wanachama'))
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // KishoStyles appStyles = KishoStyles();
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
          child: Text(
            'Karibu ${_driverDetailsController.driverDet.value.fname}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Center(
          child: SizedBox(
            child: Image(
              image: const AssetImage('assets/images/intro.png'),
              width: MediaQuery.of(context).size.width * 0.95,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Coming Soon!...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Huduma za jamii ya shirikisho, zitakujia hivi karibuni. Kuwa tayari kufanya miamala, kukopa, kupata bima ya afya na chombo chako, mtandao wa kijamii kwaajili yenu, na megineyo mengi. Yajayo yanasisimua.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        leaderBoard(_driverDetailsController.driverDet.value.leaderState),
        const SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
