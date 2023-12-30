import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';

class TinyComponents {
  ElevatedButton buttonColumn(KishoStyles appStyles, BuildContext context,
      Function clFun, String btName, IconData icon) {
    return ElevatedButton(
        onPressed: () {
          clFun();
        },
        style: appStyles.roundButtonStyles().copyWith(
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            surfaceTintColor:
                const MaterialStatePropertyAll(Colors.transparent),
            maximumSize: const MaterialStatePropertyAll(Size(120, 100)),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x1A27AE60),
              ),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              btName,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            )
          ],
        ));
  }

  KishoStyles appStyles = KishoStyles();

  Widget driverGridCard(
      BuildContext context,
      Function actionFun,
      String nameDriver,
      String typeShow,
      String actionName,
      String profileDrive) {
    return SizedBox(
      width: 110,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                ),
                child: ClipOval(
                    child: Image.network(
                  profileDrive,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(assest404Image, fit: BoxFit.contain);
                  },
                )),
                //
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                nameDriver,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: Color(0xFFCFD0D0), shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    typeShow,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 121, 124, 124)),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              ElevatedButton(
                  onPressed: () {
                    actionFun();
                  },
                  style: appStyles.defaultButtonStyles().copyWith(
                      minimumSize: const MaterialStatePropertyAll(Size(90, 30)),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 5, vertical: 3))),
                  child: Text(
                    actionName,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget driverGridNoActCard(BuildContext context, String nameDriver,
      String typeShow, String profileDrive) {
    return SizedBox(
      width: 110,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primary, width: 2),
                ),
                child: ClipOval(
                    child: Image.network(
                  profileDrive,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(assest404Image, fit: BoxFit.contain);
                  },
                )),
                //
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                nameDriver,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
              ),
              const SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: typeShow == 'active'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                        shape: BoxShape.circle),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    typeShow == 'active' ? 'Hai' : 'Amefungiwa',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 121, 124, 124)),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget notFoundWidget(BuildContext context, String message, String butonName,
      Function actionBtn) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(assest404Image),
            width: MediaQuery.of(context).size.width * 0.90,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                actionBtn();
              },
              style: appStyles.defaultButtonStyles(),
              child: Text(butonName))
        ],
      ),
    );
  }

  void popupWithInfo(
      {required String heading,
      required String nDescreption,
      required IconData icon,
      required Function closeFun,
      required Function okayFun,
      Color onColor = const Color(0x4524B42E),
      Color iColor = const Color(0xFF24B42E)}) {
    Get.dialog(
        Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          closeFun();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 28,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: 65,
                  height: 65,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: onColor),
                  child: Icon(
                    icon,
                    color: iColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  nDescreption,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      okayFun();
                    },
                    style: appStyles.defaultButtonStyles(),
                    child: const Text('Sawa'))
              ],
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
