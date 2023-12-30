import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/apis/get_apis.dart';
import 'package:shirikisho_drivers/controlers/input_selects_data_list.dart';
import 'package:shirikisho_drivers/major_screens/registraction/subs/contacts_form.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';

class RegistrationContacts extends StatefulWidget {
  const RegistrationContacts({super.key});

  @override
  State<RegistrationContacts> createState() => _RegistrationContactsState();
}

class _RegistrationContactsState extends State<RegistrationContacts> {
  // regiInputList Controller
  final RegistrationInputListController registrationInputListController =
      Get.put(RegistrationInputListController());
  late Future<RegistrationGetInfo> registrationGetInfo;
  final GetApisClass _getApisClass = GetApisClass();

  KishoStyles kishoStyles = KishoStyles();
  @override
  void initState() {
    super.initState();
    registrationGetInfo = _getApisClass.fetchRegistListInfo();
  }

  @override
  Widget build(BuildContext context) {
    double nim = MediaQuery.of(context).size.height - 360;
    if (nim <= 632) {
      nim = 632;
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
            child: FutureBuilder(
                future: registrationGetInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.message != '') {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              snapshot.data!.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: kishoStyles.defaultButtonStyles(),
                                child: const Text('Okay'))
                          ],
                        ),
                      );
                    } else {
                      registrationInputListController
                          .updateRegInputList(snapshot.data!);
                      return const ContactFormLog();
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onError),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: kishoStyles.defaultButtonStyles(),
                              child: const Text('Okay'))
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }),
          ),
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
