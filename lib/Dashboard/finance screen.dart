import 'package:flutter/material.dart';

class FinancesScreen extends StatelessWidget {
  const FinancesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finances'),
      ),
      body: Center(
        child: const Text(
          'Financial Details',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
