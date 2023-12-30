import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/get_apis.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  late Future<List<FullDriverDetailsModule>> members;
  final GetApisClass _apisClass = GetApisClass();
  final KishoStyles _appStyles = KishoStyles();
  final TinyComponents _tinyComponents = TinyComponents();
  @override
  void initState() {
    super.initState();
    members = _apisClass.fetchDriverMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: const Color.fromARGB(100, 0, 0, 0),
        title: const Text(
          'Wanachama',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
          future: members,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return _tinyComponents.notFoundWidget(context,
                    'Hakuna dereva mwengine kwenye kutuo chako.', 'Sawa', () {
                  Get.offNamed('/mobile');
                });
              }
              return LayoutBuilder(builder: (context, constraints) {
                return MasonryGridView.count(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    crossAxisCount: constraints.maxWidth > 720 ? 4 : 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    shrinkWrap: true,
                    addAutomaticKeepAlives: false,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _tinyComponents.driverGridNoActCard(
                          context,
                          '${snapshot.data![index].fname} ${snapshot.data![index].lname}',
                          snapshot.data![index].status,
                          imageProcessorFromID(snapshot.data![index].passport));
                    });
              });
            } else if (snapshot.hasError) {
              if ('${snapshot.error}' == 'logout') {
                DriverPrefences.removeLoggedinDetails();
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Symbols.sentiment_sad_rounded,
                        size: 63,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                      const Text(
                        'Samahani unahitaji kuingia upya kwenye mfumo kupata huduma hii',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/');
                          },
                          style: _appStyles.defaultButtonStyles(),
                          child: const Text('Sawa'))
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Symbols.sentiment_sad_rounded,
                      size: 73,
                      color: Theme.of(context).colorScheme.onError,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ));
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }),
      bottomNavigationBar: Container(
        height: 18,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
