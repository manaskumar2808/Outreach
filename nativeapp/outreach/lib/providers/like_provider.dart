import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/base_url.dart';

class LikeProvider with ChangeNotifier {
  Future<int> feedLikes(int id) async {
    final response =
        await http.get(baseUrl + 'like/' + id.toString() + '/likes/count/');
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final value = responseData['count'];
    print('$id - $value');
    return responseData['count'];
  }

  Future<bool> feedIsLiked(int id, int userId) async {
    print('$id feed like checking...');
    final response = await http.get(baseUrl +
        'like/' +
        id.toString() +
        '/likes/' +
        userId.toString() +
        '/');
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final value = responseData['isLiked'];
    return responseData['isLiked'];
  }

  Future<void> likeFeed({
    Map<String, dynamic> liker,
    int feedId,
  }) async {
    final likeData = {
      'parent': 'feed',
      'liker': liker,
      'feed': feedId,
    };
    final response = await http.post(
      baseUrl + 'like/create/',
      body: json.encode(likeData),
      headers: {
        'Content-type': 'application/json',
      },
    );

    notifyListeners();
  }

  Future<void> unLikeFeed({
    int userId,
    int feedId,
  }) async {
    final response = await http.delete(
      baseUrl +
          'like/' +
          feedId.toString() +
          '/unlike/' +
          userId.toString() +
          '/',
      headers: {
        'Content-type': 'application/json',
      },
    );

    notifyListeners();
  }

  Future<int> commentLikes(String id) async {
    final response = await http
        .get(baseUrl + 'like/' + id.toString() + '/comment/likes/count/');

    final responseData = json.decode(response.body) as Map<String, dynamic>;
    return responseData['count'];
  }

  Future<bool> commentIsLiked(String id, int userId) async {
    final response = await http.get(baseUrl +
        'like/' +
        id.toString() +
        '/comment/likes/' +
        userId.toString() +
        '/');

    final responseData = json.decode(response.body) as Map<String, dynamic>;
    return responseData['isLiked'];
  }

  Future<void> likeComment({
    Map<String, dynamic> liker,
    String commentId,
  }) async {
    final likeData = {
      'parent': 'comment',
      'comment': commentId,
      'liker': liker,
    };
    final response = await http
        .post(baseUrl + 'like/create/', body: json.encode(likeData), headers: {
      'Content-type': 'application/json',
    });

    notifyListeners();
  }

  Future<void> unLikeComment({
    int userId,
    String commentId,
  }) async {
    final response = await http.delete(
      baseUrl +
          'like/' +
          commentId +
          '/comment/unlike/' +
          userId.toString() +
          '/',
      headers: {
        'Content-type': 'application/json',
      },
    );

    notifyListeners();
  }
}
