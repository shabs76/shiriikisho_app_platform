import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input_icon.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class UniformPaymentMobile extends StatefulWidget {
  const UniformPaymentMobile({super.key});

  @override
  State<UniformPaymentMobile> createState() => _UniformPaymentMobileState();
}

class _UniformPaymentMobileState extends State<UniformPaymentMobile> {
  final TextEditingController _phoneNumber = TextEditingController();
  final KishoStyles appStyles = KishoStyles();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
      children: [
        const Text('Huduma'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0x1A505F79)),
              borderRadius: BorderRadius.circular(6)),
          child: const Text(
            'Vazi jipya Bodaboda',
            style: TextStyle(fontSize: 14, color: Color(0xFF505F79)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
          decoration: BoxDecoration(
              color: const Color(0x1A27AE60),
              borderRadius: BorderRadius.circular(6)),
          child: const Text("Maelezo ya malipo",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        const SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Vitu Vinavyolipiwa",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 6,
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
                height: 18,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kiasi unacholipia:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "TZS106,200",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0x1A27AE60),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Column(
                      children: [
                        Text(
                          'Kiasi Halisi',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF505F79)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text("TZS90,000",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14))
                      ],
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0x1A27AE60),
                        borderRadius: BorderRadius.circular(6)),
                    child: const Column(
                      children: [
                        Text(
                          'VAT',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF505F79)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "TZS16,200",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        )
                      ],
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFieldWithPreIcon(
            controller: _phoneNumber,
            borderColor: Theme.of(context).colorScheme.primary,
            fillcolor: const Color(0xFFFAFAFA),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: const TextStyle(),
            labelText: "Namba ya simu",
            maxlines: 1,
            minLines: 1,
            hintTextz: "069xxxxxxxx",
            icon: Symbols.call_rounded,
            icolor: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {},
            style: appStyles.defaultButtonStyles().copyWith(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.maxFinite, 45))),
            child: const Text("Lipia Sasa"))
      ],
    );
  }
}
