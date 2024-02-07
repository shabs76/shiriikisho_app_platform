import 'package:flutter/material.dart';

class SocialMainPage extends StatefulWidget {
  const SocialMainPage({super.key});

  @override
  State<SocialMainPage> createState() => _SocialMainPageState();
}

class _SocialMainPageState extends State<SocialMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Siri Social',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(
        child: Text(
          'Chat with other drivers, tweet and read from shirikisho app',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
