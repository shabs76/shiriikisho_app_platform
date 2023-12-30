import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';

class DriverPersonalDetailsReview extends StatelessWidget {
  final String driverProfile;
  final String driverName;
  final String rank;
  final String gender;
  final String relation;
  const DriverPersonalDetailsReview(
      {required this.driverName,
      required this.driverProfile,
      required this.gender,
      required this.rank,
      required this.relation,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 2),
              shape: BoxShape.circle),
          child: ClipOval(
              child: Image.network(
            driverProfile,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(assest404Image, fit: BoxFit.contain);
            },
          )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              driverName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cheo',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xB2505F79)),
                    ),
                    Text(
                      rank,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xB2505F79)),
                    )
                  ],
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary))),
                ),
                const SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jisia',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xB2505F79)),
                    ),
                    Text(
                      gender,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xB2505F79)),
                    )
                  ],
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary))),
                ),
                const SizedBox(
                  width: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mahusiano',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xB2505F79)),
                    ),
                    Text(
                      relation,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xB2505F79)),
                    )
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
