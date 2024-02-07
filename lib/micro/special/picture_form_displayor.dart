import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'dart:io';

class PictureFormDisplayor extends StatefulWidget {
  final String cardHead;
  final String imagePath;
  final Function reTakeFun;
  final String nameDis;
  const PictureFormDisplayor(
      {required this.cardHead,
      required this.imagePath,
      required this.reTakeFun,
      this.nameDis = '',
      super.key});

  @override
  State<PictureFormDisplayor> createState() => _PictureFormDisplayorState();
}

class _PictureFormDisplayorState extends State<PictureFormDisplayor> {
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
            Container(
              height: MediaQuery.of(context).size.width * 0.75,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.black87,
                  image: DecorationImage(
                      image: FileImage(File(widget.imagePath)))),
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
