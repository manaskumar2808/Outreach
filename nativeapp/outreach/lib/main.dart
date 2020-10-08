import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth_provider.dart';
import './providers/feed_provider.dart';
import './providers/user_provider.dart';
import './providers/like_provider.dart';
import './providers/comment_provider.dart';
import './providers/reply_provider.dart';

import './screens/temp_screen.dart';
import './screens/auth_screen.dart';
import './screens/explore_screen.dart';
import './screens/home_screen.dart';
import './screens/comment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
        ChangeNotifierProvider.value(value: FeedProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: LikeProvider()),
        ChangeNotifierProvider.value(value: CommentProvider()),
        ChangeNotifierProvider.value(value: ReplyProvider()),
      ],
      child: MaterialApp(
        title: 'Outreach',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TempScreen(),
        routes: {
          TempScreen.routeName: (ctx) => TempScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AuthScreen.routeName : (ctx) => AuthScreen(),
          ExploreScreen.routeName: (ctx) => ExploreScreen(),
          CommentScreen.routeName: (ctx) => CommentScreen(),
        },
      ),
    );
  }
}
