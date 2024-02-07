import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/special/count_down.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';

class CodeLogForm extends StatefulWidget {
  final Function fFun;
  final Function bFun;
  final String infoText;
  final String erroText;
  final bool loadingStat;
  const CodeLogForm(
      {super.key,
      this.erroText = '',
      required this.fFun,
      required this.bFun,
      this.infoText = 'Ingiza number iliyotumwa kwenye 07****76',
      this.loadingStat = false});

  @override
  State<CodeLogForm> createState() => _CodeLogFormState();
}

class _CodeLogFormState extends State<CodeLogForm> {
  late String verificationCode = '';
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final KishoStyles appStyles = KishoStyles();
  final TinyComponents _tinyComponents = TinyComponents();
  final PostMainApis _postMainApis = PostMainApis();
  bool _loadingCode = false;
  int _countSec = 60;
  Widget errWigFun(erv) {
    if (erv != '') {
      return Column(
        children: [
          Text(
            erv,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onError, fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }
    return const SizedBox();
  }

  Widget btnNLoader(bool lder, BuildContext context) {
    if (lder) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      );
    }
    return ElevatedButton(
        onPressed: () {
          widget.fFun(verificationCode);
        },
        style: appStyles.defaultButtonStyles().copyWith(
              minimumSize:
                  const MaterialStatePropertyAll(Size(double.maxFinite, 45)),
            ),
        child: const Text('Endelea'));
  }

  Widget countLoader(bool lder, BuildContext context) {
    if (lder) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    return CountdownWidget(
        seconds: _countSec,
        resendFun: () {
          resendCode();
        });
  }

  Future<int> resendCode() async {
    if (_phoneInitVerificationCodeResponseController
            .phoneVerRespo.value.otpId ==
        '') {
      _tinyComponents.popupWithInfo(
        heading: "Tatizo",
        nDescreption: 'Namba ya udhabiti haipo sitisha uanze tena',
        icon: Symbols.error_rounded,
        closeFun: () {
          Get.back();
        },
        okayFun: () {
          Get.back();
        },
        onColor: const Color.fromARGB(139, 252, 98, 98),
        iColor: const Color(0xFFFF3636),
      );
      return 0;
    }

    setState(() {
      _loadingCode = true;
    });

    StateDataModule ansc = await _postMainApis.resendCodeProce(
        otpId: _phoneInitVerificationCodeResponseController
            .phoneVerRespo.value.otpId);
    if (ansc.state != 'success') {
      setState(() {
        _loadingCode = false;
        _countSec = 1;
      });
      _tinyComponents.popupWithInfo(
        heading: "Tatizo",
        nDescreption: ansc.data,
        icon: Symbols.error_rounded,
        closeFun: () {
          Get.back();
        },
        okayFun: () {
          Get.back();
        },
        onColor: const Color.fromARGB(139, 252, 98, 98),
        iColor: const Color(0xFFFF3636),
      );
      return 0;
    }
    setState(() {
      _countSec = 60;
      _loadingCode = false;
    });
    _tinyComponents.popupWithInfo(
      heading: "Imefanikiwa",
      nDescreption: ansc.data,
      icon: Symbols.done_all_rounded,
      closeFun: () {
        Get.back();
      },
      okayFun: () {
        Get.back();
      },
    );
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hakikisha namba yako',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.maxFinite,
          child: Text(
            widget.infoText,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PinCodeTextField(
          appContext: context,
          length: 6,
          enableActiveFill: true,
          autovalidateMode: AutovalidateMode.disabled,
          onChanged: (value) {
            setState(() {
              verificationCode = value;
            });
          },
          useHapticFeedback: true,
          // #
          pinTheme: PinTheme(
              inactiveColor: const Color(0xFF505F79),
              inactiveFillColor: const Color(0x1A505F79),
              activeColor: Theme.of(context).colorScheme.primary,
              selectedColor: Theme.of(context).colorScheme.primary,
              selectedFillColor: Theme.of(context).colorScheme.primary,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(4),
              fieldHeight: 50,
              fieldWidth: 45,
              activeFillColor: const Color.fromARGB(255, 255, 255, 255)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [countLoader(_loadingCode, context)],
        ),
        const SizedBox(
          height: 20,
        ),
        errWigFun(widget.erroText),
        ElevatedButton(
            onPressed: () {
              widget.bFun();
            },
            style: appStyles.defaultButtonStyles().copyWith(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.maxFinite, 45)),
                backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFFCFD0D0))),
            child: const Text('Sitisha')),
        const SizedBox(
          height: 20,
        ),
        btnNLoader(widget.loadingStat, context),
      ],
    );
  }
}
