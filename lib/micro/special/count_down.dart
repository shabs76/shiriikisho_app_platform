import 'package:flutter/material.dart';
import 'dart:async';

class CountdownWidget extends StatefulWidget {
  final int seconds;
  final Function resendFun;
  const CountdownWidget(
      {required this.seconds, required this.resendFun, super.key});

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.seconds;
    startTimer();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentSeconds == 0) {
          timer.cancel();
        } else {
          _currentSeconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentSeconds == 0) {
      return TextButton(
          onPressed: () {
            widget.resendFun();
          },
          child: const Text(
            'Tuma tena',
            style: TextStyle(fontSize: 14),
          ));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('$_currentSeconds'),
      );
    }
  }
}
