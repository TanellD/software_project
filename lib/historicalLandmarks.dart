import 'package:flutter/material.dart';

class HistoricalLandmark extends StatefulWidget {
  @override
  _HistoricalLandmarkState createState() => _HistoricalLandmarkState();
}

class _HistoricalLandmarkState extends State<HistoricalLandmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historical Landmark'),
      ),
      body: Center(
        child: Text(
          'This is the search page for Historical Landmark',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
