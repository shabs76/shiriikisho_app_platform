import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/home/subs/frequent_services.dart';
import 'package:shirikisho_drivers/major_screens/home/subs/leader_home.dart';
import 'package:shirikisho_drivers/major_screens/home/subs/mikopo_banner.dart';
import 'package:shirikisho_drivers/major_screens/home/subs/mkopo_summary.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
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
  final TinyComponents _tinyComponents = TinyComponents();
  Widget leaderBoard(leaderState) {
    if (leaderState == 'yes') {
      return const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: LeaderSectionHome(),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
                width: double.maxFinite,
                child: Text(
                  'Uratibu',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                )),
            const SizedBox(
              height: 7,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0x1A505F79), width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tinyComponents.buttonColumn(appStyles, context, () {
                    Get.toNamed('/driver/members');
                  }, 'Wanachama', Symbols.groups_2_rounded)
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // KishoStyles appStyles = KishoStyles();
    return SafeArea(
      child: Scaffold(
          body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
            child: Text(
              'Habari ${_driverDetailsController.driverDet.value.fname}, ',
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
          ),
          const Padding(
            padding: EdgeInsets.zero,
            child: MikopoSectionHome(),
          ),
          leaderBoard(_driverDetailsController.driverDet.value.leaderState),
          const SizedBox(
            height: 20,
          ),
          const MikopoBannerHome(),
          const SizedBox(
            height: 30,
          ),
          const FrequentServices(),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  shadowColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSecondary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0x3327AE60)),
                          child: const Icon(
                            Symbols.receipt_long_rounded,
                            color: Color(0xFF24B42E),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Taarifa za miamala',
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF505F79)),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Symbols.arrow_forward_ios_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      )),
    );
  }
}
