import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/major_screens/uniform/subs/popups.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class UniformMainScreen extends StatefulWidget {
  const UniformMainScreen({super.key});

  @override
  State<UniformMainScreen> createState() => _UniformMainScreenState();
}

class _UniformMainScreenState extends State<UniformMainScreen> {
  final KishoStyles appStyles = KishoStyles();
  final UniformsPopup _uniformsPopup = UniformsPopup();

  void futOpenSucessPay() {
    Get.back();
    _uniformsPopup.openDonePaymentsAdas(
        context: context,
        heading: "Imekamilika",
        internals: [
          _uniformsPopup.successPaymentRow(rowName: 'Ada ya Latra'),
          _uniformsPopup.successPaymentRow(rowName: 'Ada ya maegesho'),
          _uniformsPopup.successPaymentRow(rowName: 'Ada ya Shirikisho'),
        ],
        descrpt: 'Sasa unaweza endelea kulipia vazi jipya',
        closePop: openPayPage);
  }

  void openPayPage() {
    Get.offAndToNamed('/uniform/payment');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 218, 221),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Mwonekano Mpya',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      body: ListView(padding: const EdgeInsets.only(top: 20), children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Text(
                'Ilala',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/helment.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const Text(
                    'Dereva',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/helment.png',
                    ),
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  const Text(
                    'Abiria',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                'assets/images/ilala-vazi.png',
              ),
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Vazi Bodaboda',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Color(0xFF505F79)),
                  ),
                  Text(
                    'TZS106,200',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(
                    Symbols.point_scan_rounded,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Koti la dereva',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF505F79)),
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                children: [
                  Icon(
                    Symbols.point_scan_rounded,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Kofia ngumu ya dereva',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF505F79)),
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                children: [
                  Icon(
                    Symbols.point_scan_rounded,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Kofia ngumu ya abiria',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF505F79)),
                  )
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                children: [
                  Icon(
                    Symbols.point_scan_rounded,
                    size: 14,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Kiakisi mwanga cha abiria',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF505F79)),
                  )
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              ElevatedButton(
                  onPressed: () {
                    _uniformsPopup.openLoadingPayments(
                        context: context,
                        heading: "Subiri",
                        internals: [
                          _uniformsPopup.loadRowPaymentsLoading(
                              rowName: 'Ada ya Latra'),
                          _uniformsPopup.loadRowPaymentsLoading(
                              rowName: 'Ada ya maegesho'),
                          _uniformsPopup.loadRowPaymentsLoading(
                              rowName: 'Ada ya Shirikisho'),
                        ],
                        descrpt: "Tafadhali subiri wakati tuangalia:-");
                    Future.delayed(
                        const Duration(seconds: 3), futOpenSucessPay);
                  },
                  style: appStyles.defaultButtonStyles().copyWith(
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.maxFinite, 45))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Pata vazi jipya'),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.east_rounded)
                    ],
                  ))
            ]),
          ),
        )
      ]),
      bottomNavigationBar: Container(
        height: 18,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 214, 218, 221)),
      ),
    );
  }
}
