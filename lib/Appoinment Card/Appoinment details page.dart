import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String status;

  const AppointmentDetailsScreen({
    Key? key,
    required this.patientName,
    required this.appointmentTime,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Name: $patientName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Appointment Time: $appointmentTime',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 16,
                color: status.toLowerCase() == 'confirmed'
                    ? Colors.green
                    : (status.toLowerCase() == 'pending'
                    ? Colors.orange
                    : Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
