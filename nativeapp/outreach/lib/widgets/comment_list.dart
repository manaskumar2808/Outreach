import 'package:flutter/material.dart';
import 'package:outreach/providers/auth_provider.dart';
import 'package:outreach/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../providers/comment_provider.dart';
import '../providers/like_provider.dart';

import '../models/user.dart';

import './comment_tile.dart';

class CommentList extends StatelessWidget {
  final feedId;
  final Function({String userName, String commentId}) replyInit;

  CommentList({
    @required this.feedId,
    @required this.replyInit,
  });

  void likeComment({
    BuildContext context,
    User currentUser,
    String commentId,
  }) async {
    await Provider.of<LikeProvider>(context, listen: false).likeComment(
      commentId: commentId,
      liker: {
        "userName": currentUser.userName,
        "email": currentUser.email,
        "profileImageUrl": currentUser.profileImageUrl,
        "firstName": currentUser.firstName,
        "lastName": currentUser.lastName,
        "phoneNo": currentUser.phoneNo,
        "user": currentUser.userId,
      },
    );
  }

  void unLikeComment({
    BuildContext context,
    String commentId,
    int userId,
  }) async {
    await Provider.of<LikeProvider>(context, listen: false).unLikeComment(
      userId: userId,
      commentId: commentId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context,listen: false).userId;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FutureBuilder(
          future: Provider.of<CommentProvider>(context, listen: true)
              .fetchAndSetFeedComments(feedId),
          builder: (context, commentsSnapshot) =>
              commentsSnapshot.connectionState == ConnectionState.waiting
                  ? Container(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.red),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: commentsSnapshot.data.length,
                      itemBuilder: (context, index) => FutureBuilder(
                        future: Provider.of<LikeProvider>(context,listen: false)
                            .commentIsLiked(commentsSnapshot.data[index].id, userId),
                        builder: (ctx, isLikedSnapshot) => isLikedSnapshot.connectionState == ConnectionState.waiting ?
                        CommentTile(
                          comment: commentsSnapshot.data[index],
                          replyInit: this.replyInit,
                          likeComment: this.likeComment,
                          unLikeComment: this.unLikeComment,
                          isLiked: false,
                        ) 
                         :
                        FutureBuilder(
                          future: Provider.of<LikeProvider>(context,listen: false).commentLikes(commentsSnapshot.data[index].id),
                          builder: (ctx, likesSnapshot) => likesSnapshot.connectionState == ConnectionState.waiting ?
                          CommentTile(
                            comment: commentsSnapshot.data[index],
                            replyInit: this.replyInit,
                            likeComment: this.likeComment,
                            unLikeComment: this.unLikeComment,
                            isLiked: isLikedSnapshot.data,
                            likes: 0,
                          ) :
                          CommentTile(
                            comment: commentsSnapshot.data[index],
                            replyInit: this.replyInit,
                            likeComment: this.likeComment,
                            unLikeComment: this.unLikeComment,
                            isLiked: isLikedSnapshot.data,
                            likes: likesSnapshot.data,
                          ),
                        ),
                      ),
                    )),
    );
  }
}
