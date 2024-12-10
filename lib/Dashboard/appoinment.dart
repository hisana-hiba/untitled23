import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: Center(
        child: const Text(
          'Appointments Details',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
