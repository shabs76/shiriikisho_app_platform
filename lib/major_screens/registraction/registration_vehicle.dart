import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/controlers/input_selects_data_list.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/micro/inputs/select_input.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class RegistrationVehicle extends StatefulWidget {
  const RegistrationVehicle({super.key});

  @override
  State<RegistrationVehicle> createState() => _RegistrationVehicleState();
}

class _RegistrationVehicleState extends State<RegistrationVehicle> {
  final TextEditingController _vehicleNumber = TextEditingController();
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  final RegistrationInputListController _registrationInputListController =
      Get.put(RegistrationInputListController());
  late List<VehiclesTypesModule> _vehiclesTypes;
  final Map<String, String> _vehicleTypeNameIdMap = {};
  String _bimaState = '';
  String _errorText = '';
  int submitVehicleTypes() {
    // validate inputs
    setState(() {
      _errorText = '';
    });
    if (!validatePlateNumber(_vehicleNumber.text)) {
      setState(() {
        _errorText = 'Namba ya chombo sio sahihi';
      });
      return 0;
    } else if (_bimaState == '' || _bimaState == 'Chagua') {
      setState(() {
        _errorText = 'Tafadhali chagua jibu sahihi kwenye bima';
      });
      return 0;
    }
    // save
    _submitDriverDetailsController.updateVehicleInfo(
        vehicleNumber: _vehicleNumber.text, insurance: _bimaState);
    Get.toNamed('/reg/cards');
    return 1;
  }

  Widget errWigFun(String erv) {
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
    _vehiclesTypes = _registrationInputListController.regiList.value.vehicles;
    _vehiclesTypes.insert(0,
        VehiclesTypesModule(vCapacity: 0, vTypeName: 'Chagua', vehicleId: ''));
    // _vehiclesTypes.map((e) {
    //   _vehicleTypeNameIdMap[e.vTypeName] = e.vehicleId;
    // });
    for (var i = 0; i < _vehiclesTypes.length; i++) {
      _vehicleTypeNameIdMap[_vehiclesTypes[i].vTypeName] =
          _vehiclesTypes[i].vehicleId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    final KishoStyles appStyles = KishoStyles();
    double nim = MediaQuery.of(context).size.height - 200;
    if (nim <= 550) {
      nim = 550;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taarifa za Chombo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
            value: 0.75,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          SizedBox(
            height: nim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      TextFieldNoIcon(
                          controller: _vehicleNumber,
                          borderColor: const Color(0xFFC7D3DD),
                          fillcolor: const Color(0xFFFFFFFF),
                          focusedColor: Theme.of(context).colorScheme.primary,
                          labelStyles: labelStyle,
                          labelText: 'Namba ya Chombo',
                          type: TextInputType.text,
                          hintTextz: 'MC xxx xxx',
                          maxlines: 1,
                          minLines: 1),
                      SelectInputNormal(
                          itemz: const ['Chagua', 'Ninayo Bima', 'Sina Bima'],
                          selecedFun: (item) {
                            setState(() {
                              if (item == 'Sina Bima') {
                                _bimaState = 'no';
                              } else if (item == 'Ninayo Bima') {
                                _bimaState = 'yes';
                              } else {
                                _bimaState = '';
                              }
                            });
                          },
                          fillcolor: const Color(0xFFFFFFFF),
                          borderColor: const Color(0xFFC7D3DD),
                          focusedColor: Theme.of(context).colorScheme.primary,
                          icon: Symbols.expand_more_rounded,
                          icolor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                          labelText: "Unabina ya Chombo?",
                          labelStyles: labelStyle),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                errWigFun(_errorText),
                SizedBox(
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: appStyles
                              .defaultBorderedButtonStyles()
                              .copyWith(
                                  minimumSize: const MaterialStatePropertyAll(
                                      Size(double.infinity, 45))),
                          child: const Text('Rudi nyuma')),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            submitVehicleTypes();
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
