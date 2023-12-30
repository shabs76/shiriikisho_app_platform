import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/login/subs/code_form.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class RegistrationCode extends StatefulWidget {
  const RegistrationCode({super.key});

  @override
  State<RegistrationCode> createState() => _RegistrationCodeState();
}

class _RegistrationCodeState extends State<RegistrationCode> {
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  final PostMainApis _postMainApis = PostMainApis();
  bool _loadingState = false;
  String _errorForms = '';
  @override
  void initState() {
    super.initState();
  }

  Future<int> sendVerCode(String code) async {
    if (!hasOnlyNumbersAndLength(code, 6)) {
      setState(() {
        _errorForms = 'Hakikisha unajaza namba tu kwenye viboksi vyote';
      });
      return 0;
    }
    setState(() {
      _loadingState = true;
      _errorForms = '';
    });

    VerificationCodeResponseModule resp =
        await _postMainApis.sendVerificationCodeFun(
            code,
            _phoneInitVerificationCodeResponseController
                .phoneVerRespo.value.otpId);
    if (resp.state != 'success') {
      setState(() {
        _loadingState = false;
        _errorForms = resp.data;
      });
      return 0;
    }
    setState(() {
      _loadingState = false;
      _errorForms = '';
    });
    // save verid
    _submitDriverDetailsController.updateVeridInfo(verid: resp.verid);
    Get.toNamed('/reg/personal');
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    double nim = MediaQuery.of(context).size.height - 500;
    if (nim <= 460) {
      nim = 460;
    }
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              child: Image(
                image: const AssetImage('assets/images/intro.png'),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - (500 + nim) > 0
                ? 0
                : (-1 * (MediaQuery.of(context).size.height - (nim + 500))),
          ),
          Container(
            height: nim,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 244, 247),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Obx(() => CodeLogForm(
                  fFun: sendVerCode,
                  bFun: () {
                    Get.back();
                  },
                  infoText: _phoneInitVerificationCodeResponseController
                      .phoneVerRespo.value.data,
                  erroText: _errorForms,
                  loadingStat: _loadingState,
                )),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 18,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 240, 244, 247)),
      ),
    );
  }
}
