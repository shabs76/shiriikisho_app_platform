import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
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
  final TextEditingController _phoneNumberController = TextEditingController();
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final PostMainApis postMainApis = PostMainApis();

  bool _loadingState = false;
  KishoStyles appStyles = KishoStyles();
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
    } else if (!isValidPhoneNumber(
        '+255${_phoneNumberController.text.substring(1)}')) {
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
    String tempEmail = _emailController.text;
    if (tempEmail == '') {
      tempEmail = 'no@example.com';
    }
    _submitDriverDetailsController.updateContactInfo(
        fname: names[0],
        mname: names[1],
        lname: names[2],
        phone: '255${_phoneNumberController.text.substring(1)}',
        email: tempEmail,
        password: _passController.text);
    setState(() {
      _loadingState = true;
    });
    VerificationResponseModule resp =
        await postMainApis.sendPhoneForverification(
            '255${_phoneNumberController.text.substring(1)}');
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
        TextFieldNoIcon(
            controller: _phoneNumberController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Namba ya Simu',
            type: TextInputType.text,
            hintTextz: '0620466139',
            maxlines: 1,
            minLines: 1),
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
                  Get.toNamed('/sign');
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
