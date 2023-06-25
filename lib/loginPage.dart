import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF4FA),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Positioned(
                top: -12,
                right: -60,
                child: Container(
                  width: 310,
                  height: 290,
                  decoration: BoxDecoration(
                    color: Color(0xFF3797D0),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -60,
                left: -20,
                child: Container(
                  width: 200,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Color(0xFF9EDBFF),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xFF9EDBFF)),
            child: Icon(Icons.person_2_outlined),
          ),
          Text("Helwdgfzxcvbnv bm,mbmvncbxfvzdcsDzfbgnhgjm")
        ],
      ),
    );
  }
}