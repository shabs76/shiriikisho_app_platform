import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/apis/get_apis.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/driver_info_controllers.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/image_uploads/image_upload_screen.dart';
import 'package:shirikisho_drivers/micro/inputs/select_with_search.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input_sicon.dart';
import 'package:shirikisho_drivers/micro/special/picture_form_displayor.dart';
import 'package:shirikisho_drivers/micro/special/picture_selector_card.dart';
import 'package:shirikisho_drivers/micro/special/piture_form_update_displayor.dart';
import 'package:shirikisho_drivers/micro/special/tiny_widgets_fun.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/drivers_modules.dart';
import 'package:shirikisho_drivers/module/normal_modules.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';
import 'package:shirikisho_drivers/special/special_fun.dart';

class UserUpdateMain extends StatefulWidget {
  const UserUpdateMain({super.key});

  @override
  State<UserUpdateMain> createState() => _UserUpdateMainState();
}

class _UserUpdateMainState extends State<UserUpdateMain> {
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();
  final TextEditingController _vehicleNumber = TextEditingController();
  final TextEditingController _idNumber = TextEditingController();
  final TextEditingController _kinNameController = TextEditingController();
  final TextEditingController _kinPhoneController = TextEditingController();

  final DriverIDOnUpdateInfoController _driverIDOnUpdateInfoController =
      Get.put(DriverIDOnUpdateInfoController());

  late Future<List<FullDriverDetailsModule>> _driversDetails;
  late List<ChamaModule> _chamaz;
  List<ChamaModule> _chamazc = [];

  final TinyComponents _tinyComponents = TinyComponents();

  XFile? _pickedImage;
  String? _fIdPath;
  XFile? _pickedPasImage;
  bool _multiPassImage = false;
  bool _multiIDImage = false;
  bool _afterruns = false;
  String? _fPassPath;
  String _typeOfId = '';
  bool _loading = false;
  final KishoStyles appStyles = KishoStyles();

  final GlobalKey<DropdownSearchState<String>> dropdownKey = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownKeyGen = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownKeyBima = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownKeyChama = GlobalKey();
  final GlobalKey<DropdownSearchState<String>> dropdownKeyID = GlobalKey();
  DateTime currentDate = DateTime.now();
  String selectedDate = '';
  String _errorForm = '';
  String _upChama = '';
  String _selectedChama = 'Chama';
  final Map<String, String> _chamaNameID = {};

  final Map<String, String> _allSelectInputs = {};
  final PostMainApis _postMainApis = PostMainApis();
  final GetApisClass _apisClass = GetApisClass();

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

  String transformDateFormat(String dateString) {
    // Split the original date string using 'T' as delimiter
    List<String> parts = dateString.split('T');

    // The date part is in the first part of the split
    String datePart = parts[0];

    return datePart;
  }

  Future<void> _pickingImage(String title, String imageName) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null && imageName == 'id') {
      setState(() {
        _pickedImage = pickedImage;
      });
      Get.to(() => ImageUploadScreen(
          backFun: () {},
          cropFunction: () {
            Get.back();
            _croppingImage(title, imageName, pickedImage.path);
          },
          doneFunction: () {
            Get.back();
            setState(() {
              _fIdPath = _pickedImage!.path;
            });
          },
          imagePath: _pickedImage!.path,
          titles: title));
    } else if (pickedImage != null && imageName == 'pass') {
      setState(() {
        _pickedPasImage = pickedImage;
      });
      Get.to(() => ImageUploadScreen(
          backFun: () {},
          cropFunction: () {
            Get.back();
            _croppingImage(title, imageName, pickedImage.path);
          },
          doneFunction: () {
            Get.back();
            setState(() {
              _fPassPath = _pickedPasImage!.path;
            });
          },
          imagePath: _pickedPasImage!.path,
          titles: title));
    }
  }

  Future<void> _capturingImage(String title, String imageName) async {
    final campTuredImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (campTuredImage != null && imageName == 'id') {
      setState(() {
        _pickedImage = campTuredImage;
      });
      Get.to(() => ImageUploadScreen(
          backFun: () {},
          cropFunction: () {
            Get.back();
            _croppingImage(title, imageName, campTuredImage.path);
          },
          doneFunction: () {
            Get.back();
            setState(() {
              _fIdPath = _pickedImage!.path;
            });
          },
          imagePath: _pickedImage!.path,
          titles: title));
    } else if (campTuredImage != null && imageName == 'pass') {
      setState(() {
        _pickedPasImage = campTuredImage;
      });
      Get.to(() => ImageUploadScreen(
          backFun: () {},
          cropFunction: () {
            Get.back();
            _croppingImage(title, imageName, campTuredImage.path);
          },
          doneFunction: () {
            Get.back();
            setState(() {
              _fPassPath = _pickedPasImage!.path;
            });
          },
          imagePath: _pickedPasImage!.path,
          titles: title));
    }
  }

  Future<void> _croppingImage(
      String title, String imageName, String flpath) async {
    final croppedFIle = await ImageCropper().cropImage(
      sourcePath: flpath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: const Color(0xFF24B42E),
            toolbarWidgetColor: Colors.white38,
            initAspectRatio: imageName == 'pass'
                ? CropAspectRatioPreset.square
                : CropAspectRatioPreset.original,
            lockAspectRatio: imageName == 'pass'),
        IOSUiSettings(
          title: title,
        ),
        WebUiSettings(
          context: context,
          presentStyle: CropperPresentStyle.dialog,
          boundary: const CroppieBoundary(
            width: 520,
            height: 520,
          ),
          viewPort:
              const CroppieViewPort(width: 480, height: 480, type: 'circle'),
          enableExif: true,
          enableZoom: true,
          showZoomer: true,
        ),
      ],
    );
    if (croppedFIle != null && imageName == 'id') {
      setState(() {
        _fIdPath = croppedFIle.path;
      });
    } else if (croppedFIle != null && imageName == 'pass') {
      setState(() {
        _fPassPath = croppedFIle.path;
      });
    }
  }

  Widget _idSelectorDisplayor({required String imagPath}) {
    if (_fIdPath != null) {
      return PictureFormDisplayor(
          cardHead: 'Picha ya Kitambulisho',
          imagePath: _fIdPath!,
          nameDis: "Kataa picha",
          reTakeFun: () {
            setState(() {
              _pickedImage = null;
              _fIdPath = null;
              _multiIDImage = false;
            });
          });
    } else if (_multiIDImage) {
      return PictureSelectorCard(
          camFun: () {
            _capturingImage('Picha ya Kitambulisho', 'id');
          },
          cardExplain:
              'Piga picha au pakia picha ya kitambulisho ulichojaza hapo juu',
          cardHead: 'Picha ya Kitambulisho',
          cardformat: 'png, jpg, webp, 24mb',
          garFun: () {
            _pickingImage('Picha ya Kitambulisho', 'id');
          });
    }

    return PictureFormDisplayorUpdate(
        cardHead: "Picha ya Kitambulisho",
        imagePath: imagPath,
        nameDis: "Badilisha Picha",
        reTakeFun: () {
          setState(() {
            _pickedPasImage = null;
            _fPassPath = null;
            _multiIDImage = true;
          });
        });
  }

  Widget _passSelectorDisplayor({required String imagPath}) {
    if (_fPassPath != null) {
      return PictureFormDisplayor(
          cardHead: 'Picha ya pasipoti',
          imagePath: _fPassPath!,
          nameDis: "Kataa picha",
          reTakeFun: () {
            setState(() {
              _pickedPasImage = null;
              _fPassPath = null;
              _multiPassImage = false;
            });
          });
    } else if (_multiPassImage) {
      return PictureSelectorCard(
          camFun: () {
            _capturingImage('Picha ya pasipoti', 'pass');
          },
          cardExplain:
              'Piga picha au pakia kopi ya picha yako ya pasipoti size',
          cardHead: 'Pakia picha ya pasipoti',
          cardformat: 'png, jpg, webp, 24mb',
          garFun: () {
            _pickingImage('Picha ya pasipoti', 'pass');
          });
    }

    return PictureFormDisplayorUpdate(
        cardHead: "Picha ya pasipoti",
        imagePath: imagPath,
        nameDis: "Badilisha Picha",
        reTakeFun: () {
          setState(() {
            _pickedPasImage = null;
            _fPassPath = null;
            _multiPassImage = true;
          });
        });
  }

  Widget _idNNumbeWigetCollection(
      {required String preTypeId, required String imagePath}) {
    if (_allSelectInputs['typeId'] == 'Sina' ||
        (preTypeId == 'Sina' && _typeOfId == '')) {
      return const SizedBox();
    }
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    return Column(
      children: [
        TextFieldNoIcon(
            controller: _idNumber,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Namba ya Kitambulisho',
            type: TextInputType.text,
            hintTextz: 'xxxxxxxxxx',
            maxlines: 1,
            minLines: 1),
        _idSelectorDisplayor(imagPath: imagePath),
      ],
    );
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

  Widget btnNLoader(bool lder, BuildContext context) {
    if (lder) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      );
    }
    return ElevatedButton(
        onPressed: () {
          _sendUpateDetailsMid();
        },
        style: appStyles.defaultButtonStyles().copyWith(
            minimumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 45))),
        child: const Text('Tuma Taarifa'));
  }

  Widget chamaSelector(
      {required List<ChamaModule> chmz, required TextStyle labelStyle}) {
    if (chmz.isEmpty) {
      return const SizedBox();
    }
    return SelectWithSearchInput(
      borderColor: const Color(0xFFC7D3DD),
      dropdownKey: dropdownKeyChama,
      fillcolor: Colors.white,
      focusedColor: Theme.of(context).colorScheme.primary,
      itemz: _chamaz.map((e) => e.chamaName).toList(),
      selecedFun: (itm) {
        setState(() {
          if (_chamaNameID.containsKey(itm)) {
            _upChama = _chamaNameID[itm]!;
          }
        });
      },
      labelText: 'Jina la Chama',
      labelStyles: labelStyle,
      selectedItem: _selectedChama,
    );
  }

  Future<int> _sendUpateDetailsMid() async {
    if (!hasThreeNames(_fnameController.text)) {
      setState(() {
        _errorForm = 'Hakikisha umeweka majina yote matatu';
      });
      return 0;
    } else if (!isValidEmail(_emailController.text) &&
        _emailController.text.replaceAll(' ', '') != '') {
      setState(() {
        _errorForm = 'Barua pepe uliyoweka sio sahihi. Kama hauna usijaze';
      });
      return 0;
    } else if (_residenceController.text.length < 3) {
      setState(() {
        _errorForm = 'Tafadhali jaza makazi yako kwa usahihi';
      });
      return 0;
    } else if (_licenseNumberController.text.length < 7) {
      setState(() {
        _errorForm = 'Tafadhali hakikisha namba ya leseni yako ipo sahihi';
      });
      return 0;
    } else if (!validatePlateNumber(_vehicleNumber.text)) {
      setState(() {
        _errorForm = 'Namba ya chombo sio sahihi';
      });
      return 0;
    } else if (!_allSelectInputs.containsKey('gender') ||
        _allSelectInputs['gender']!.length < 3 ||
        _allSelectInputs['gender'] == 'Chagua') {
      setState(() {
        _errorForm = 'Tafadhali hakikisha jinsia yako kwa usahihi';
      });
      return 0;
    } else if (!_allSelectInputs.containsKey('relation') ||
        _allSelectInputs['relation']!.length < 3 ||
        _allSelectInputs['relation'] == 'Chagua') {
      setState(() {
        _errorForm = 'Tafadhali hakikisha umechagua mahusiano yako';
      });
      return 0;
    } else if (!_allSelectInputs.containsKey('bima') ||
        _allSelectInputs['bima']!.length < 2 ||
        _allSelectInputs['bima'] == 'Chagua') {
      setState(() {
        _errorForm = 'Tafadhali hakikisha umechagua bima';
      });
      return 0;
    } else if (!_allSelectInputs.containsKey('typeId') ||
        _allSelectInputs['typeId']!.length < 3 ||
        _allSelectInputs['typeId'] == 'Chagua') {
      setState(() {
        _errorForm = 'Tafadhali hakikisha umechagua aina ya kitambulisho';
      });
      return 0;
    } else if (_upChama == '') {
      setState(() {
        _errorForm = 'Tafadhali hakikisha umefanya uchaguzi sahihi wa chama';
      });
      return 0;
    } else if (!hasThreeNames(_kinNameController.text)) {
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

    if (selectedDate != '' && isDateString(selectedDate)) {
      _allSelectInputs['dob'] = selectedDate;
    }
    // check uploading mode
    setState(() {
      _errorForm = '';
      _loading = true;
    });
    if (_allSelectInputs['typeId'] == 'Sina' &&
        _fPassPath != null &&
        _fPassPath != '') {
      // set other thing as 'notset' and check if passport piture
      var flx = File(_fPassPath!);
      if (!flx.existsSync()) {
        setState(() {
          _errorForm =
              'Tatizo limejoteza kwenye picha ya pasipoti tafadhali rudia kuchukua picha hio.';
          _loading = false;
        });
        return 0;
      }
      // sending passport to the media server
      ImageUploadResponseModule ansImg = await _postMainApis.uploadingImageFun(
          logSess: _submitDriverDetailsController.subData.value.verid,
          logKey: _submitDriverDetailsController.subData.value.verid,
          keyType: 'registration',
          purpose: 'passport',
          imagePath: _fPassPath!);
      if (ansImg.state != 'success') {
        setState(() {
          _errorForm = ansImg.info;
          _loading = false;
        });
        return 0;
      }
      // saving all details into state
      _allSelectInputs['passport'] = ansImg.imageId;
      _allSelectInputs['id_picture'] = 'notset';
      _allSelectInputs['idNumber'] = 'notset';
      // call data submit function
      int rs = await _fdataValidationNSender();
      return rs;
    } else if (_fIdPath != null &&
        _fIdPath != '' &&
        _fPassPath != null &&
        _fPassPath != '' &&
        _allSelectInputs['typeId'] != 'Sina') {
      var flix = File(_fIdPath!);
      if (!flix.existsSync()) {
        setState(() {
          _errorForm =
              'Tatizo kwenye picha ya kitambulisho. Tafadhali rudia kuchua picha hio';
          _loading = false;
        });
        return 0;
      }

      flix = File(_fPassPath!);
      if (!flix.existsSync()) {
        setState(() {
          _errorForm =
              'Tatizo kwenye picha ya pasipoti. Tafadhali rudia kuchua picha hio';
          _loading = false;
        });
        return 0;
      }
      // check for id number if is set
      if (_idNumber.text == '' || _idNumber.text.length < 5) {
        setState(() {
          _errorForm = 'Tafadhali hakikisha number ya kitambulisho chako';
          _loading = false;
        });
        return 0;
      }
      // now start uploading images
      ImageUploadResponseModule ansImg = await _postMainApis.uploadingImageFun(
          logSess: _submitDriverDetailsController.subData.value.verid,
          logKey: _submitDriverDetailsController.subData.value.verid,
          keyType: 'registration',
          purpose: 'passport',
          imagePath: _fPassPath!);
      if (ansImg.state != 'success') {
        setState(() {
          _errorForm = ansImg.info;
          _loading = false;
        });
        return 0;
      }
      ImageUploadResponseModule ans2Img = await _postMainApis.uploadingImageFun(
          logSess: _submitDriverDetailsController.subData.value.verid,
          logKey: _submitDriverDetailsController.subData.value.verid,
          keyType: 'registration',
          purpose: 'id',
          imagePath: _fIdPath!);
      if (ans2Img.state != 'success') {
        setState(() {
          _errorForm = ans2Img.info;
          _loading = false;
        });
        return 0;
      }
      // saving all details into state
      _allSelectInputs['passport'] = ansImg.imageId;
      _allSelectInputs['id_picture'] = ans2Img.imageId;
      _allSelectInputs['idNumber'] = _idNumber.text;
      // call data submit function
      int rs = await _fdataValidationNSender();
      return rs;
    } else if (_fIdPath != null &&
        _fIdPath != '' &&
        _allSelectInputs['typeId'] != 'Sina') {
      var flix = File(_fIdPath!);
      if (!flix.existsSync()) {
        setState(() {
          _errorForm =
              'Tatizo kwenye picha ya kitambulisho. Tafadhali rudia kuchua picha hio';
          _loading = false;
        });
        return 0;
      }
      _allSelectInputs['idNumber'] = _idNumber.text;
      if (!_allSelectInputs.containsKey('idNumber') ||
          _allSelectInputs['idNumber']!.length < 6) {
        setState(() {
          _errorForm = 'Tafadhali hakikisha namba ya kitambulisho chako';
          _loading = false;
        });
        return 0;
      }
      ImageUploadResponseModule ans2Img = await _postMainApis.uploadingImageFun(
          logSess: _submitDriverDetailsController.subData.value.verid,
          logKey: _submitDriverDetailsController.subData.value.verid,
          keyType: 'registration',
          purpose: 'id',
          imagePath: _fIdPath!);
      if (ans2Img.state != 'success') {
        setState(() {
          _errorForm = ans2Img.info;
          _loading = false;
        });
        return 0;
      }
      _allSelectInputs['id_picture'] = ans2Img.imageId;

      int rs = await _fdataValidationNSender();
      return rs;
    }
    _allSelectInputs['idNumber'] = _idNumber.text;
    if (_allSelectInputs['typeId'] == 'Sina') {
      _allSelectInputs['idNumber'] = 'notset';
    } else if (!_allSelectInputs.containsKey('idNumber') ||
        _allSelectInputs['idNumber']!.length < 6) {
      setState(() {
        _errorForm = 'Tafadhali hakikisha namba ya kitambulisho chako';
        _loading = false;
      });
      return 0;
    }
    int rs = await _fdataValidationNSender();
    return rs;
  }

  Future<int> _fdataValidationNSender() async {
    List<String> names = extractThreeNames(_fnameController.text);
    if (names.length < 3) {
      setState(() {
        _errorForm = 'Hakikisha umeweka majina matatu';
        _loading = false;
      });
      return 0;
    }

    final Map<String, dynamic> sendData = {
      "driver_id": _allSelectInputs['driverId'],
      "fname": names[0],
      "mname": names[1],
      "lname": names[2],
      "email": _emailController.text != ''
          ? _emailController.text
          : 'no@example.com',
      "dob": _allSelectInputs['dob'],
      "gender": _allSelectInputs['gender'],
      "relation": _allSelectInputs['relation'],
      "residence": _residenceController.text,
      "park_area": _allSelectInputs['park_area'],
      "vehicle_number": _vehicleNumber.text,
      "licence_number": _licenseNumberController.text,
      "id_type": _allSelectInputs['typeId'],
      "id_picture": _allSelectInputs['typeId'] == 'Sina'
          ? 'notset'
          : _allSelectInputs['id_picture'],
      "passport": _allSelectInputs['passport'],
      "id_number": _allSelectInputs['idNumber'],
      "insurance": _allSelectInputs['bima'],
      "kin_phone": _kinPhoneController.text,
      "kin_name": _kinNameController.text,
      "chama": _upChama,
    };

    StateDataModule ansDet =
        await _postMainApis.sendUpdateDetails(updDets: sendData);

    if (ansDet.state != 'success') {
      _tinyComponents.popupWithInfo(
          heading: "Makosa",
          nDescreption: ansDet.data,
          icon: Symbols.close,
          closeFun: () {
            Get.back();
          },
          okayFun: () {
            Get.back();
          });
      setState(() {
        _errorForm = ansDet.data;
        _loading = false;
      });
      return 0;
    }

    _tinyComponents.popupWithInfo(
        heading: "Imefakikiwa",
        nDescreption: ansDet.data,
        icon: Symbols.done_all_rounded,
        closeFun: () {
          Get.back();
          Get.toNamed('/sign');
        },
        okayFun: () {
          Get.back();
          Get.toNamed('/sign');
        });
    return 1;
  }

  void _waitingChamaz() async {
    _chamaz = await _apisClass.fetchChamaList();
    setState(() {
      _chamazc = _chamaz;
    });
    if (_chamaz.isNotEmpty) {
      /// build a map
      for (var i = 0; i < _chamaz.length; i++) {
        _chamaNameID[_chamaz[i].chamaName] = _chamaz[i].chamaId;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _waitingChamaz();
    _driversDetails = _postMainApis.fetchUpdateDriverDetails(
        _driverIDOnUpdateInfoController.driverIdOnUpdate.value.driverId);
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: _driversDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FullDriverDetailsModule userDat = snapshot.data![0];
              return updateList(context, labelStyle, userDat);
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
                        style: appStyles.defaultButtonStyles(),
                        child: const Text('Sawa'))
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      bottomNavigationBar: Container(
        height: 18,
        decoration: const BoxDecoration(color: Colors.white),
      ),
    );
  }

  ListView updateList(BuildContext context, TextStyle labelStyle,
      FullDriverDetailsModule userDet) {
    // update all controllers here
    if (!_afterruns) {
      _fnameController.text =
          '${userDet.fname} ${userDet.mname} ${userDet.lname}';
      _emailController.text = userDet.email;
      _residenceController.text = userDet.residence;
      _licenseNumberController.text = userDet.licenceNumber;
      _vehicleNumber.text = userDet.vehicleNumber;
      if (userDet.idNumber != 'notset') {
        _idNumber.text = userDet.idNumber;
      }

      if (userDet.kinName != 'notset') {
        _kinNameController.text = userDet.kinName;
      }
      if (userDet.kinPhone != 'notset') {
        _kinPhoneController.text = userDet.kinPhone;
      }
      //chamas
      _upChama = userDet.chama;
      if (_chamaNameID.containsValue(_upChama)) {
        for (var i = 0; i < _chamazc.length; i++) {
          if (_chamazc[i].chamaId == _upChama) {
            _selectedChama = _chamazc[i].chamaName;
          }
        }
      }
      // maps fills
      _allSelectInputs['gender'] = userDet.gender;
      _allSelectInputs['relation'] = userDet.relationship;
      _allSelectInputs['bima'] = userDet.insurance;
      _allSelectInputs['typeId'] = userDet.idType;
      _allSelectInputs['driverId'] = userDet.driverId;
      _allSelectInputs['dob'] = transformDateFormat(userDet.dob);
      _allSelectInputs['park_area'] = userDet.parkArea;

      _allSelectInputs['passport'] = userDet.passport;
      _allSelectInputs['id_picture'] = userDet.idPicture;
      _afterruns = true;
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Sahihisha Taarifa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        TextFieldNoIcon(
            controller: _fnameController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Jina Kamili',
            type: TextInputType.text,
            hintTextz: 'Joshua Nzega Mlacha',
            maxlines: 1,
            minLines: 1),
        TextFieldNoIcon(
            controller: _emailController,
            borderColor: const Color(0xFFC7D3DD),
            fillcolor: const Color(0xFFFFFFFF),
            focusedColor: Theme.of(context).colorScheme.primary,
            labelStyles: labelStyle,
            labelText: 'Barua Pepe',
            type: TextInputType.emailAddress,
            hintTextz: 'JoshuaN88@gmail.com (sio lazima)',
            maxlines: 1,
            minLines: 1),
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
                    EdgeInsets.only(left: 10, right: 10)),
                foregroundColor:
                    const MaterialStatePropertyAll(Color(0xFF313131)),
                textStyle: const MaterialStatePropertyAll(
                    TextStyle(fontWeight: FontWeight.w500)),
                maximumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 45)),
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 45)),
                side: const MaterialStatePropertyAll(
                    BorderSide(color: Color(0xFFC7D3DD)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == ''
                      ? transformDateFormat(userDet.dob)
                      : selectedDate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(Symbols.calendar_month_rounded)
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
          selectedItem: _allSelectInputs['gender']!,
        ),
        SelectWithSearchInput(
          borderColor: const Color(0xFFC7D3DD),
          dropdownKey: dropdownKey,
          fillcolor: Colors.white,
          focusedColor: Theme.of(context).colorScheme.primary,
          itemz: const ['Sijaoa/Sijaolewa', 'Nimeolewa/Nimeoa', "Mjane/Mgane"],
          selecedFun: (itm) {
            setState(() {
              _allSelectInputs['relation'] = itm;
            });
          },
          labelText: 'Mahusiano',
          labelStyles: labelStyle,
          selectedItem: _allSelectInputs['relation']!,
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
          icolor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
          icolor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
          icolor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
        chamaSelector(chmz: _chamaz, labelStyle: labelStyle),
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
          icolor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
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
        SelectWithSearchInput(
          borderColor: const Color(0xFFC7D3DD),
          dropdownKey: dropdownKeyBima,
          fillcolor: Colors.white,
          focusedColor: Theme.of(context).colorScheme.primary,
          itemz: const ['Ninayo Bima', 'Sina Bima'],
          selecedFun: (itm) {
            setState(() {
              if (itm == 'Sina Bima') {
                _allSelectInputs['bima'] = 'no';
              } else {
                _allSelectInputs['bima'] = 'yes';
              }
            });
          },
          labelText: 'Unabima ya Chombo?',
          labelStyles: labelStyle,
          selectedItem: _allSelectInputs['bima'] == 'yes' ||
                  _allSelectInputs['bima'] == 'Yes'
              ? 'Ninayo Bima'
              : 'Sina Bima',
        ),
        SelectWithSearchInput(
          borderColor: const Color(0xFFC7D3DD),
          dropdownKey: dropdownKeyID,
          fillcolor: Colors.white,
          focusedColor: Theme.of(context).colorScheme.primary,
          itemz: const ['Sina', 'NIDA', 'Kura', 'Leseni'],
          selecedFun: (itm) {
            setState(() {
              _allSelectInputs['typeId'] = itm;
              _typeOfId = itm;
            });
          },
          labelText: 'Aina ya kitambulisho',
          labelStyles: labelStyle,
          selectedItem: _allSelectInputs['typeId']!,
        ),
        _idNNumbeWigetCollection(
            preTypeId: userDet.idType, imagePath: userDet.idPicture),
        const SizedBox(
          height: 20,
        ),
        _passSelectorDisplayor(imagPath: userDet.passport),
        const SizedBox(
          height: 30,
        ),
        errWigFun(_errorForm),
        SizedBox(
          child: Column(
            children: [
              btnNLoader(_loading, context),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
