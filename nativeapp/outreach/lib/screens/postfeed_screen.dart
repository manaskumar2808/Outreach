import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/post_form.dart';

import '../providers/feed_provider.dart';

class PostFeedScreen extends StatelessWidget {
  void submitPost({
    BuildContext context,
    String title,
    String content,
    String imageUrl,
    String videoUrl,
  }) async {
    try {
      await Provider.of<FeedProvider>(context,listen: false).addFeed(
        newTitle: title,
        newContent: content,
        newImageUrl: imageUrl,
        newVideoUrl: videoUrl,
      );
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add Post',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.black,
        child: PostForm(
          submitPost: this.submitPost,
        ),
      ),
    );
  }
}
