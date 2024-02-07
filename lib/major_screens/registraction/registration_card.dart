import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shirikisho_drivers/apis/post_apis.dart';
import 'package:shirikisho_drivers/controlers/registration_info_controllers.dart';
import 'package:shirikisho_drivers/major_screens/image_uploads/image_upload_screen.dart';
import 'package:shirikisho_drivers/micro/inputs/select_with_search.dart';
import 'package:shirikisho_drivers/micro/inputs/text_input.dart';
import 'package:shirikisho_drivers/micro/special/picture_form_displayor.dart';
import 'package:shirikisho_drivers/micro/special/picture_selector_card.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/module/registration_modules.dart';

class RegistrationCards extends StatefulWidget {
  const RegistrationCards({super.key});

  @override
  State<RegistrationCards> createState() => _RegistrationCardsState();
}

class _RegistrationCardsState extends State<RegistrationCards> {
  final GlobalKey<DropdownSearchState<String>> dropdownCardType = GlobalKey();
  XFile? _pickedImage;
  String? _fIdPath;

  XFile? _pickedPasImage;
  String? _fPassPath;

  String _typeOfId = '';
  String _errorForm = '';
  bool _loading = false;
  final KishoStyles appStyles = KishoStyles();
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

  Widget _idSelectorDisplayor() {
    if (_fIdPath != null) {
      return PictureFormDisplayor(
          cardHead: 'Picha ya Kitambulisho',
          imagePath: _fIdPath!,
          reTakeFun: () {
            setState(() {
              _pickedImage = null;
              _fIdPath = null;
            });
          });
    }
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

  Widget _passSelectorDisplayor() {
    if (_fPassPath != null) {
      return PictureFormDisplayor(
          cardHead: 'Picha ya pasipoti',
          imagePath: _fPassPath!,
          reTakeFun: () {
            setState(() {
              _pickedPasImage = null;
              _fPassPath = null;
            });
          });
    }

    return PictureSelectorCard(
        camFun: () {
          _capturingImage('Picha ya pasipoti', 'pass');
        },
        cardExplain: 'Piga picha au pakia kopi ya picha yako ya pasipoti size',
        cardHead: 'Pakia picha ya pasipoti',
        cardformat: 'png, jpg, webp, 24mb',
        garFun: () {
          _pickingImage('Picha ya pasipoti', 'pass');
        });
  }

  Widget _idNNumbeWigetCollection() {
    if (_typeOfId == 'Sina') {
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
        _idSelectorDisplayor(),
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
          _sendDriverDetails();
        },
        style: appStyles.defaultButtonStyles().copyWith(
            minimumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 45))),
        child: const Text('Maliza'));
  }

  Future<int> _sendDriverDetails() async {
    // check uploading mode
    setState(() {
      _errorForm = '';
      _loading = true;
    });
    if (_typeOfId == 'Sina') {
      // set other thing as 'notset' and check if passport piture
      if (_fPassPath == null || _fPassPath == '') {
        setState(() {
          _errorForm = 'Hakikicha umechagua picha ya pasipoti';
          _loading = false;
        });
        return 0;
      }
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
      _submitDriverDetailsController.updateCardsDetailsInfo(
          idType: _typeOfId,
          idPicture: 'notset',
          idNumber: 'notset',
          passport: ansImg.imageId);
      // call data submit function
      int rs = await _fdataValidationNSender();
      return rs;
    } else if (_typeOfId == 'Chagua' || _typeOfId == '') {
      setState(() {
        _errorForm = 'Tafadhali changua aina ya kitambulisho.';
        _loading = false;
      });
      return 0;
    }
    // check for all images and id number
    if (_fIdPath == null || _fIdPath == '') {
      setState(() {
        _errorForm = 'Tafadhali piga picha ya kitambulisho chako';
        _loading = false;
      });
      return 0;
    }
    var flix = File(_fIdPath!);
    if (!flix.existsSync()) {
      setState(() {
        _errorForm =
            'Tatizo kwenye picha ya kitambulisho. Tafadhali rudia kuchua picha hio';
        _loading = false;
      });
      return 0;
    }

    if (_fPassPath == null || _fPassPath == '') {
      setState(() {
        _errorForm = 'Tafadhali piga picha ya pasipoti';
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
    _submitDriverDetailsController.updateCardsDetailsInfo(
        idType: _typeOfId,
        idPicture: ans2Img.imageId,
        idNumber: _idNumber.text,
        passport: ansImg.imageId);
    // call data submit function
    int rs = await _fdataValidationNSender();
    return rs;
  }

  Future<int> _fdataValidationNSender() async {
    // stage data chacker
    if (_submitDriverDetailsController.subData.value.phone == '') {
      setState(() {
        _errorForm =
            'Taarifa zako za kimawasiliano hazipo. Tafadhali anza tena mwazo kuzi weka.';
        _loading = false;
      });
      return 0;
    } else if (_submitDriverDetailsController.subData.value.verid == '') {
      setState(() {
        _errorForm =
            'Uhakiki wa namba yako ya simu unakosekana tafadhali anza mwanzo tena kwenye mchakato huu.';
        _loading = false;
      });
      return 0;
    } else if (_submitDriverDetailsController.subData.value.dob == '') {
      setState(() {
        _errorForm =
            'Taarifa zako binafsi zinakosekana tafadhali rudi mpaka sehemu ya kuweka taarifa zako binafsi, nauweke tena';
        _loading = false;
      });
      return 0;
    } else if (_submitDriverDetailsController.subData.value.vehicleNumber ==
        '') {
      setState(() {
        _errorForm =
            'Taarifa zako chombo unachoendesha hazipo, tafadhali rudi nyuma mpaka kwenye sehemu ya kuweka taarifa za chombo';
        _loading = false;
      });
      return 0;
    } else if (_submitDriverDetailsController.subData.value.passport == '') {
      setState(() {
        _errorForm =
            'Taarifa zaida zinakosekana tafadhali chuguza ulivyozaja taarifa hizo na ujaribu tena.';
        _loading = false;
      });
      return 0;
    }
    DriversRegresponseModule drAns = await _postMainApis.sendDriverInfo();
    if (drAns.state != 'success') {
      setState(() {
        _errorForm = drAns.info;
        _loading = false;
      });
      return 0;
    }

    setState(() {
      _loading = false;
    });

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
                          Get.back();
                          Get.delete<SubmitDriverDetailsController>(
                              force: true);
                          Get.toNamed('/sign');
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
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0x4524B42E)),
                  child: const Icon(
                    Icons.done_rounded,
                    color: Color(0xFF24B42E),
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                const Text(
                  'Hello taarifa zako zimehakikiwa kikamilifu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 7,
                ),
                const Text(
                  'Hongera umefanikiwa kujisajili kama dereve kwenye mfumo wa shirikisho. Namba ya vazi lako utapewa kiongozi wa kikundi chako atakapo kuhakiki.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.delete<SubmitDriverDetailsController>(force: true);
                      Get.toNamed('/sign');
                    },
                    style: appStyles.defaultButtonStyles(),
                    child: const Text('Sawa'))
              ],
            ),
          ),
        ),
        barrierDismissible: false);

    return 1;
  }

  final TextEditingController _idNumber = TextEditingController();
  final PostMainApis _postMainApis = PostMainApis();
  final SubmitDriverDetailsController _submitDriverDetailsController =
      Get.put(SubmitDriverDetailsController());
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.labelSmall ??
        const TextStyle(fontSize: 17, fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taarifa za Ziada',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary),
            value: 0.98,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          SelectWithSearchInput(
            borderColor: const Color(0xFFC7D3DD),
            dropdownKey: dropdownCardType,
            fillcolor: Colors.white,
            focusedColor: Theme.of(context).colorScheme.primary,
            itemz: const ['Chagua', 'Sina', 'NIDA', 'Kura', 'Leseni'],
            selecedFun: (item) {
              setState(() {
                _typeOfId = item;
              });
            },
            labelText: 'Aina ya Kitambulisho',
            labelStyles: labelStyle,
            selectedItem: _typeOfId,
          ),
          _idNNumbeWigetCollection(),
          const SizedBox(
            height: 20,
          ),
          _passSelectorDisplayor(),
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
