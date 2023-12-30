import 'package:flutter/material.dart';

class DriverDetailsShort extends StatelessWidget {
  final String fname;
  final String rank;
  final String parkName;
  final String driverNumber;
  final String residence;
  const DriverDetailsShort(
      {required this.driverNumber,
      required this.fname,
      required this.parkName,
      required this.rank,
      required this.residence,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          driverNumber,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 1,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 7),
              decoration:
                  const BoxDecoration(border: Border(right: BorderSide.none)),
              child: Text(rank,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            Container(
              height: 13,
              margin: const EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2))),
            ),
            Container(
              decoration:
                  const BoxDecoration(border: Border(right: BorderSide.none)),
              child: Text(parkName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          residence,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        )
      ],
    );
  }
}
