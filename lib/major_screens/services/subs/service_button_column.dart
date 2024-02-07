import 'package:flutter/material.dart';

class ColumnButton extends StatelessWidget {
  final String serviceName;
  final Widget innerWdge;
  final String serviceId;
  final Color sColor;
  final double wid;
  final Function cliFun;
  const ColumnButton(
      {super.key,
      required this.cliFun,
      required this.innerWdge,
      required this.sColor,
      required this.serviceId,
      required this.serviceName,
      required this.wid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        cliFun(serviceId);
      },
      child: Column(
        children: [
          Container(
            height: wid,
            width: wid,
            decoration: BoxDecoration(color: sColor, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(width: wid * 0.7, child: innerWdge),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(serviceName)
        ],
      ),
    );
  }
}
