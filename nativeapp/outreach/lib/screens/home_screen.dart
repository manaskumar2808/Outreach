import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/user_provider.dart';

import '../widgets/story.dart';
import '../widgets/feed_list.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'feeds/';

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).userId;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
        centerTitle: false,
        toolbarHeight: 50,
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Outreach',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sincery Bartlow',
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        child: FutureBuilder(
          future: Provider.of<FeedProvider>(context, listen: false).feeds,
          builder: (ctx, feedSnapshot) => feedSnapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                )
              : FutureBuilder(
                  future: Provider.of<UserProvider>(context).getCurrentUser(userId),
                  builder: (context, currentUserSnapshot) => currentUserSnapshot.connectionState == ConnectionState.waiting ?
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),
                  ) :
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Story(),
                        FeedList(
                          feeds: feedSnapshot.data,
                          currentUser: currentUserSnapshot.data,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
