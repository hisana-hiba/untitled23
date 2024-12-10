import 'package:flutter/material.dart';
class MehFeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> feedbackOptions = [
      'Poor UX/UI',
      'Buggy experience',
      'Irrelevant articles',
      'Expected more articles',
      'Expected more features',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.thumb_down_alt_outlined, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'What went wrong? 😔',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(feedbackOptions[index]),
                      onTap: () {
                        // Handle feedback selection
                        Navigator.pop(context); // Optionally go back after selection
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Thanks for your feedback!'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}