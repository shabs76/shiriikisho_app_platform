import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/major_screens/account/account_main.dart';
import 'package:shirikisho_drivers/major_screens/home/home_main.dart';

class DestinationControl extends StatefulWidget {
  final int takenPageIndex;
  final VoidCallback onNavigation;
  const DestinationControl(
      {required this.onNavigation, required this.takenPageIndex, super.key});

  @override
  State<DestinationControl> createState() => _DestinationControlState();
}

class _DestinationControlState extends State<DestinationControl> {
  List<Widget> widgetsOptions = <Widget>[
    const HomeMain(),
    const HomeMain(),
    const HomeMain(),
    const HomeMain(),
    const AccountMain(),
  ];
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation)
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return widgetsOptions[widget.takenPageIndex];
                default:
                  return widgetsOptions[widget.takenPageIndex];
              }
            });
      },
    );
  }
}

class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver(this.onNavigation);
  final VoidCallback onNavigation;
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onNavigation();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onNavigation();
  }
}
