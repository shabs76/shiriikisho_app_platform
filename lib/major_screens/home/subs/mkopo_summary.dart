import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class MikopoSectionHome extends StatefulWidget {
  const MikopoSectionHome({super.key});

  @override
  State<MikopoSectionHome> createState() => _MikopoSectionHomeState();
}

class _MikopoSectionHomeState extends State<MikopoSectionHome> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      surfaceTintColor: const Color(0x1A27AE60),
      color: const Color(0x1A27AE60),
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // #
            mikopoSect(
                mIcon: Symbols.credit_card_rounded,
                cColor: const Color(0xFFCEECF8),
                miColor: const Color(0xFF09A0DD),
                secName: 'Mikopo',
                secValue: '0 TZS'),
            Container(
              width: 2,
              height: 40,
              color: const Color.fromARGB(196, 183, 200, 228),
            ),
            mikopoSect(
                mIcon: Symbols.payments_rounded,
                cColor: const Color.fromARGB(233, 173, 241, 201),
                miColor: const Color(0xFF24B42E),
                secName: 'Marejesho',
                secValue: '0 TZS'),
            Container(
              width: 2,
              height: 40,
              color: const Color.fromARGB(196, 183, 200, 228),
            ),
            mikopoSect(
                mIcon: Symbols.point_of_sale_rounded,
                cColor: const Color.fromARGB(231, 180, 200, 234),
                miColor: const Color(0xFF505F79),
                secName: 'Faini',
                secValue: '0 TZS'),
          ],
        ),
      ),
    );
  }

  SizedBox mikopoSect(
      {required IconData mIcon,
      required Color cColor,
      required Color miColor,
      required String secName,
      required String secValue}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(color: cColor, shape: BoxShape.circle),
            child: Icon(
              mIcon,
              color: miColor,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                secName,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                secValue,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
