import 'package:flutter/material.dart';
import 'package:shirikisho_drivers/major_screens/uniform/subs/bank_pay_uniform.dart';
import 'package:shirikisho_drivers/major_screens/uniform/subs/mobile_pay_uniform.dart';

class UniformPayments extends StatefulWidget {
  const UniformPayments({super.key});

  @override
  State<UniformPayments> createState() => _UniformPaymentsState();
}

class _UniformPaymentsState extends State<UniformPayments>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Uchaguzi wa Malipo',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        bottom: TabBar(
          tabs: const [
            Text("Mkopo wa Benki"),
            Text("Malipo Tasilimu"),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [UniformPayBank(), UniformPaymentMobile()],
      ),
    );
  }
}
