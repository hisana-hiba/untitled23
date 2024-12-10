import 'package:flutter/material.dart';
class Like_feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> feedbackOptions = [


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
            SizedBox(height: MediaQuery.of(context).size.height/3.5),
            Icon(Icons.thumb_up_off_alt_rounded, size: 100, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'THANKS FOR THE RATING!',
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
                        Navigator.pop(context);
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