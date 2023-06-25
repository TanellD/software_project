import 'package:flutter/material.dart';

class LightbulbPage extends StatefulWidget {
  @override
  _LightbulbPageState createState() => _LightbulbPageState();
}

class _LightbulbPageState extends State<LightbulbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lightbulb Page'),
      ),
      body: Center(
        child: Text(
          'This is the Lightbulb Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}