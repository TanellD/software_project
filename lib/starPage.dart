import 'package:flutter/material.dart';

class StarPage extends StatefulWidget {
  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Page'),
      ),
      body: Center(
        child: Text(
          'This is the Star Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
