import 'package:flutter/material.dart';

class SportAndEntertainmentVenues extends StatefulWidget {
  @override
  _SportAndEntertainmentVenuesState createState() =>
      _SportAndEntertainmentVenuesState();
}

class _SportAndEntertainmentVenuesState
    extends State<SportAndEntertainmentVenues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport and Entertainment Venues'),
      ),
      body: Center(
        child: Text(
          'This is the search page for Sport and Entertainment Venues',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}