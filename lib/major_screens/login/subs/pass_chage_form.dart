import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class PassChangeForMLogin extends StatefulWidget {
  const PassChangeForMLogin({super.key});

  @override
  State<PassChangeForMLogin> createState() => _PassChangeForMLoginState();
}

class _PassChangeForMLoginState extends State<PassChangeForMLogin> {
  final TextEditingController _passwordControler = TextEditingController();
  final TextEditingController _passwordControlerC = TextEditingController();
  String _errorForm = '';
  bool _loadingState = false;
  final TinyComponents _tinyComponents = TinyComponents();
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final PostMainApis _postMainApis = PostMainApis();
  String verificationCode = '';
  KishoStyles appStyles = KishoStyles();
  Widget errWigFun(String erv) {
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
        sendChangePass();
      },
      style: appStyles.defaultButtonStyles().copyWith(
          minimumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 45))),
      child: const Text('Badilisha'),
    );
  }

  Future<int> sendChangePass() async {
    setState(() {
      _errorForm = '';
      _loadingState = true;
    });
    // check if passweds matchs
    if (_passwordControler.text != _passwordControlerC.text) {
      setState(() {
        _errorForm = 'Hakikisha Neno la siri linafanana kote';
        _loadingState = false;
      });
      return 0;
    } else if (_passwordControler.text.length < 4) {
      setState(() {
        _errorForm = 'Neno la siri ni fupi sana';
        _loadingState = false;
      });
      return 0;
    } else if (!hasOnlyNumbersAndLength(verificationCode, 6)) {
      setState(() {
        _errorForm = 'Namba ya uthibisho sio sahihi';
        _loadingState = false;
      });
      return 0;
    }
    // now send reqired data
    StateDataModule ansL = await _postMainApis.forgetPassLastProcess(
        code: verificationCode,
        password: _passwordControler.text,
        otpId: _phoneInitVerificationCodeResponseController
            .phoneVerRespo.value.otpId);
    if (ansL.state != 'success') {
      setState(() {
        _errorForm = ansL.data;
        _loadingState = false;
      });
      return 0;
    }
    setState(() {
      _loadingState = false;
    });
    _tinyComponents.popupWithInfo(
        heading: 'Imefanikiwa',
        nDescreption: ansL.data,
        icon: Symbols.done_all_rounded,
        closeFun: () {
          Get.back();
          Get.offAllNamed('/sign');
        },
        okayFun: () {
          Get.back();
          Get.offAllNamed('/sign');
        });
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    return Column(
      children: [
        Text(
          'Badili neno la Siri',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          width: double.maxFinite,
          child: Text(
            'Namba ya uthibitisho',
            style: labelStyle.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 5,
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
          height: 15,
        ),
        TextFieldNoIcon(
            controller: _passwordControler,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Neno la siri jipya',
            type: TextInputType.text,
            hintTextz: 'Weka number na herufi',
            ishowing: true,
            maxlines: 1,
            minLines: 1),
        TextFieldNoIcon(
            controller: _passwordControlerC,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Hakiki neno la siri',
            type: TextInputType.text,
            hintTextz: 'Weka number na herufi',
            ishowing: true,
            maxlines: 1,
            minLines: 1),
        const SizedBox(
          height: 10,
        ),
        errWigFun(_errorForm),
        btnNLoader(_loadingState, context),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
