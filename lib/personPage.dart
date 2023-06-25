import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Page'),
      ),
      body: Center(
        child: Text(
          'This is the Person Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}