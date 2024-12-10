import 'package:flutter/material.dart';
import 'package:untitled23/Patient/patient%20form%20screen.dart';

import 'about patient.dart';
void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home:PatientRecordsScreen() ,));
}

class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({Key? key}) : super(key: key);

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  List<Map<String, String>> patients = [
    {'name': 'John Doe', 'id': '001', 'status': 'Active'},
    {'name': 'Jane Smith', 'id': '002', 'status': 'Discharged'},
    {'name': 'Alice Brown', 'id': '003', 'status': 'Active'},
    {'name': 'Bob Johnson', 'id': '004', 'status': 'Discharged'},
  ];

  String searchQuery = '';
  String filterStatus = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredPatients = patients.where((patient) {
      final matchesQuery = patient['name']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = filterStatus == 'All' || patient['status'] == filterStatus;
      return matchesQuery && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to add new patient screen
              final newPatient = await Navigator.push<Map<String, String>>(
                context,
                MaterialPageRoute(builder: (context) => const PatientFormScreen()),
              );
              if (newPatient != null) {
                setState(() {
                  patients.add(newPatient);
                });
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search patients',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: filterStatus,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All')),
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Discharged', child: Text('Discharged')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      filterStatus = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];
                return ListTile(
                  title: Text(patient['name']!),
                  subtitle: Text('ID: ${patient['id']} | Status: ${patient['status']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientDetailsScreen(patient: patient),
                        ),
                      );
                    },
                  ),
                  onLongPress: () async {
                    // Edit or delete patient
                    final action = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) => const _EditDeleteMenu(),
                    );
                    if (action == 'edit') {
                      final updatedPatient = await Navigator.push<Map<String, String>>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientFormScreen(patient: patient),
                        ),
                      );
                      if (updatedPatient != null) {
                        setState(() {
                          patients[index] = updatedPatient;
                        });
                      }
                    } else if (action == 'delete') {
                      setState(() {
                        patients.removeAt(index);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



class _EditDeleteMenu extends StatelessWidget {
  const _EditDeleteMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit'),
          onTap: () => Navigator.pop(context, 'edit'),
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text('Delete'),
          onTap: () => Navigator.pop(context, 'delete'),
        ),
      ],
    );
  }
}
