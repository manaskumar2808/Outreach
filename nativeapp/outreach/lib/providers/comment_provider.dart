import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/base_url.dart';

import '../models/comment.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments;

  List<Comment> get comments {
    return [...this._comments];
  }

  Future<void> fetchAndSetFeedComments(int feedId) async {
    final response =
        await http.get(baseUrl + 'comment/' + feedId.toString() + '/comments/');

    final responseData = json.decode(response.body) as List<dynamic>;

    List<Comment> loadedComments = [];

    responseData.forEach((comment) {
      loadedComments.add(Comment(
        id: comment['id'],
        text: comment['text'],
        commentor: comment['commentor'],
        feedId: comment['feed'],
      ));
    });

    return loadedComments;
  }

  Future<void> addComment({
    String text,
    Map<String, dynamic> commentor,
    int feedId,
  }) async {
    final commentData = {
      "text": text,
      "commentor": commentor,
      "feed": feedId,
      "status": "direct",
    };
    final response = await http.post(baseUrl + 'comment/create/',
        body: json.encode(commentData),
        headers: {
          'Content-type': 'application/json',
        });
    this.fetchAndSetFeedComments(feedId);
    notifyListeners();
  }
}
