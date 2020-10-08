import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../providers/reply_provider.dart';
import '../providers/like_provider.dart';

import '../models/user.dart';

import './circular_profile_item.dart';

class CommentTile extends StatefulWidget {
  final comment;
  final Function({String userName, String commentId}) replyInit;
  final Function({
    BuildContext context,
    String commentId,
    User currentUser,
  }) likeComment;
  final Function({
    BuildContext context,
    String commentId,
    int userId,
  }) unLikeComment;
  bool isLiked;
  int likes;

  CommentTile({
    @required this.comment,
    this.replyInit,
    this.likeComment,
    this.unLikeComment,
    this.isLiked = false,
    this.likes = 0,
  });

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  bool _show = false;

  Future<bool> likedFuture;

  Widget showReplies() {
    return FutureBuilder(
      future: Provider.of<ReplyProvider>(context, listen: true)
          .fetchAndSetReplies(commentId: this.widget.comment.id),
      builder: (context, repliesSnapshot) =>
          repliesSnapshot.connectionState == ConnectionState.waiting
              ? Container(
                  height: 57,
                  child: Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: repliesSnapshot.data.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(left: 60),
                          child: ListTile(
                            leading: CircularProfileItem(
                              imageUrl: repliesSnapshot
                                  .data[index].replier['profileImageUrl'],
                              haveBorder: false,
                              radius: 22.5,
                            ),
                            title: Text(
                              repliesSnapshot.data[index].replier['userName'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              repliesSnapshot.data[index].text,
                              style: TextStyle(
                                color: Colors.grey[350],
                                fontSize: 15,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.favorite_border),
                              iconSize: 15,
                              color: Colors.grey[350],
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  void likeComment({
    User currentUser,
  }) {
    this.widget.likeComment(
          context: context,
          currentUser: currentUser,
          commentId: this.widget.comment.id,
        );
    setState(() {
      this.widget.isLiked = true;
      this.widget.likes = this.widget.likes + 1;
    });
  }

  void unLikeComment({
    int userId,
  }) {
    this.widget.unLikeComment(
          context: context,
          userId: userId,
          commentId: this.widget.comment.id,
        );

    setState(() {
      this.widget.isLiked = false;
      this.widget.likes = this.widget.likes - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).userId;

    return Container(
      key: ValueKey(this.widget.comment.id),
      child: Column(
        children: [
          ListTile(
            leading: CircularProfileItem(
              imageUrl: this.widget.comment.commentor['profileImageUrl'],
              haveBorder: false,
              radius: 22.5,
            ),
            title: Text(
              this.widget.comment.commentor['userName'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              this.widget.comment.text,
              style: TextStyle(
                color: Colors.grey[350],
                fontSize: 15,
              ),
            ),
            trailing: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .getCurrentUser(userId),
              builder: (ctx, currentUserSnapshot) =>
                  currentUserSnapshot.connectionState == ConnectionState.waiting
                      ? IconButton(
                          icon: Icon(Icons.favorite_border),
                          iconSize: 15,
                          color: Colors.grey[350],
                          onPressed: () {},
                        )
                      : IconButton(
                          icon: this.widget.isLiked
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border),
                          iconSize: 15,
                          color: this.widget.isLiked
                              ? Colors.pink
                              : Colors.grey[350],
                          onPressed: this.widget.isLiked
                              ? () => this.unLikeComment(userId: userId)
                              : () => this.likeComment(
                                  currentUser: currentUserSnapshot.data)),
            ),
            // : FutureBuilder(
            //     future: Provider.of<LikeProvider>(context, listen: true)
            //         .commentIsLiked(this.widget.comment.id, userId),
            //     builder: (ctx, isLikedSnapshot) => isLikedSnapshot
            //                 .connectionState ==
            //             ConnectionState.waiting
            //         ? IconButton(
            //             icon: Icon(Icons.favorite_border),
            //             iconSize: 15,
            //             color: Colors.grey[350],
            //             onPressed: () {},
            //           )
            //         : IconButton(
            //             icon: isLikedSnapshot.data
            //                 ? Icon(Icons.favorite)
            //                 : Icon(Icons.favorite_border),
            //             iconSize: 15,
            //             color: isLikedSnapshot.data
            //                 ? Colors.pink
            //                 : Colors.grey[350],
            //             onPressed: isLikedSnapshot.data
            //                 ? () => this.widget.unLikeComment(
            //                       context: context,
            //                       userId: userId,
            //                       commentId: this.widget.comment.id,
            //                     )
            //                 : () => this.widget.likeComment(
            //                       context: context,
            //                       currentUser: currentUserSnapshot.data,
            //                       commentId: this.widget.comment.id,
            //                     )),
            //   ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65,
                ),
                // FutureBuilder(
                //   future: Provider.of<LikeProvider>(context, listen: false)
                //       .commentLikes(this.widget.comment.id),
                //   builder: (ctx, likesSnapshot) =>
                //       likesSnapshot.connectionState == ConnectionState.waiting
                //           ? Text(
                //               '0 likes',
                //               style: TextStyle(
                //                 color: Colors.grey[400],
                //               ),
                //             )
                //           : Text(
                //               '${likesSnapshot.data} likes',
                //               style: TextStyle(
                //                 color: Colors.grey[400],
                //               ),
                //             ),
                // ),
                Text(
                  '${this.widget.likes} likes',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => this.widget.replyInit(
                        userName: this.widget.comment.commentor['userName'],
                        commentId: this.widget.comment.id,
                      ),
                  child: Text(
                    'reply',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () => {
                this.setState(() {
                  this._show = !this._show;
                })
              },
              child: Text(
                this._show
                    ? '------------ hide replies ------------'
                    : '------------ view replies ------------',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          if (this._show) showReplies(),
        ],
      ),
    );
  }
}
