import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/like_provider.dart';
import '../providers/auth_provider.dart';

import './post.dart';

import '../models/feed.dart';
import '../models/user.dart';

class FeedItem extends StatelessWidget {
  final Feed feed;
  final Function({
    BuildContext context,
    User currentUser,
    int feedId,
  }) likeFeed;
  final Function({
    BuildContext context,
    int userId,
    int feedId,
  }) unLikeFeed;
  final User currentUser;

  FeedItem({
    @required this.feed,
    this.likeFeed,
    this.unLikeFeed,
    @required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).userId;

    return Container(
      child: 1 == 1
          ? Post(
              id: this.feed.id,
              title: this.feed.title,
              content: this.feed.content,
              imageUrl: null,
              videoUrl: this.feed.videoUrl,
              creator: this.feed.creator,
              isLiked: false,
              likes: 0,
              likeFeed: this.likeFeed,
              unLikeFeed: this.unLikeFeed,
              currentUser: this.currentUser,
            )
          : FutureBuilder(
              future: Provider.of<LikeProvider>(context, listen: false)
                  .feedIsLiked(this.feed.id, userId),
              builder: (ctx, isLikedSnapshot) =>
                  isLikedSnapshot.connectionState == ConnectionState.waiting
                      ? Post(
                          id: this.feed.id,
                          title: this.feed.title,
                          content: this.feed.content,
                          imageUrl: null,
                          videoUrl: this.feed.videoUrl,
                          creator: this.feed.creator,
                          isLiked: false,
                          likes: 0,
                          likeFeed: this.likeFeed,
                          unLikeFeed: this.unLikeFeed,
                          currentUser: this.currentUser,
                        )
                      : Post(
                          id: this.feed.id,
                          title: this.feed.title,
                          content: this.feed.content,
                          imageUrl: this.feed.imageUrl,
                          videoUrl: this.feed.videoUrl,
                          creator: this.feed.creator,
                          isLiked: false,
                          likes: 0,
                          likeFeed: this.likeFeed,
                          unLikeFeed: this.unLikeFeed,
                          currentUser: this.currentUser,
                        )
              // FutureBuilder(
              //     future: Provider.of<LikeProvider>(context, listen: false)
              //         .feedLikes(this.feed.id),
              //     builder: (ctx, likesSnapshot) =>
              //         likesSnapshot.connectionState == ConnectionState.waiting
              //             ? Post(
              //                 id: this.feed.id,
              //                 title: this.feed.title,
              //                 content: this.feed.content,
              //                 imageUrl: this.feed.imageUrl,
              //                 videoUrl: this.feed.videoUrl,
              //                 creator: this.feed.creator,
              //                 isLiked: false,
              //                 likes: 0,
              //                 likeFeed: this.likeFeed,
              //                 unLikeFeed: this.unLikeFeed,
              //               )
              //             : Post(
              //                 id: this.feed.id,
              //                 title: this.feed.title,
              //                 content: this.feed.content,
              //                 imageUrl: this.feed.imageUrl,
              //                 videoUrl: this.feed.videoUrl,
              //                 creator: this.feed.creator,
              //                 isLiked: isLikedSnapshot.data,
              //                 likes: likesSnapshot.data,
              //                 likeFeed: this.likeFeed,
              //                 unLikeFeed: this.unLikeFeed,
              //               ),
              //   ),
              ),
    );
  }
}
