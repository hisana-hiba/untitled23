import 'package:flutter/material.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      body: Center(
        child: const Text(
          'Patient Details',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
