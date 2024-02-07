import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/controlers/input_selects_data_list.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/select_with_search.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';

class RegistrationParksPage extends StatefulWidget {
  const RegistrationParksPage({super.key});

  @override
  State<RegistrationParksPage> createState() => _RegistrationParksPageState();
}

class _RegistrationParksPageState extends State<RegistrationParksPage> {
  final KishoStyles appStyles = KishoStyles();

  final RegistrationInputListController registrationInputListController =
      Get.put(RegistrationInputListController());
  late List<ParkAreaModule> _parks;
  late List<ChamaModule> _chamas;
  Map<String, String> _parkNameIdMap = {};
  final Map<String, String> _chamaNameIdMap = {};
  String _selectedPark = '';
  String _selectedChama = 'Chama';
  late List<RegionsModule> _regions;
  final Map<String, String> _regionIdMap = {};
  final String _selectedRegion = 'Mikoa';
  late List<DistrictModule> _districts;
  Map<String, String> _distIdMap = {};
  String _selectedDist = '';
  late List<WardsModule> _wards;
  Map<String, String> _wardsIdMap = {};
  String _selectedWard = '';
  String _userPark = '';
  String _userChama = '';
  String _errorForm = '';

  // controler
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());

  //keys
  final GlobalKey<DropdownSearchState<String>> dropdownRegs = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownDist = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownWard = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownPark = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownChama = GlobalKey();
  Widget errWigFun(erv) {
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

  void onRegionChange({required String nameChange}) {
    List<DistrictModule> tHDist = [];
    Map<String, String> tDisMap = {};
    if (_regionIdMap.containsKey(nameChange) &&
        _regionIdMap[nameChange] != '') {
      List<DistrictModule> tDist =
          registrationInputListController.regiList.value.districts;
      for (var i = 0; i < tDist.length; i++) {
        if (tDist[i].regId == _regionIdMap[nameChange]) {
          tHDist.add(tDist[i]);
          tDisMap[tDist[i].distName] = tDist[i].distId;
        }
      }
    }

    dropdownDist.currentState!.clear();
    dropdownWard.currentState!.clear();
    dropdownPark.currentState!.clear();
    setState(() {
      _districts = tHDist;
      _wards = [WardsModule(distId: '', wardId: '', wardName: 'Kata')];
      _wardsIdMap = {};
      _parks = [
        ParkAreaModule(parkId: '', parkName: 'Vituo', parkSize: 0, wardId: '')
      ];
      _parkNameIdMap = {};
      _distIdMap = tDisMap;
      _selectedDist = 'Wilaya';
      _selectedPark = 'Vituo';
      _selectedWard = "Kata";
      _userPark = '';
    });
  }

  void onDistChange({required String nameChange}) {
    List<WardsModule> tHwardx = [];
    Map<String, String> tWardMap = {};
    if (_distIdMap.containsKey(nameChange) && _distIdMap[nameChange] != '') {
      List<WardsModule> tWard =
          registrationInputListController.regiList.value.wards;
      for (var i = 0; i < tWard.length; i++) {
        if (tWard[i].distId == _distIdMap[nameChange]) {
          tHwardx.add(tWard[i]);
          tWardMap[tWard[i].wardName] = tWard[i].wardId;
        }
      }
    }
    dropdownWard.currentState!.clear();
    dropdownPark.currentState!.clear();
    setState(() {
      _wards = tHwardx;
      _wardsIdMap = tWardMap;
      _parks = [
        ParkAreaModule(parkId: '', parkName: 'Vituo', parkSize: 0, wardId: '')
      ];
      _parkNameIdMap = {};
      _selectedPark = 'Vituo';
      _selectedWard = "Kata";
      _userPark = '';
    });
  }

  void onWardChange({required String nameChanga}) {
    List<ParkAreaModule> tHParks = [];
    Map<String, String> tParksMap = {};
    if (_wardsIdMap.containsKey(nameChanga) && _wardsIdMap[nameChanga] != '') {
      List<ParkAreaModule> tParks =
          registrationInputListController.regiList.value.park;
      for (var i = 0; i < tParks.length; i++) {
        if (tParks[i].wardId == _wardsIdMap[nameChanga]) {
          tHParks.add(tParks[i]);
          tParksMap[tParks[i].parkName] = tParks[i].parkId;
        }
      }
    }
    dropdownPark.currentState!.clear();
    setState(() {
      _parks = tHParks;
      _parkNameIdMap = tParksMap;
      _selectedWard = "Kata";
      _userPark = '';
    });
  }

  int saveParkArea() {
    setState(() {
      _errorForm = '';
    });
    if (_userPark == '' || _userPark == 'Vituo') {
      setState(() {
        _errorForm = 'Tafadhali chagua kituo chako cha kazi';
      });
      return 0;
    } else if (_userChama == '' || _userChama == 'Chama') {
      setState(() {
        _errorForm = "Tafadhali chagua chama chako";
      });
      return 0;
    }
    _submitDriverDetailsController.updateParkingInfo(
        parkArea: _userPark, chama: _userChama);
    Get.toNamed('/reg/personal');
    return 1;
  }

  @override
  void initState() {
    super.initState();
    // regions
    _regions = registrationInputListController.regiList.value.regions;
    for (var i = 0; i < _regions.length; i++) {
      _regionIdMap[_regions[i].regionName] = _regions[i].regId;
    }

    _chamas = registrationInputListController.regiList.value.chamas;
    for (var i = 0; i < _chamas.length; i++) {
      _chamaNameIdMap[_chamas[i].chamaName] = _chamas[i].chamaId;
    }
    _userChama = 'Chama';

    // districts registrationInputListController.regiList.value.districts
    _districts = [];
    for (var i = 0; i < _districts.length; i++) {
      _distIdMap[_districts[i].distName] = _districts[i].distId;
    }
    _selectedDist = 'Wilaya';
    // wards
    _wards = [];
    for (var i = 0; i < _wards.length; i++) {
      _wardsIdMap[_wards[i].wardName] = _wards[i].wardId;
    }
    _selectedWard = 'Kata';
    // parks
    _parks = [];
    for (var i = 0; i < _parks.length; i++) {
      _parkNameIdMap[_parks[i].parkName] = _parks[i].parkId;
    }
    _selectedPark = 'Vituo';
  }

  @override
  void dispose() {
    super.dispose();
    _regions = [];
    _districts = [];
    _wards = [];
    _parks = [];
    _chamas = [];
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taarifa za Chama',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
            value: 0.25,
          ),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          children: [
            SizedBox(
              child: Column(
                children: [
                  SelectWithSearchInput(
                    borderColor: const Color(0xFFC7D3DD),
                    dropdownKey: dropdownRegs,
                    fillcolor: Colors.white,
                    focusedColor: Theme.of(context).colorScheme.primary,
                    itemz: _regions.map((reg) => reg.regionName).toList(),
                    selecedFun: (itm) {
                      onRegionChange(nameChange: itm);
                    },
                    labelText: 'Chagua Mkoa',
                    labelStyles: labelStyle,
                    selectedItem: _selectedRegion,
                  ),
                  SelectWithSearchInput(
                    borderColor: const Color(0xFFC7D3DD),
                    dropdownKey: dropdownDist,
                    fillcolor: Colors.white,
                    focusedColor: Theme.of(context).colorScheme.primary,
                    itemz: _districts.map((e) => e.distName).toList(),
                    selecedFun: (itm) {
                      onDistChange(nameChange: itm);
                    },
                    labelText: 'Chagua Wilaya',
                    labelStyles: labelStyle,
                    selectedItem: _selectedDist,
                  ),
                  SelectWithSearchInput(
                    borderColor: const Color(0xFFC7D3DD),
                    dropdownKey: dropdownWard,
                    fillcolor: Colors.white,
                    focusedColor: Theme.of(context).colorScheme.primary,
                    itemz: _wards.map((e) => e.wardName).toList(),
                    selecedFun: (itm) {
                      onWardChange(nameChanga: itm);
                    },
                    labelText: 'Chagua Kata',
                    labelStyles: labelStyle,
                    selectedItem: _selectedWard,
                  ),
                  SelectWithSearchInput(
                    borderColor: const Color(0xFFC7D3DD),
                    dropdownKey: dropdownPark,
                    fillcolor: Colors.white,
                    focusedColor: Theme.of(context).colorScheme.primary,
                    itemz: _parks.map((e) => e.parkName).toList(),
                    selecedFun: (itm) {
                      setState(() {
                        if (_parkNameIdMap.containsKey(itm) &&
                            _parkNameIdMap[itm] != '') {
                          _userPark = _parkNameIdMap[itm]!;
                        }
                      });
                    },
                    labelText: 'Chagua Kituo',
                    labelStyles: labelStyle,
                    selectedItem: _selectedPark,
                  ),
                  SelectWithSearchInput(
                    borderColor: const Color(0xFFC7D3DD),
                    dropdownKey: dropdownChama,
                    fillcolor: Colors.white,
                    focusedColor: Theme.of(context).colorScheme.primary,
                    itemz: _chamas.map((e) => e.chamaName).toList(),
                    selecedFun: (itm) {
                      setState(() {
                        if (_chamaNameIdMap.containsKey(itm) &&
                            _chamaNameIdMap[itm] != '') {
                          _userChama = _chamaNameIdMap[itm]!;
                          _selectedChama = itm;
                        }
                      });
                    },
                    labelText: 'Chagua Chama',
                    labelStyles: labelStyle,
                    selectedItem: _selectedChama,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  errWigFun(_errorForm),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: appStyles.defaultBorderedButtonStyles().copyWith(
                          minimumSize: const MaterialStatePropertyAll(
                              Size(double.infinity, 45))),
                      child: const Text('Rudi nyuma')),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        saveParkArea();
                      },
                      style: appStyles.defaultButtonStyles().copyWith(
                          minimumSize: const MaterialStatePropertyAll(
                              Size(double.infinity, 45))),
                      child: const Text('Endelea')),
                ],
              ),
            )
          ]),
      bottomNavigationBar: Container(
        height: 18,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
