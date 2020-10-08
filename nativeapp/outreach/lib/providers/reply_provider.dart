import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/base_url.dart';

import '../models/reply.dart';

class ReplyProvider with ChangeNotifier {
  List<Reply> _replies;

  List<Reply> get replies {
    return [...this.replies];
  }

  Future<List<Reply>> fetchAndSetReplies({String commentId}) async {
    final response =
        await http.get(baseUrl + 'comment/' + commentId + '/replies/');
    final responseData = json.decode(response.body) as List<dynamic>;
    List<Reply> loadedReplies = [];
    responseData.forEach((reply) {
      loadedReplies.add(Reply(
        text: reply['text'],
        commentId: reply['comment'],
        replier: reply['replier'],
      ));
    });

    return loadedReplies;
  }

  Future<void> addReply({
    String text,
    String commentId,
    Map<String, dynamic> replier,
  }) async {
    final replyData = {
      "text": text,
      "comment": commentId,
      "replier": replier,
    };
    final response = await http.post(baseUrl + 'comment/reply/create/',
        body: json.encode(replyData),
        headers: {'Content-type': 'application/json'});
    this.fetchAndSetReplies(commentId: commentId);
    notifyListeners();
  }
}
