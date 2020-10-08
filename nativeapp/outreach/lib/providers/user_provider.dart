import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/base_url.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  User _currentUser;

  Future<List<User>> get users async {
    final response = await http.get(baseUrl + 'user/profile/');
    final responseData = json.decode(response.body) as List<dynamic>;
    List<User> loadedUsers = [];
    responseData.forEach((user) {
      loadedUsers.add(User(
        userId: user['user'],
        userName: user['userName'],
        email: user['email'],
        profileImageUrl: user['profileImageUrl'],
        firstName: user['firstName'],
        lastName: user['lastName'],
        phoneNo: user['phoneNo'],
      ));
    });

    this._users = loadedUsers;
    return [...this._users];
  }

  Future<User> getCurrentUser(int id) async {
    final response =
        await http.get(baseUrl + 'user/profile/detail/' + id.toString() + '/');
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    final user = User(
      userId: id,
      userName: responseData['userName'],
      email: responseData['email'],
      profileImageUrl: responseData['profileImageUrl'],
      firstName: responseData['firstName'],
      lastName: responseData['lastName'],
      phoneNo: responseData['phoneNo'],
    );
    this._currentUser = user;
    return this._currentUser;
  }
}
