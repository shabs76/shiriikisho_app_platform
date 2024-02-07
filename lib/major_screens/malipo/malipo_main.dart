import 'package:flutter/material.dart';

class MalipoMainPage extends StatefulWidget {
  const MalipoMainPage({super.key});

  @override
  State<MalipoMainPage> createState() => _MalipoMainPageState();
}

class _MalipoMainPageState extends State<MalipoMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Huduma za Malipo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(
        child: Text('Malipo services are coming soon'),
      ),
    );
  }
}
