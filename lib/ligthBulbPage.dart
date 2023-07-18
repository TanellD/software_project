import 'package:flutter/material.dart';

class LightbulbPage extends StatefulWidget {
  @override
  _LightbulbPageState createState() => _LightbulbPageState();
}

class _LightbulbPageState extends State<LightbulbPage> {
  List<Tip> tips = [
    Tip(
      icon: Icons.local_attraction,
      title: 'Explore Local Attractions',
      description:
          'Visit famous landmarks and attractions in the area. Don\'t miss out on must-see sights.',
    ),
    Tip(
      icon: Icons.restaurant,
      title: 'Try Local Cuisine',
      description:
          'Experience the local food scene and taste traditional dishes from the region.',
    ),
    Tip(
      icon: Icons.shopping_basket,
      title: 'Shop for Souvenirs',
      description:
          'Find unique souvenirs and take home a piece of the local culture.',
    ),
    Tip(
      icon: Icons.hotel,
      title: 'Accommodation Options',
      description:
          'Research and book accommodation that suits your preferences and budget.',
    ),
    Tip(
      icon: Icons.event,
      title: 'Events and Festivals',
      description:
          'Check out local events and festivals happening during your visit for a memorable experience.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3797D0), // Blue color
        title: Text(
          'Travel Tips',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFEBF4FA), // Light blue color
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: tips.length,
          itemBuilder: (context, index) {
            final tip = tips[index];
            return _buildTipCard(tip);
          },
        ),
      ),
    );
  }

  Widget _buildTipCard(Tip tip) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              tip.icon,
              size: 40,
              color: Color(0xFF3797D0), // Blue color
            ),
            SizedBox(height: 12),
            Text(
              tip.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(tip.description),
          ],
        ),
      ),
    );
  }
}

class Tip {
  final IconData icon;
  final String title;
  final String description;

  Tip({
    required this.icon,
    required this.title,
    required this.description,
  });
}
