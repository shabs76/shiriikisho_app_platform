import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class ContactFormLog extends StatefulWidget {
  const ContactFormLog({super.key});

  @override
  State<ContactFormLog> createState() => _ContactFormLogState();
}

class _ContactFormLogState extends State<ContactFormLog> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final PostMainApis postMainApis = PostMainApis();

  bool _loadingState = false;
  KishoStyles appStyles = KishoStyles();
  String _phoneNumber = '';
  String _errorText = '';
  Future<int> sendContactForm() async {
    setState(() {
      _errorText = '';
    });
    // validate info from the form
    if (!hasThreeNames(_fnameController.text)) {
      setState(() {
        _errorText = 'Hakikisha umeweka majina yote matatu';
      });
      return 0;
    } else if (!isValidPhoneNumber(_phoneNumber)) {
      setState(() {
        _errorText =
            'Namba ya simu sio sahihi tafadhali hakikisha. Na ujaribu tena';
      });
      return 0;
    } else if (!isValidEmail(_emailController.text) &&
        _emailController.text.replaceAll(' ', '') != '') {
      setState(() {
        _errorText = 'Barua pepe uliyoweka sio sahihi. Kama hauna usijaze';
      });
      return 0;
    } else if (!isValidPassword(_passController.text)) {
      setState(() {
        _errorText =
            'Hakikisha neno la siri lina herufi zaidi ya sita na lina namba pia';
      });
      return 0;
    }

    List<String> names = extractThreeNames(_fnameController.text);
    // save to getx results here
    if (names.length < 3) {
      setState(() {
        _errorText = 'Hakikisha umeweka majina matatu';
      });
      return 0;
    }
    _submitDriverDetailsController.updateContactInfo(
        fname: names[0],
        mname: names[1],
        lname: names[2],
        phone: _phoneNumber,
        email: _emailController.text,
        password: _passController.text);
    setState(() {
      _loadingState = true;
    });
    VerificationResponseModule resp =
        await postMainApis.sendPhoneForverification(_phoneNumber.substring(1));
    if (resp.state != 'success') {
      setState(() {
        _loadingState = false;
        _errorText = resp.data;
      });
      return 0;
    }

    setState(() {
      _loadingState = false;
    });

    _phoneInitVerificationCodeResponseController.updateRespos(resp);
    Get.toNamed('/reg/code');
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
        sendContactForm();
      },
      style: appStyles.defaultButtonStyles().copyWith(
          minimumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 45))),
      child: const Text('Jiunge'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);

    return Column(
      children: [
        Text(
          'Jiunge',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(
          height: 15,
        ),
        TextFieldNoIcon(
            controller: _fnameController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Jina Kamili',
            type: TextInputType.text,
            hintTextz: 'Joshua Nzega Mlacha',
            maxlines: 1,
            minLines: 1),
        const SizedBox(
          height: 5,
        ),
        TextFieldNoIcon(
            controller: _emailController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Barua Pepe',
            type: TextInputType.emailAddress,
            hintTextz: 'JoshuaN88@gmail.com (sio lazima)',
            maxlines: 1,
            minLines: 1),
        const SizedBox(
          height: 5,
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
                labelText: 'Phone number',
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
                _phoneNumber = num.phoneNumber!;
              });
            }),
        const SizedBox(
          height: 15,
        ),
        TextFieldNoIcon(
            controller: _passController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Neno la Siri',
            type: TextInputType.emailAddress,
            hintTextz: 'ngumu ndefu',
            ishowing: true,
            maxlines: 1,
            minLines: 1),
        const SizedBox(
          height: 5,
        ),
        errWigFun(_errorText),
        btnNLoader(_loadingState, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nina akaunti?'),
            TextButton(
                onPressed: () {
                  Get.toNamed('/');
                },
                child: const Text(
                  'Ingia',
                  style: TextStyle(fontSize: 15),
                ))
          ],
        ),
      ],
    );
  }
}
