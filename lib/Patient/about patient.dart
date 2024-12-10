import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, String> patient;

  const PatientDetailsScreen({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient ID: ${patient['id']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Status: ${patient['status']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('This section can include more patient-specific details.'),
          ],
        ),
      ),
    );
  }
}
