import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shirikisho_drivers/micro/styles.dart';

class CodeLogForm extends StatefulWidget {
  final Function fFun;
  final Function bFun;
  final String infoText;
  final String erroText;
  final bool loadingStat;
  const CodeLogForm(
      {super.key,
      this.erroText = '',
      required this.fFun,
      required this.bFun,
      this.infoText = 'Ingiza number iliyotumwa kwenye 07****76',
      this.loadingStat = false});

  @override
  State<CodeLogForm> createState() => _CodeLogFormState();
}

class _CodeLogFormState extends State<CodeLogForm> {
  late String verificationCode = '';
  final KishoStyles appStyles = KishoStyles();
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
          widget.fFun(verificationCode);
        },
        style: appStyles.defaultButtonStyles().copyWith(
              minimumSize:
                  const MaterialStatePropertyAll(Size(double.maxFinite, 45)),
            ),
        child: const Text('Endelea'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Hakikisha namba yako',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: double.maxFinite,
          child: Text(
            widget.infoText,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        PinCodeTextField(
          appContext: context,
          length: 6,
          enableActiveFill: true,
          autovalidateMode: AutovalidateMode.disabled,
          onChanged: (value) {
            setState(() {
              verificationCode = value;
            });
          },
          useHapticFeedback: true,
          // #
          pinTheme: PinTheme(
              inactiveColor: const Color(0xFF505F79),
              inactiveFillColor: const Color(0x1A505F79),
              activeColor: Theme.of(context).colorScheme.primary,
              selectedColor: Theme.of(context).colorScheme.primary,
              selectedFillColor: Theme.of(context).colorScheme.primary,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(4),
              fieldHeight: 50,
              fieldWidth: 45,
              activeFillColor: const Color(0xFF4D4D4D)),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Tuma tena',
                  style: TextStyle(fontSize: 14),
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        errWigFun(widget.erroText),
        ElevatedButton(
            onPressed: () {
              widget.bFun();
            },
            style: appStyles.defaultButtonStyles().copyWith(
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.maxFinite, 45)),
                backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFFCFD0D0))),
            child: const Text('Sitisha')),
        const SizedBox(
          height: 20,
        ),
        btnNLoader(widget.loadingStat, context),
      ],
    );
  }
}
