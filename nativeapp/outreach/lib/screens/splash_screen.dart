import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          'Outreach',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sincery Bartlow',
              fontSize: 20,
          ),
        ),
      ),
    );
  }
}