import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shirikisho_drivers/getx_auth_middleware/login_auth.dart';
import 'package:shirikisho_drivers/getx_auth_middleware/registration_auth.dart';
import 'package:shirikisho_drivers/getx_auth_middleware/update_auth.dart';
import 'package:shirikisho_drivers/major_screens/home/home_main.dart';
import 'package:shirikisho_drivers/major_screens/login/login_code.dart';
import 'package:shirikisho_drivers/major_screens/login/login_pass.dart';
import 'package:shirikisho_drivers/major_screens/login/pass_change.dart';
import 'package:shirikisho_drivers/major_screens/members/member_list.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_card.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_code.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_contacts.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_park.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_personal.dart';
import 'package:shirikisho_drivers/major_screens/registraction/registration_vehicle.dart';
import 'package:shirikisho_drivers/major_screens/settings/account_settings.dart';
import 'package:shirikisho_drivers/major_screens/splash/splash.dart';
import 'package:shirikisho_drivers/major_screens/uniform/uniform_main.dart';
import 'package:shirikisho_drivers/major_screens/uniform/uniform_pay.dart';
import 'package:shirikisho_drivers/major_screens/updates/user_update_main.dart';
import 'package:shirikisho_drivers/major_screens/verifying/verify_details.dart';
import 'package:shirikisho_drivers/major_screens/verifying/verifying_list.dart';
import 'package:shirikisho_drivers/mobile.dart';
import 'package:shirikisho_drivers/storage/shared_prefe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DriverPrefences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF24B42E),
            background: Colors.white,
            error: const Color.fromARGB(255, 232, 160, 160),
            onError: const Color(0xFFFF3636)),
        primaryColor: const Color(0xFF24B42E),
        primaryColorLight: const Color(0xFF24B42E),
        primaryColorDark: const Color(0xFF24B42E),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xFF24B42E)),
          foregroundColor: MaterialStatePropertyAll(Color(0xFFFFFFFF)),
        )),
        bottomSheetTheme: BottomSheetThemeData(
            shape: Border(
                top: BorderSide(
                    color: Theme.of(context).colorScheme.onSecondary)),
            elevation: 2.0,
            surfaceTintColor: Colors.white),
        appBarTheme: const AppBarTheme(color: Colors.white),
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist'),
            displayMedium: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist'),
            displaySmall: TextStyle(fontSize: 18.0, fontFamily: 'Urbanist'),
            bodyMedium: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Urbanist',
            ),
            bodySmall: TextStyle(
              fontSize: 16.0,
            ),
            labelLarge: TextStyle(fontSize: 22, fontFamily: 'Urbanist'),
            labelMedium: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18,
            ),
            labelSmall: TextStyle(
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600)),
        useMaterial3: true,
      ),
      home: const Splash(),
      getPages: [
        GetPage(
            name: '/sign',
            page: () => const LoginPass(),
            middlewares: [LogggedHOMEInUserMiddleware()]),
        GetPage(
            name: '/change/password',
            page: () => const ChangePasswordLogin(),
            middlewares: [LoginCodePageMiddleware()]),
        GetPage(
            name: '/login/code',
            page: () => const LoginCode(),
            middlewares: [LoginCodePageMiddleware()]),
        GetPage(
            name: '/registration', page: () => const RegistrationContacts()),
        GetPage(name: '/home', page: () => const HomeMain()),
        GetPage(
            name: '/reg/code',
            page: () => const RegistrationCode(),
            middlewares: [CodePageMiddleware()]),
        GetPage(
            name: '/reg/park',
            page: () => const RegistrationParksPage(),
            middlewares: [ParkPageMiddleware()]),
        GetPage(
            name: '/reg/personal',
            page: () => const RegistrationPersonal(),
            middlewares: [PersonMiddleware()]),
        GetPage(
            name: '/reg/vehicle',
            page: () => const RegistrationVehicle(),
            middlewares: [VehicleMiddleware()]),
        GetPage(
            name: '/reg/cards',
            page: () => const RegistrationCards(),
            middlewares: [CardPageMiddleware()]),
        GetPage(
            name: '/mobile',
            page: () => const MobileMain(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/veri/list',
            page: () => const VerifyingDriverList(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/veri/details',
            page: () => const VerifyDriverDetails(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/driver/members',
            page: () => const MemberListPage(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/account/settings',
            page: () => const AccountSettings(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/driver/update',
            page: () => const UserUpdateMain(),
            middlewares: [CheckIfDriverIdIsSet()]),
        GetPage(
            name: '/uniform/main',
            page: () => const UniformMainScreen(),
            middlewares: [LogggedInUserMiddleware()]),
        GetPage(
            name: '/uniform/payment',
            page: () => const UniformPayments(),
            middlewares: [LogggedInUserMiddleware()])
      ],
    );
  }
}
