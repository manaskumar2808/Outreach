import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comment_provider.dart';
import '../providers/reply_provider.dart';

import '../models/user.dart';

import '../widgets/comment_list.dart';
import '../widgets/comment_form.dart';

class CommentScreen extends StatelessWidget {
  static const String routeName = 'comments/';
  bool isReply = false;
  String replyCommentId = '';
  String replyCommentUserName = '';


  Future<void> submitComment({
    BuildContext context, 
    User currentUser, 
    int feedId, 
    String text,
  }) async {
    if (text.trim().length > 0) {
      await Provider.of<CommentProvider>(context, listen: false)
          .addComment(text: text, feedId: feedId, commentor: {
        "userName": currentUser.userName,
        "email": currentUser.email,
        "profileImageUrl": currentUser.profileImageUrl,
        "firstName": currentUser.firstName,
        "lastName": currentUser.lastName,
        "phoneNo": currentUser.phoneNo,
        "user": currentUser.userId,
      });
      await Provider.of<CommentProvider>(context, listen: false)
          .fetchAndSetFeedComments(feedId);
    }
  }

  void replyInit({String userName, String commentId}) {
    this.replyCommentUserName = '@$userName ';
    this.isReply = true;
    this.replyCommentId = commentId;
  }

  Future<void> submitReply({
    BuildContext context, 
    User currentUser, 
    String commentId, 
    String text,
  }) async {
    await Provider.of<ReplyProvider>(context, listen: false)
        .addReply(text: text, commentId: commentId, replier: {
      "userName": currentUser.userName,
      "email": currentUser.email,
      "profileImageUrl": currentUser.profileImageUrl,
      "firstName": currentUser.firstName,
      "lastName": currentUser.lastName,
      "phoneNo": currentUser.phoneNo,
      "user": currentUser.userId,
    });
    await Provider.of<ReplyProvider>(context, listen: false)
        .fetchAndSetReplies(commentId: commentId);
  }

  @override
  Widget build(BuildContext context) {
    final feedId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 50,
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Comments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CommentList(
                feedId: feedId,
                replyInit: this.replyInit,
              ),
            ),
            CommentForm(
              feedId: feedId,
              replyCommentId: this.replyCommentId,
              isReply: this.isReply,
              replyCommentUserName: this.replyCommentUserName,
              submitComment: this.submitComment,
              submitReply: this.submitReply,
            ),
          ],
        ),
      ),
    );
  }
}
