import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/major_screens/services/subs/service_button_column.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class ServicesMainPage extends StatefulWidget {
  const ServicesMainPage({super.key});

  @override
  State<ServicesMainPage> createState() => _ServicesMainPageState();
}

class _ServicesMainPageState extends State<ServicesMainPage> {
  KishoStyles appStyles = KishoStyles();
  List<ServiceButtonIconModule> services = <ServiceButtonIconModule>[
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(Symbols.apparel_rounded,
            size: 36, color: Color(0xFF505F79)),
        serviceId: 'vazi',
        serviceName: 'Vazi Jipya'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Image(image: AssetImage('assets/images/shiri.png')),
        serviceId: 'hdfd',
        serviceName: 'Ada'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Image(image: AssetImage('assets/images/crdb.png')),
        serviceId: 'hdfd',
        serviceName: 'Bima ya Buku'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Image(image: AssetImage('assets/images/latra.png')),
        serviceId: 'hdfd',
        serviceName: 'Latra'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Image(image: AssetImage('assets/images/ncard.png')),
        serviceId: 'hdfd',
        serviceName: 'N-Card'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Icons.motorcycle_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Kopa Chombo'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Icons.local_gas_station_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Jaza wese'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Symbols.phone_iphone_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Kopa Simu'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Symbols.service_toolbox_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Spares Parts'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Symbols.home_health_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Bima ya Maisha'),
    ServiceButtonIconModule(
        sColor: const Color(0x1A27AE60),
        sWidget: const Icon(
          Symbols.e911_emergency_rounded,
          size: 36,
          color: Color(0xFF505F79),
        ),
        serviceId: 'hdfd',
        serviceName: 'Dharura'),
  ];

  void onClickService({required serviceId}) {
    switch (serviceId) {
      case 'vazi':
        Get.toNamed('/uniform/main');
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Huduma zetu',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )),
        body: SingleChildScrollView(
            child: MasonryGridView.count(
                padding: const EdgeInsets.only(top: 40.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: services.length,
                crossAxisCount: 3,
                itemBuilder: (context, index) {
                  return ColumnButton(
                      cliFun: (scc) {
                        onClickService(serviceId: scc);
                      },
                      innerWdge: services[index].sWidget,
                      sColor: services[index].sColor,
                      serviceId: services[index].serviceId,
                      serviceName: services[index].serviceName,
                      wid: 75);
                })));
  }
}

class ServiceButtonIconModule {
  final String serviceName;
  final String serviceId;
  final Color sColor;
  final Widget sWidget;

  ServiceButtonIconModule(
      {required this.sColor,
      required this.sWidget,
      required this.serviceId,
      required this.serviceName});
}
