import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class LeaderSectionHome extends StatefulWidget {
  const LeaderSectionHome({super.key});

  @override
  State<LeaderSectionHome> createState() => _LeaderSectionHomeState();
}

class _LeaderSectionHomeState extends State<LeaderSectionHome> {
  TinyComponents tinyComponents = TinyComponents();
  @override
  Widget build(BuildContext context) {
    final KishoStyles appStyles = KishoStyles();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Uratibu',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
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
              tinyComponents.buttonColumn(appStyles, context, () {
                Get.toNamed('/registration');
              }, 'Sajili', Symbols.person_add_alt_rounded),
              tinyComponents.buttonColumn(appStyles, context, () {
                Get.toNamed('/veri/list');
              }, 'Hakiki', Symbols.verified_rounded),
              tinyComponents.buttonColumn(appStyles, context, () {
                Get.toNamed('/driver/members');
              }, 'Wanachama', Symbols.groups_2_rounded)
            ],
          ),
        )
      ],
    );
  }
}
