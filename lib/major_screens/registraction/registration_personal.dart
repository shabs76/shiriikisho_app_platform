import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/select_with_search.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input_sicon.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
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
  final TextEditingController _kinNameController = TextEditingController();
  final TextEditingController _kinPhoneController = TextEditingController();
  DateTime currentDate = DateTime.now();
  String selectedDate = '';
  String _errorForm = '';
  final Map<String, String> _allSelectInputs = {};
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());

  final GlobalKey<DropdownSearchState<String>> dropdownKey = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownKeyGen = GlobalKey();

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
    List<String> selectKeys = ['gender', 'relation'];
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
    } else // validate info from the form
    if (!hasThreeNames(_kinNameController.text)) {
      setState(() {
        _errorForm =
            'Hakikisha umeweka majina yote matatu ya mtu wako wa karibu';
      });
      return 0;
    } else if (!isValidPhoneNumber(
        '+255${_kinPhoneController.text.substring(1)}')) {
      setState(() {
        _errorForm =
            'Namba ya simu sio sahihi tafadhali hakikisha. Na ujaribu tena';
      });
      return 0;
    }
    _submitDriverDetailsController.updatePersonalInfo(
        residence: _residenceController.text,
        relation: _allSelectInputs['relation']!,
        tinNumber: 'notset',
        licenceNumber: _licenseNumberController.text,
        dob: selectedDate,
        kinName: _kinNameController.text,
        kinPhone: '255${_kinPhoneController.text.substring(1)}',
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
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    final KishoStyles appStyles = KishoStyles();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taarifa Binafsi',
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
                SelectWithSearchInput(
                  borderColor: const Color(0xFFC7D3DD),
                  dropdownKey: dropdownKeyGen,
                  fillcolor: Colors.white,
                  focusedColor: Theme.of(context).colorScheme.primary,
                  itemz: const ['Mwanamume', 'Mwanamke'],
                  selecedFun: (itm) {
                    setState(() {
                      _allSelectInputs['gender'] = itm;
                    });
                  },
                  labelText: 'Chagua Jinsia',
                  labelStyles: labelStyle,
                  selectedItem: 'Chagua',
                ),
                SelectWithSearchInput(
                  borderColor: const Color(0xFFC7D3DD),
                  dropdownKey: dropdownKey,
                  fillcolor: Colors.white,
                  focusedColor: Theme.of(context).colorScheme.primary,
                  itemz: const [
                    'Sijaoa/Sijaolewa',
                    'Nimeolewa/Nimeoa',
                    "Mjane/Mgane"
                  ],
                  selecedFun: (itm) {
                    setState(() {
                      _allSelectInputs['relation'] = itm;
                    });
                  },
                  labelText: 'Mahusiano',
                  labelStyles: labelStyle,
                  selectedItem: 'Chagua',
                ),
                TextFieldWithSuIcon(
                  controller: _kinNameController,
                  borderColor: const Color(0xFFC7D3DD),
                  fillcolor: const Color(0xFFFFFFFF),
                  focusedColor: Theme.of(context).colorScheme.primary,
                  labelStyles: labelStyle,
                  labelText: 'Majina ya mtu wa karibu',
                  type: TextInputType.text,
                  hintTextz: 'John kiweli Doel',
                  maxlines: 1,
                  minLines: 1,
                  icon: Symbols.person_4_rounded,
                  icolor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
                TextFieldWithSuIcon(
                  controller: _kinPhoneController,
                  borderColor: const Color(0xFFC7D3DD),
                  fillcolor: const Color(0xFFFFFFFF),
                  focusedColor: Theme.of(context).colorScheme.primary,
                  labelStyles: labelStyle,
                  labelText: 'Simu ya mtu wa karibu',
                  type: TextInputType.phone,
                  hintTextz: '07********',
                  maxlines: 1,
                  minLines: 1,
                  icon: Symbols.call_rounded,
                  icolor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
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
