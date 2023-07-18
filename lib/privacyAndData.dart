import 'package:flutter/material.dart';

class PrivacyAndDataUsagePage extends StatefulWidget {
  @override
  _PrivacyAndDataUsagePageState createState() => _PrivacyAndDataUsagePageState();
}

class _PrivacyAndDataUsagePageState extends State<PrivacyAndDataUsagePage> {
  bool isDataCollectionEnabled = true;
  bool isAnalyticsEnabled = true;
  bool isPersonalizedAdsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy and Data Usage'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Data Collection'),
            subtitle: Text('Enable data collection for personalized experiences'),
            trailing: Switch(
              value: isDataCollectionEnabled,
              onChanged: (value) {
                setState(() {
                  isDataCollectionEnabled = value;
                  // Implement logic to update data collection preferences
                });
              },
            ),
          ),
          ListTile(
            title: Text('Analytics'),
            subtitle: Text('Allow analytics data to be collected for app improvements'),
            trailing: Switch(
              value: isAnalyticsEnabled,
              onChanged: (value) {
                setState(() {
                  isAnalyticsEnabled = value;
                  // Implement logic to update analytics preferences
                });
              },
            ),
          ),
          ListTile(
            title: Text('Personalized Ads'),
            subtitle: Text('Show personalized ads based on your preferences'),
            trailing: Switch(
              value: isPersonalizedAdsEnabled,
              onChanged: (value) {
                setState(() {
                  isPersonalizedAdsEnabled = value;
                  // Implement logic to update personalized ads preferences
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
