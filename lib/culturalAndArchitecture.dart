import 'package:flutter/material.dart';

class CulturalAndArchitectural extends StatefulWidget {
  @override
  _CulturalAndArchitecturalState createState() =>
      _CulturalAndArchitecturalState();
}

class _CulturalAndArchitecturalState extends State<CulturalAndArchitectural> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cultural and Architectural'),
      ),
      body: Center(
        child: Text(
          'This is the search page for Cultural and Architectural',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}