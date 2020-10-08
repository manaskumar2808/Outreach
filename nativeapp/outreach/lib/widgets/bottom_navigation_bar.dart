import 'package:flutter/material.dart';

class BottomNavigationTabBar extends StatefulWidget {
  void Function(int index) setIndex;

  BottomNavigationTabBar(this.setIndex);

  @override
  _BottomNavigationTabBarState createState() => _BottomNavigationTabBarState();
}

class _BottomNavigationTabBarState extends State<BottomNavigationTabBar> {
  var tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: TabBar(
          isScrollable: false,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.black,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 15),
          onTap: (value) {
            this.widget.setIndex(value);
          },
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home,size: 20,),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.explore),
              text: 'Explore',
            ),
            Tab(
              icon: Icon(Icons.add_box),
              text: 'Post',
            ),
            Tab(
              icon: Icon(Icons.favorite_border),
              text: 'Activity',
            ),
            Tab(
              icon: Icon(Icons.account_circle),
              text: 'Profile',
            ),
          ],
        ));
  }
}
