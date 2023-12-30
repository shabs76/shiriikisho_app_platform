import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/controlers/input_selects_data_list.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/select_input.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input_sicon.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class RegistrationPersonal extends StatefulWidget {
  const RegistrationPersonal({super.key});

  @override
  State<RegistrationPersonal> createState() => _RegistrationPersonalState();
}

class _RegistrationPersonalState extends State<RegistrationPersonal> {
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final RegistrationInputListController registrationInputListController =
      Get.put(RegistrationInputListController());
  late List<ParkAreaModule> _parks;
  final Map<String, String> _parkNameIdMap = {};
  DateTime currentDate = DateTime.now();
  String selectedDate = '';
  String _errorForm = '';
  final Map<String, String> _allSelectInputs = {};
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate.subtract(const Duration(days: 18 * 365)),
        firstDate: currentDate.subtract(const Duration(days: 100 * 365)),
        lastDate: currentDate.subtract(const Duration(days: 18 * 365)));
    if (picked != null && picked != currentDate) {
      setState(() {
        selectedDate = formatDate(picked);
      });
    }
  }

  String formatDate(DateTime dateTime) {
    return '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }

  int saveInfoPernalInfo() {
    // check if date is selected
    setState(() {
      _errorForm = '';
    });
    List<String> selectKeys = ['gender', 'parkArea', 'relation'];
    if (selectedDate == '') {
      setState(() {
        _errorForm = 'Tafadhali changua tarehe ya kuzaliwa';
      });
      return 0;
    } else if (!checkSelectedInputsFun(_allSelectInputs, selectKeys)) {
      setState(() {
        _errorForm = 'Hikisha umejaza kila sehemu';
      });
      return 0;
    } else if (_licenseNumberController.text.length < 7) {
      setState(() {
        _errorForm = 'Tafadhali jaza number leseni';
      });
      return 0;
    } else if (_residenceController.text.length < 3) {
      setState(() {
        _errorForm = 'Tafadhali jaza makazi yako kwa usahihi';
      });
      return 0;
    }
    _submitDriverDetailsController.updatePersonalInfo(
        residence: _residenceController.text,
        relation: _allSelectInputs['relation']!,
        tinNumber: 'notset',
        licenceNumber: _licenseNumberController.text,
        parkArea: _allSelectInputs['parkArea']!,
        dob: selectedDate,
        gender: _allSelectInputs['gender']!);
    Get.toNamed('/reg/vehicle');
    return 1;
  }

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

  @override
  void initState() {
    super.initState();
    _parks = registrationInputListController.regiList.value.park;
    _parks.insert(
        0, ParkAreaModule(parkId: '', parkName: 'Chagua', parkSize: 0));
    for (var i = 0; i < _parks.length; i++) {
      _parkNameIdMap[_parks[i].parkName] = _parks[i].parkId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    final KishoStyles appStyles = KishoStyles();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taarifa Binafsi & Chama',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
            value: 0.50,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        children: [
          SizedBox(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Tarehe ya Kuzaliwa',
                    style: labelStyle.copyWith(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: appStyles.defaultBorderedButtonStyles().copyWith(
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.only(left: 10)),
                        foregroundColor:
                            const MaterialStatePropertyAll(Color(0xFF313131)),
                        textStyle: const MaterialStatePropertyAll(
                            TextStyle(fontWeight: FontWeight.w500)),
                        maximumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 40)),
                        minimumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 40)),
                        side: const MaterialStatePropertyAll(
                            BorderSide(color: Color(0xFFC7D3DD)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == '' ? 'Chagua' : selectedDate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Icon(Symbols.expand_more_rounded)
                      ],
                    )),
                SelectInputNormal(
                    itemz: const ['Chagua', 'Mwanamume', 'Mwanamke'],
                    selecedFun: (item) {
                      setState(() {
                        _allSelectInputs['gender'] = item;
                      });
                    },
                    fillcolor: const Color(0xFFFFFFFF),
                    borderColor: const Color(0xFFC7D3DD),
                    focusedColor: Theme.of(context).colorScheme.primary,
                    icon: Symbols.expand_more_rounded,
                    icolor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "Chagua Jinsia",
                    labelStyles: labelStyle),
                SelectInputNormal(
                    itemz: const [
                      'Chagua',
                      'Sijao/Sijaolewa',
                      'Nimeolewa/Nimeoa',
                      "Mjane"
                    ],
                    selecedFun: (item) {
                      setState(() {
                        _allSelectInputs['relation'] = item;
                      });
                    },
                    fillcolor: const Color(0xFFFFFFFF),
                    borderColor: const Color(0xFFC7D3DD),
                    focusedColor: Theme.of(context).colorScheme.primary,
                    icon: Symbols.expand_more_rounded,
                    icolor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "Mahusiano",
                    labelStyles: labelStyle),
                TextFieldWithSuIcon(
                  controller: _residenceController,
                  borderColor: const Color(0xFFC7D3DD),
                  fillcolor: const Color(0xFFFFFFFF),
                  focusedColor: Theme.of(context).colorScheme.primary,
                  labelStyles: labelStyle,
                  labelText: 'Makazi',
                  type: TextInputType.text,
                  hintTextz: 'Tangi bovu, Mbezi beach',
                  maxlines: 1,
                  minLines: 1,
                  icon: Symbols.location_on_rounded,
                  icolor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
                TextFieldWithSuIcon(
                  controller: _licenseNumberController,
                  borderColor: const Color(0xFFC7D3DD),
                  fillcolor: const Color(0xFFFFFFFF),
                  focusedColor: Theme.of(context).colorScheme.primary,
                  labelStyles: labelStyle,
                  labelText: 'Namba ya Leseni',
                  type: TextInputType.number,
                  hintTextz: 'xxxxxxxxxxxxxxxx',
                  maxlines: 1,
                  minLines: 1,
                  icon: Symbols.license,
                  icolor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
                SelectInputNormal(
                    itemz: _parks.map((parks) => parks.parkName).toList(),
                    selecedFun: (item) {
                      setState(() {
                        // check if selected item has value in the parks map
                        if (_parkNameIdMap.containsKey(item)) {
                          _allSelectInputs['parkArea'] =
                              _parkNameIdMap[item].toString();
                        } else {
                          _allSelectInputs['parkArea'] = '';
                        }
                      });
                    },
                    fillcolor: const Color(0xFFFFFFFF),
                    borderColor: const Color(0xFFC7D3DD),
                    focusedColor: Theme.of(context).colorScheme.primary,
                    icon: Symbols.expand_more_rounded,
                    icolor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                    labelText: "Chagua Kituo",
                    labelStyles: labelStyle),
                const SizedBox(
                  height: 10,
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
                      saveInfoPernalInfo();
                    },
                    style: appStyles.defaultButtonStyles().copyWith(
                        minimumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 45))),
                    child: const Text('Endelea')),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 18,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }
}
