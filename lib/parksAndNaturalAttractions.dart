import 'package:flutter/material.dart';

class ParksAndNaturalAttractions extends StatefulWidget {
  @override
  _ParksAndNaturalAttractionsState createState() =>
      _ParksAndNaturalAttractionsState();
}

class _ParksAndNaturalAttractionsState
    extends State<ParksAndNaturalAttractions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parks and Natural Attractions'),
      ),
      body: Center(
        child: Text(
          'This is the search page for Parks and Natural Attractions',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
