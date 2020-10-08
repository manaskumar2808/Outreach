import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import './splash_screen.dart';
import './tab_screen.dart';
import './auth_screen.dart';

class TempScreen extends StatefulWidget {
  static const String routeName = 'temp/';

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<AuthProvider>(context, listen: false).isAuthenticated,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? SplashScreen()
                : snapshot.data ? TabScreen() : AuthScreen(),
      ),
    );
  }
}
