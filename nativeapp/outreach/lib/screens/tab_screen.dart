import 'package:flutter/material.dart';

import './home_screen.dart';
import './explore_screen.dart';
import './postfeed_screen.dart';
import './activity_screen.dart';
import './profile_screen.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final tabs = [
    HomeScreen(),
    ExploreScreen(),
    PostFeedScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  var tabIndex = 0;

  void setTabIndex(int index) {
    setState(() {
      this.tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.tabs[this.tabIndex],
      bottomNavigationBar: SizedBox(
        height: 45,
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: this.tabIndex,
          iconSize: 28,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              this.tabIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text('Explore'),
              icon: Icon(Icons.explore),
            ),
            BottomNavigationBarItem(
              title: Text('Post'),
              icon: Icon(Icons.add_box),
            ),
            BottomNavigationBarItem(
              title: Text('Activity'),
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}
