import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/base_url.dart';

import '../models/feed.dart';

class FeedProvider with ChangeNotifier {
  List<Feed> _feeds = [];

  Future<List<Feed>> get feeds async {
    await this.fetchAndSetFeeds();
    return [...this._feeds];
  }

  Future<void> fetchAndSetFeeds() async {
    final response = await http.get(baseUrl + 'feed/');
    final responseData = json.decode(response.body)
        as List<dynamic>; // List<Map<String, dynamic>>
    List<Feed> loadedFeeds = [];
    responseData.forEach((feed) {
      loadedFeeds.add(Feed(
        id: feed['id'],
        title: feed['title'],
        content: feed['content'],
        imageUrl: feed['imageUrl'],
        videoUrl: feed['videoUrl'],
        creator: feed['creator'],
      ));
    });
    this._feeds = loadedFeeds;
    notifyListeners();
  }

  Future<List<Feed>> fetchAndSetUserFeeds({int id}) async {
    final response =
        await http.get(baseUrl + 'feed/' + id.toString() + '/feeds/');
    final responseData = json.decode(response.body) as List<dynamic>;
    List<Feed> loadedUserFeeds = [];
    responseData.forEach((feed) {
      loadedUserFeeds.add(Feed(
        id: feed['id'],
        title: feed['title'],
        content: feed['content'],
        imageUrl: feed['imageUrl'],
        videoUrl: feed['videoUrl'],
        creator: feed['creator'],
      ));
    });
    return loadedUserFeeds;
  }

  Future<void> addFeed({
    String newTitle,
    String newContent,
    String newImageUrl,
    String newVideoUrl,
  }) async {
    final encodedData = json.encode({
      "title": newTitle,
      "content": newContent,
      "imageUrl": newImageUrl,
      "videoUrl": newVideoUrl,
    });
    print(encodedData);
    final response =
        await http.post('http://192.168.225.216:8000/api/feed/create/',
            headers: {
              'Content-Type': 'application/json',
            },
            body: encodedData);
    // this._feeds.add(Feed(
    //       title: newTitle,
    //       content: newContent,
    //       imageUrl: newImageUrl,

    //     ));

    notifyListeners();
  }
}
