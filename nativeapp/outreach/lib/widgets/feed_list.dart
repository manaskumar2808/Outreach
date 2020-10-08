import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/like_provider.dart';

import '../models/user.dart';
import '../models/feed.dart';

import './feed_item.dart';

class FeedList extends StatelessWidget {
  final List<Feed> feeds;
  final User currentUser;

  FeedList({
    @required this.feeds,
    @required this.currentUser,
  });

  void likeFeed({
    BuildContext context,
    int feedId,
    User currentUser,
  }) async {
    await Provider.of<LikeProvider>(context, listen: false)
        .likeFeed(feedId: feedId, liker: {
      'userName': currentUser.userName,
      'email': currentUser.email,
      'firstName': currentUser.firstName,
      'lastName': currentUser.lastName,
      'profileImageUrl': currentUser.profileImageUrl,
      'phoneNo': currentUser.phoneNo,
      'user': currentUser.userId,
    });
  }

  void unLikeFeed({
    BuildContext context,
    int feedId,
    int userId,
  }) async {
    await Provider.of<LikeProvider>(context, listen: false).unLikeFeed(
      userId: userId,
      feedId: feedId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: feeds.length,
        itemBuilder: (context, index) => FeedItem(
          feed: feeds[index],
          likeFeed: this.likeFeed,
          unLikeFeed: this.unLikeFeed,
          currentUser: this.currentUser,
        ),
      ),
    );
  }
}
