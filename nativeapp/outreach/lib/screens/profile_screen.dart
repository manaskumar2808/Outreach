import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/feed_provider.dart';

import '../screens/temp_screen.dart';

import '../widgets/feed_grid.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    this._tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }


  void authLogout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout().then((value) =>
        {Navigator.of(context).pushReplacementNamed(TempScreen.routeName)});
  }

  @override
  Widget build(BuildContext context) {
    final id = Provider.of<AuthProvider>(context, listen: false).userId;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
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
        child: FutureBuilder(
          future: Provider.of<UserProvider>(context, listen: false)
              .getCurrentUser(id),
          builder: (ctx, currentUserSnapshot) => currentUserSnapshot
                      .connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey[700]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: currentUserSnapshot.data.profileImageUrl ==
                                        null
                                    ? Image.asset(
                                        'assets/image/profile-default.png',
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      )
                                    : Image.network(
                                        currentUserSnapshot.data.profileImageUrl,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    currentUserSnapshot.data.userName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (currentUserSnapshot.data.firstName !=
                                          null &&
                                      currentUserSnapshot.data.lastName != null)
                                    Text(
                                      '${currentUserSnapshot.data.firstName} ${currentUserSnapshot.data.lastName}',
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Container(
                              child: RaisedButton(
                                onPressed: () {
                                  this.authLogout(context);
                                },
                                child: Text(
                                  'Logout',
                                ),
                                color: Colors.red,
                                textColor: Colors.white,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[350],width: 1),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Colors.grey[350])),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.grey[350]
                                      ),
                                    ),
                                    Text(
                                      'posts',
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.grey[350]
                                      ),
                                    ),
                                    Text(
                                      'followers',
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: Colors.grey[350])),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.grey[350]
                                      ),
                                    ),
                                    Text(
                                      'following',
                                      style: TextStyle(
                                        color: Colors.grey[350],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: TabBar(
                          controller: this._tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: Colors.blue,
                          tabs: [
                            Icon(
                              Icons.grid_on,
                              color: Colors.grey[350],
                            ),
                            Icon(
                              Icons.account_box,
                              color: Colors.grey[350],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: TabBarView(
                          controller: this._tabController,
                          children: [
                            FutureBuilder(
                              future: Provider.of<FeedProvider>(context,listen: false).fetchAndSetUserFeeds(id: id),
                              builder: (context,feedSnapshot) =>
                              feedSnapshot.connectionState == ConnectionState.waiting ? 
                              Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.red),
                                ),
                              ) :
                              FeedGrid(
                                feedList: feedSnapshot.data,
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  'Tagged Posts',
                                  style: TextStyle(color: Colors.grey[350]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
