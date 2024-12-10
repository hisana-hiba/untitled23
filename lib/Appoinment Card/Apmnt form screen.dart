
import 'package:flutter/material.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Map<String, String>? appointment;

  const AppointmentFormScreen({Key? key, this.appointment}) : super(key: key);

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String time;
  late String status;

  @override
  void initState() {
    super.initState();
    name = widget.appointment?['name'] ?? '';
    time = widget.appointment?['time'] ?? '';
    status = widget.appointment?['status'] ?? 'Confirmed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appointment == null ? 'Add Appointment' : 'Update Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Patient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: time,
                decoration: const InputDecoration(labelText: 'Appointment Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  return null;
                },
                onSaved: (value) => time = value!,
              ),
              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(value: 'Confirmed', child: Text('Confirmed')),
                  DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                  DropdownMenuItem(value: 'Canceled', child: Text('Canceled')),
                ],
                onChanged: (value) => status = value!,
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {'name': name, 'time': time, 'status': status});
                  }
                },
                child: Text(widget.appointment == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
