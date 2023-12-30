import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _passwordControler = TextEditingController();
  String phonNum = '';
  String _errorForm = '';
  bool _loadingState = false;
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final PostMainApis _postMainApis = PostMainApis();
  KishoStyles appStyles = KishoStyles();
  Future<int> sendInitLoginInf() async {
    setState(() {
      _errorForm = '';
      _loadingState = true;
    });
    if (!isValidPhoneNumber(phonNum)) {
      setState(() {
        _errorForm =
            'Namba ya simu sio sahihi. Tafadhali hakiki kabla ya kutuma';
        _loadingState = false;
      });
      return 0;
    } else if (_passwordControler.text.length < 3) {
      setState(() {
        _errorForm = 'Neno ya siri sio sahihi. Tafadhali jaribu tena';
        _loadingState = false;
      });
      return 0;
    }

    // now send login details
    VerificationResponseModule ans = await _postMainApis.loginInitPhone(
        phone: phonNum.substring(1), password: _passwordControler.text);

    if (ans.state != 'success') {
      setState(() {
        _loadingState = false;
        _errorForm = ans.data;
      });
      return 0;
    }

    setState(() {
      _loadingState = false;
    });
    _phoneInitVerificationCodeResponseController.updateRespos(ans);
    Get.toNamed('/login/code');
    return 1;
  }

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
        sendInitLoginInf();
      },
      style: appStyles.defaultButtonStyles().copyWith(
          minimumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 45))),
      child: const Text('Ingia'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    return Column(
      children: [
        Text(
          'Ingia',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(
          height: 35,
        ),
        SizedBox(
          width: double.maxFinite,
          child: Text(
            'Phone Number',
            style: labelStyle.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        InternationalPhoneNumberInput(
            inputDecoration: const InputDecoration(
                contentPadding: EdgeInsets.all(7.0),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide:
                        BorderSide(width: 1.0, color: Color(0xFFC7D3DD))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide:
                        BorderSide(width: 1.0, color: Color(0xFFC7D3DD))),
                filled: true,
                labelText: 'Enter phone number',
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70),
                fillColor: Color(0xFFFFFFFF),
                hintText: 'eg. 0620466139'),
            selectorConfig: const SelectorConfig(
                setSelectorButtonAsPrefixIcon: true,
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
            countries: const ['TZ'],
            spaceBetweenSelectorAndTextField: 0,
            onInputChanged: (PhoneNumber num) {
              setState(() {
                phonNum = num.phoneNumber!;
              });
            }),
        const SizedBox(
          height: 15,
        ),
        TextFieldNoIcon(
            controller: _passwordControler,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Neno la siri',
            type: TextInputType.text,
            hintTextz: 'weka refu na gumu',
            ishowing: true,
            maxlines: 1,
            minLines: 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forget password?',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        errWigFun(_errorForm),
        btnNLoader(_loadingState, context),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sina akaunti?'),
            TextButton(
                onPressed: () {
                  Get.toNamed('/registration');
                },
                child: const Text(
                  'Jiunge',
                  style: TextStyle(fontSize: 15),
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/reg/cards');
                    },
                    style: appStyles.roundButtonStyles().copyWith(
                        foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor:
                            const MaterialStatePropertyAll(Color(0x4524B42E)),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(10)),
                        maximumSize:
                            const MaterialStatePropertyAll(Size(50, 50))),
                    child: const Icon(Symbols.report_rounded)),
                const Text(
                  'Toa taarifa',
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: appStyles.roundButtonStyles().copyWith(
                        foregroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        shadowColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        backgroundColor:
                            const MaterialStatePropertyAll(Color(0x4524B42E)),
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(10)),
                        maximumSize:
                            const MaterialStatePropertyAll(Size(50, 50))),
                    child: const Icon(Symbols.how_to_reg_rounded)),
                const Text(
                  'Hakiki dereva',
                  style: TextStyle(fontSize: 13),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
