import 'package:flutter/material.dart';
import 'package:untitled23/Dashboard/patient%20screen.dart';
import 'appoinment.dart';
import 'finance screen.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home:DashboardScreen() ,));
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Two cards per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            DashboardCard(
              title: 'Appointments',
              value: '32',
              icon: Icons.calendar_today,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentsScreen()),
                );
              },
            ),
            DashboardCard(
              title: 'Patients',
              value: '120',
              icon: Icons.person,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientsScreen()),
                );
              },
            ),
            DashboardCard(
              title: 'Revenue',
              value: '\$5,000',
              icon: Icons.attach_money,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FinancesScreen()),
                );
              },
            ),
            DashboardCard(
              title: 'Pending Tasks',
              value: '5',
              icon: Icons.pending,
              color: Colors.red,
              onTap: () {
                // Placeholder for another linked page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
