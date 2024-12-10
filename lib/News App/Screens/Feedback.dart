import 'package:flutter/material.dart';


import 'Like page.dart';
import 'Meh.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.thumb_up_alt_outlined, size: 100, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Please rate your experience.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap to show some love. I can do this all day! :)',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Like_feedback()), // Navigate to LikeItPage
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'I like it!  🎉',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MehFeedbackPage()),
                );
              },
              child: Text(
                "It's meh  😒",
              ),
            ),
          ],
        ),
      ),
    );
  }
}