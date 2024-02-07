import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class MikopoBannerHome extends StatelessWidget {
  const MikopoBannerHome({super.key});

  @override
  Widget build(BuildContext context) {
    KishoStyles appStyles = KishoStyles();
    return SizedBox(
      child: Stack(children: [
        Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Niwakati wa kutoka kiuchumi.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Pata huduma za mikopo wa riba nafuu kutoka watoa huduma wetu',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: appStyles.defaultButtonStyles(),
                          child: const Text('Ona huduma'))
                    ],
                  ),
                ),
                Image(
                  image: const AssetImage('assets/images/intro2.png'),
                  width: MediaQuery.of(context).size.width * 0.9 - 190,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
