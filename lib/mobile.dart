import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/get_apis.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/controlers/page_number_controller.dart';
import 'package:shirikisho_drivers/destination_control.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';

/// destination of bottom navifation bar module
class DestionationModule {
  final int index;
  final String label;
  final IconData icon;
  DestionationModule(this.icon, this.index, this.label);
}

// list of destionations for navigation bar
List<DestionationModule> allNavigationDestinations = <DestionationModule>[
  DestionationModule(Symbols.home_rounded, 0, 'Nyumbani'),
  DestionationModule(Symbols.spoke_rounded, 1, 'Huduma'),
  DestionationModule(Symbols.account_balance_wallet_rounded, 2, 'Malipo'),
  DestionationModule(Symbols.chat_bubble_outline_rounded, 3, 'Social'),
  DestionationModule(Symbols.person_2_rounded, 4, 'Akaunti')
];

class MobileMain extends StatefulWidget {
  const MobileMain({super.key});

  @override
  State<MobileMain> createState() => _MobileMainState();
}

class _MobileMainState extends State<MobileMain>
    with TickerProviderStateMixin<MobileMain> {
  int _selectedIndex = 0;
  final PageOnViewController _pageOnViewController =
      Get.put(PageOnViewController());

  late List<Key> _destinationKeys;
  late List<AnimationController> _faders;
  late AnimationController _hide;
  late List<int> _selectedIndexes;

  late Future<DriverDetailsModule> driverInfo;
  final GetApisClass _getApisClass = GetApisClass();
  final DriverDetailsController _driverDetailsController =
      Get.put(DriverDetailsController());

  final KishoStyles appStyles = KishoStyles();

  @override
  void initState() {
    super.initState();
    _faders = allNavigationDestinations.map((DestionationModule destinantion) {
      return AnimationController(
          vsync: this, duration: const Duration(microseconds: 200));
    }).toList();
    _faders[_selectedIndex].value = 1.0;
    _destinationKeys = List<Key>.generate(
        allNavigationDestinations.length, (int index) => GlobalKey()).toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _selectedIndexes = [0];
    driverInfo = _getApisClass.fetchDriverDetails();
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) {
      controller.dispose();
    }
    _hide.dispose();
    super.dispose();
    _selectedIndexes = [0];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndexes.add(index);
      if (index == 1) {
        _selectedIndex = index;
        _pageOnViewController.changePageonView(currentOnView: 'account');
      } else {
        _selectedIndex = index;
        _pageOnViewController.changePageonView(currentOnView: 'other');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: driverInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                _driverDetailsController.updateDriverDetails(
                    driver: snapshot.data!);
              }
              return PopScope(
                onPopInvoked: (bool didPop) {
                  if (_selectedIndex != 0) {
                    setState(() {
                      _selectedIndex =
                          _selectedIndexes[_selectedIndexes.length - 2];
                      _selectedIndexes.removeLast();
                    });
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: allNavigationDestinations
                      .map((DestionationModule destination) {
                    final Widget view = FadeTransition(
                      opacity: _faders[destination.index]
                          .drive(CurveTween(curve: Curves.fastOutSlowIn)),
                      child: KeyedSubtree(
                        key: _destinationKeys[destination.index],
                        child: DestinationControl(
                          takenPageIndex: destination.index,
                          onNavigation: () {
                            _hide.forward();
                          },
                        ),
                      ),
                    );
                    if (destination.index == _selectedIndex) {
                      _faders[destination.index].forward();
                      return view;
                    } else {
                      _faders[destination.index].reverse();
                      if (_faders[destination.index].isAnimating) {
                        return IgnorePointer(
                          child: view,
                        );
                      }
                      return Offstage(
                        child: view,
                      );
                    }
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              if (snapshot.error == 'logout') {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Unahitaji kuigia upya kwenye mfumo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onError),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.toNamed('/');
                          },
                          style: appStyles.defaultButtonStyles(),
                          child: const Text('Sawa'))
                    ],
                  ),
                );
              } else {
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
                            Get.toNamed('/');
                          },
                          style: appStyles.defaultButtonStyles(),
                          child: const Text('Sawa'))
                    ],
                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              color: Colors.blueGrey.withOpacity(0.3),
              offset: const Offset(0, -1))
        ]),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 17.0, bottom: 25.0),
          child: GNav(
              onTabChange: (index) {
                _onItemTapped(index);
              },
              backgroundColor: Colors.white,
              activeColor: Theme.of(context).colorScheme.primary,
              gap: 5.0,
              padding: const EdgeInsets.all(10.0),
              tabBackgroundColor: const Color(0xFFD3F0D5),
              tabs: allNavigationDestinations
                  .map((DestionationModule destination) {
                return GButton(
                  haptic: true,
                  icon: destination.icon,
                  text: destination.label,
                );
              }).toList()),
        ),
      ),
    );
  }
}
