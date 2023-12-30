import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:shirikisho_drivers/major_screens/login/login_pass.dart';
import 'package:shirikisho_drivers/mobile.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> logState = DriverPrefences.getLoggedinDetails();
    return AnimatedSplashScreen(
      splash: Center(
        child: GifView.asset(
          'assets/images/spashgif.gif',
        ),
      ),
      nextScreen: logState.containsKey(DriverPrefences.logKey) &&
              logState[DriverPrefences.logKey] != null
          ? const MobileMain()
          : const LoginPass(),
      backgroundColor: Colors.black,
      splashIconSize: 300,
      duration: 3000,
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}
