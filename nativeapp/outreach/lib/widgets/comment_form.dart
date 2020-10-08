import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';

import './circular_profile_item.dart';

class CommentForm extends StatefulWidget {
  final feedId;
  String replyCommentId;
  bool isReply;
  String replyCommentUserName;
  final Function(
      {BuildContext context,
      User currentUser,
      int feedId,
      String text}) submitComment;
  final Function(
      {BuildContext context,
      User currentUser,
      String commentId,
      String text}) submitReply;

  CommentForm({
    @required this.feedId,
    this.replyCommentId,
    this.isReply = false,
    this.replyCommentUserName,
    @required this.submitComment,
    @required this.submitReply,
  });

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  TextEditingController _controller = TextEditingController();

  bool canPost = false;

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (this.widget.isReply) {
      this._controller.text = '@${this.widget.replyCommentUserName} ';
    }
    super.didChangeDependencies();
  }

  void submitComment({
    User currentUser,
  }) async {
    await this.widget.submitComment(
          context: context,
          currentUser: currentUser,
          feedId: this.widget.feedId,
          text: this._controller.text,
        );
    this._controller.text = '';
  }

  void submitReply({
    User currentUser,
  }) async {
    await this.widget.submitReply(
          context: context,
          currentUser: currentUser,
          commentId: this.widget.replyCommentId,
          text: this._controller.text,
        );
    this._controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final id = Provider.of<AuthProvider>(context, listen: false).userId;

    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .getCurrentUser(id),
              builder: (context, currentUserSnapshot) =>
                  currentUserSnapshot.connectionState == ConnectionState.waiting
                      ? CircularProfileItem(
                          imageUrl: null,
                          haveBorder: false,
                          radius: 21,
                        )
                      : CircularProfileItem(
                          imageUrl: currentUserSnapshot.data.profileImageUrl,
                          haveBorder: false,
                          radius: 21,
                        ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 9,
            child: TextField(
              style: TextStyle(color: Colors.white),
              controller: this._controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add Your Comment...',
                labelStyle: null,
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
              onChanged: (value) => this.setState(() {
                this._controller.text = value;
              }),
            ),
          ),
          Flexible(
            flex: 3,
            child: FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .getCurrentUser(id),
              builder: (context, currentUserSnapshot) =>
                  currentUserSnapshot.connectionState == ConnectionState.waiting
                      ? FlatButton(
                          child: Text('Post'),
                          textColor: Colors.blue,
                          disabledTextColor: Colors.lightBlue[800],
                          onPressed: null,
                        )
                      : FlatButton(
                          child: Text('Post'),
                          textColor: Colors.blue,
                          disabledTextColor: Colors.lightBlue[800],
                          onPressed: () {
                            this.widget.isReply
                                ? this.submitReply(
                                    currentUser: currentUserSnapshot.data,
                                  )
                                : this.submitComment(
                                    currentUser: currentUserSnapshot.data,
                                  );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
