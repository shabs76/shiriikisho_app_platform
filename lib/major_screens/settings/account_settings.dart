import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/major_screens/settings/subs/settings_min_profile.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: const Color.fromARGB(100, 0, 0, 0),
      ),
      body: ListView(
        children: const [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, bottom: 5, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Mipangilio ya Akaunti',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SettingsMinProfile()
        ],
      ),
    );
  }
}
