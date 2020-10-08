import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/like_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

import '../screens/comment_screen.dart';

import '../models/user.dart';

import './video.dart';
import './circular_profile_item.dart';

class Post extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String videoUrl;
  final Map<String, dynamic> creator;
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

  bool isLiked;
  int likes;

  Post({
    @required this.id,
    @required this.title,
    this.content,
    this.imageUrl,
    this.videoUrl,
    @required this.creator,
    this.isLiked = false,
    this.likes = 0,
    this.likeFeed,
    this.unLikeFeed,
    @required this.currentUser,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
  bool isLiked = false;
  TextEditingController _controller;
  @override
  void initState() {
    this._controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  // widget props
  final double _iconSize = 27;

  void likeFeed({
    User currentUser,
  }) {
    this.widget.likeFeed(
          context: context,
          currentUser: currentUser,
          feedId: this.widget.id,
        );

    setState(() {
      this.widget.isLiked = true;
      this.widget.likes = this.widget.likes + 1;
    });
  }

  void unLikeFeed({
    int userId,
  }) {
    this.widget.unLikeFeed(
          context: context,
          feedId: this.widget.id,
          userId: userId,
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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            width: double.infinity,
            height: 55,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      this.widget.creator['profileImageUrl'],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.widget.creator['userName'],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        this.widget.title,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Colors.white,
                    iconSize: this._iconSize,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[400], width: 0.5),
                bottom: BorderSide(color: Colors.grey[400], width: 0.5),
              ),
            ),
            child: ClipRRect(
              child: this.widget.videoUrl != null
                  ? Video(url: this.widget.videoUrl)
                  : this.widget.imageUrl == null
                      ? null
                      : Image.network(
                          this.widget.imageUrl,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 57,
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: FutureBuilder(
                    future: Provider.of<UserProvider>(context, listen: false)
                        .getCurrentUser(userId),
                    builder: (ctx, currentUserSnapshot) =>
                        currentUserSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? IconButton(
                                icon: Icon(Icons.favorite_border),
                                color: Colors.white,
                                iconSize: this._iconSize,
                                onPressed: () {},
                              )
                            : IconButton(
                                icon: this.widget.isLiked
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                                color: this.widget.isLiked
                                    ? Colors.pink
                                    : Colors.white,
                                iconSize: this._iconSize,
                                onPressed: this.widget.isLiked
                                    ? () => this.unLikeFeed(
                                          userId: userId,
                                        )
                                    : () => this.likeFeed(
                                          currentUser: currentUserSnapshot.data,
                                        ),
                              ),
                  ),
                  // child: FutureBuilder(
                  //     future: Provider.of<LikeProvider>(context,listen: false).feedIsLiked(this.widget.id, userId),
                  //     builder: (ctx, isLikedSnapshot) => isLikedSnapshot.connectionState == ConnectionState.waiting ?
                  //     Icon(
                  //       Icons.favorite_border,
                  //       color: Colors.white,
                  //     ) : IconButton(
                  //     icon: Icon(
                  //       isLikedSnapshot.data ? Icons.favorite : Icons.favorite_border
                  //     ),
                  //     color: isLikedSnapshot.data ? Colors.pinkAccent[400] : Colors.white,
                  //     iconSize: this._iconSize,
                  //     onPressed: () {
                  //       // setState(() {
                  //       //   isLiked = !this.isLiked;
                  //       // });
                  //     },
                  //   ),
                  // ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    iconSize: this._iconSize,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        CommentScreen.routeName,
                        arguments: this.widget.id,
                      );
                    },
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    iconSize: this._iconSize,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 8,
                  child: SizedBox(
                    width: double.infinity,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.bookmark_border),
                    iconSize: this._iconSize,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              '${this.widget.likes} likes',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey[350],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              this.widget.content,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              children: [
                CircularProfileItem(
                  imageUrl: this.widget.currentUser.profileImageUrl,
                  haveBorder: false,
                  radius: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: this._controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelStyle: null,
                      hintText: 'Add Your Comment',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text('Post'),
                  textColor: Colors.blue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
