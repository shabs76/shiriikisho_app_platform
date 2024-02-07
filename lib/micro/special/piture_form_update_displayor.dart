import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

import 'package:shirikisho_drivers/special/special_fun.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';

class PictureFormDisplayorUpdate extends StatefulWidget {
  final String cardHead;
  final String imagePath;
  final Function reTakeFun;
  final String nameDis;
  const PictureFormDisplayorUpdate(
      {required this.cardHead,
      required this.imagePath,
      required this.reTakeFun,
      this.nameDis = '',
      super.key});

  @override
  State<PictureFormDisplayorUpdate> createState() =>
      _PictureFormDisplayorUpdateState();
}

class _PictureFormDisplayorUpdateState
    extends State<PictureFormDisplayorUpdate> {
  @override
  Widget build(BuildContext context) {
    final KishoStyles appStyles = KishoStyles();
    return Card(
      elevation: 2.0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              widget.cardHead,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 10),
            Image.network(
              imageProcessorFromID(widget.imagePath),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(assest404Image, fit: BoxFit.cover);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        widget.reTakeFun();
                      },
                      style: appStyles.defaultButtonStyles().copyWith(
                          minimumSize: const MaterialStatePropertyAll(
                              Size(double.infinity, 45))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Symbols.undo_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(widget.nameDis == ''
                              ? 'Rudia Kuchukua'
                              : widget.nameDis)
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
