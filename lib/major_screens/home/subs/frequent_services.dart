import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';

class FrequentServices extends StatefulWidget {
  const FrequentServices({super.key});

  @override
  State<FrequentServices> createState() => _FrequentServicesState();
}

class _FrequentServicesState extends State<FrequentServices> {
  final List<FrequentServiceModule> _frequServ = [
    FrequentServiceModule(
        id: 'yetrt',
        name: 'Ada',
        sColor: const Color(0x1A27AE60),
        seveWidget: Image.asset('assets/images/shiri.png')),
    FrequentServiceModule(
        id: 'yetrtgd',
        name: 'Latra',
        sColor: const Color(0x1A27AE60),
        seveWidget: Image.asset('assets/images/latra.png')),
    FrequentServiceModule(
        id: 'yetrtgd',
        name: 'Bima ya Buku',
        sColor: const Color(0x1A27AE60),
        seveWidget: Image.asset('assets/images/crdb.png')),
    FrequentServiceModule(
        id: 'yetrtgd',
        name: 'N-Card',
        sColor: const Color(0x1A27AE60),
        seveWidget: Image.asset('assets/images/ncard.png')),
  ];
  final TinyComponents _tinyComponents = TinyComponents();
  void openService(serviId) {}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Huduma Maarufu',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        SizedBox(
            height: 150,
            child: ListView.separated(
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _tinyComponents.appLikeServiceButton(
                      context,
                      _frequServ[index].name,
                      _frequServ[index].id,
                      openService,
                      120,
                      120,
                      _frequServ[index].sColor,
                      _frequServ[index].seveWidget);
                },
                separatorBuilder: (context, _) => const SizedBox(
                      width: 15,
                    ),
                itemCount: _frequServ.length)),
      ],
    );
  }
}

class FrequentServiceModule {
  final String name;
  final String id;
  final Color sColor;
  final Widget seveWidget;

  FrequentServiceModule(
      {required this.id,
      required this.name,
      required this.sColor,
      required this.seveWidget});
}
