import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/login/subs/code_form.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class LoginCode extends StatefulWidget {
  const LoginCode({super.key});

  @override
  State<LoginCode> createState() => _LoginCodeState();
}

class _LoginCodeState extends State<LoginCode> {
  final PhoneInitVerificationCodeResponseController
      _phoneInitVerificationCodeResponseController =
      Get.put(PhoneInitVerificationCodeResponseController());
  final PostMainApis _postMainApis = PostMainApis();
  bool _loadingState = false;
  String _errorForms = '';
  Future<int> forwardFun(String code) async {
    setState(() {
      _loadingState = true;
      _errorForms = '';
    });
    if (!hasOnlyNumbersAndLength(code, 6)) {
      setState(() {
        _loadingState = false;
        _errorForms = 'Namba ya uthibitisho sio sahihi';
      });
      return 0;
    }
    LoginFiDataModule ansc = await _postMainApis.loginCodeverification(
        code: code,
        otpId: _phoneInitVerificationCodeResponseController
            .phoneVerRespo.value.otpId);
    if (ansc.state != 'success') {
      setState(() {
        _loadingState = false;
        _errorForms = ansc.info;
      });
      return 0;
    }

    setState(() {
      _loadingState = true;
    });

    DriverPrefences.setLoggedinDetails(
        logey: ansc.logKey, logess: ansc.logSess);
    Get.toNamed('/mobile');
    return 1;
  }

  void backwardFun() {
    Get.toNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    double nim = MediaQuery.of(context).size.height - 340;
    if (nim <= 500) {
      nim = 500;
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
          Container(
            height: nim,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 244, 247),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: CodeLogForm(
                fFun: forwardFun,
                bFun: backwardFun,
                infoText: _phoneInitVerificationCodeResponseController
                    .phoneVerRespo.value.data,
                erroText: _errorForms,
                loadingStat: _loadingState),
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
