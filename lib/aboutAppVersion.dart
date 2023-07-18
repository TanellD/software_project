import 'package:flutter/material.dart';

class AboutAndAppVersionPage extends StatelessWidget {
  final String appName = 'KazanTravel App';
  final String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About and App Version'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              appName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Version: $appVersion',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32.0),
            Text(
              'Welcome to the Tourism App, your ultimate travel companion. '
              'Explore exciting destinations, plan your trips, and discover '
              'the wonders of the world. We strive to provide the best travel '
              'experience to our users.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Implement logic to navigate to the feedback or contact page
              },
              child: Text('Send Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
