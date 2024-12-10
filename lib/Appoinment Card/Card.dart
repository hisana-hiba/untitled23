import 'package:flutter/material.dart';

import 'Apmnt form screen.dart';
import 'Appoinment details page.dart';
import 'Details page.dart';


void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home:AppointmentListScreen() ,));
}

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  // List of appointments
  List<Map<String, String>> appointments = [
    {'name': 'Hisana', 'time': '10:00 AM', 'status': 'Confirmed'},
    {'name': 'Aysha', 'time': '11:30 AM', 'status': 'Pending'},
    {'name': 'Fathima', 'time': '2:00 PM', 'status': 'Canceled'},
  ];

  // Function to add a new appointment
  void addAppointment(Map<String, String> appointment) {
    setState(() {
      appointments.add(appointment);
    });
  }

  // Function to update an existing appointment
  void updateAppointment(int index, Map<String, String> updatedAppointment) {
    setState(() {
      appointments[index] = updatedAppointment;
    });
  }

  // Function to delete an appointment
  void deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to Add Appointment screen
              final newAppointment = await Navigator.push<Map<String, String>>(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentFormScreen(),
                ),
              );
              if (newAppointment != null) {
                addAppointment(newAppointment);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return AppointmentCard(
            patientName: appointment['name']!,
            appointmentTime: appointment['time']!,
            status: appointment['status']!,
            detailsPage: AppointmentDetailsScreen(
              patientName: appointment['name']!,
              appointmentTime: appointment['time']!,
              status: appointment['status']!,
            ),
            onLongPress: () async {
              // Show options for Update or Delete
              final action = await showModalBottomSheet<String>(
                context: context,
                builder: (context) => BottomSheetMenu(),
              );

              if (action == 'update') {
                final updatedAppointment = await Navigator.push<Map<String, String>>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentFormScreen(
                      appointment: appointment,
                    ),
                  ),
                );
                if (updatedAppointment != null) {
                  updateAppointment(index, updatedAppointment);
                }
              } else if (action == 'delete') {
                deleteAppointment(index);
              }
            },
          );
        },
      ),
    );
  }
}

class BottomSheetMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Update'),
          onTap: () => Navigator.pop(context, 'update'),
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
