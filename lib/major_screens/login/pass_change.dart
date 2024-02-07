import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/major_screens/login/subs/pass_chage_form.dart';

class ChangePasswordLogin extends StatefulWidget {
  const ChangePasswordLogin({super.key});

  @override
  State<ChangePasswordLogin> createState() => _ChangePasswordLoginState();
}

class _ChangePasswordLoginState extends State<ChangePasswordLogin> {
  @override
  Widget build(BuildContext context) {
    double nim = MediaQuery.of(context).size.height - 360;
    if (nim <= 552) {
      nim = 552;
    }
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 120,
                  height: 50,
                  decoration: const BoxDecoration(
                      // color: Color.fromARGB(255, 231, 236, 240),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: SizedBox(
              child: Image(
                image: AssetImage('assets/images/intro.png'),
                width: 280,
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
            child: const PassChangeForMLogin(),
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
