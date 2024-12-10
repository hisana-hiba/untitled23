import 'package:flutter/material.dart';

class PatientFormScreen extends StatefulWidget {
  final Map<String, String>? patient;

  const PatientFormScreen({Key? key, this.patient}) : super(key: key);

  @override
  State<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends State<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String id;
  late String status;

  @override
  void initState() {
    super.initState();
    name = widget.patient?['name'] ?? '';
    id = widget.patient?['id'] ?? '';
    status = widget.patient?['status'] ?? 'Active';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient == null ? 'Add Patient' : 'Edit Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: id,
                decoration: const InputDecoration(labelText: 'Patient ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an ID';
                  }
                  return null;
                },
                onSaved: (value) => id = value!,
              ),
              DropdownButtonFormField<String>(
                value: status,
                items: const [
                  DropdownMenuItem(value: 'Active', child: Text('Active')),
                  DropdownMenuItem(value: 'Discharged', child: Text('Discharged')),
                ],
                onChanged: (value) => setState(() => status = value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {'name': name, 'id': id, 'status': status});
                  }
                },
                child: Text(widget.patient == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
