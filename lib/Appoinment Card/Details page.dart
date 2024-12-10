import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String appointmentTime;
  final String status;
  final Widget? detailsPage; // Page to navigate to on tap.

  const AppointmentCard({
    Key? key,
    required this.patientName,
    required this.appointmentTime,
    required this.status,
    this.detailsPage, required onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getStatusColor() {
      switch (status.toLowerCase()) {
        case 'confirmed':
          return Colors.green;
        case 'pending':
          return Colors.orange;
        case 'canceled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          if (detailsPage != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => detailsPage!),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: getStatusColor(),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointmentTime,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: getStatusColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
