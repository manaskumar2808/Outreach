import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../api/base_url.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  int _userId;
  String _userName;

  Future<bool> get isAuthenticated async {
    final prefs = await SharedPreferences.getInstance();
    this._token = prefs.getString('token');
    this._userId = prefs.getInt('userId');
    this._userName = prefs.getString('userName');
    print(this._token);
    print(this._userId);
    print(this._userName);
    return this._token != null;
  }

  Future<void> login({
    String userName,
    String password,
  }) async {
    Map<String, String> authData = {
      'username': userName,
      'password': password,
    };
    final response = await http.post(
      baseUrl + 'user/auth-login/',
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(authData),
    );

    final responseData = json.decode(response.body) as Map<String, dynamic>;
    this._token = responseData['token'];
    this._userId = responseData['id'];
    this._userName = responseData['username'];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', this._token);
    prefs.setInt('userId', this._userId);
    prefs.setString('userName', this._userName);
  }

  Future<void> signup({
    String userName,
    String email,
    String password,
  }) async {
    Map<String, String> authData = {
      'username': userName,
      'email': email,
      'password': password,
    };
    final response = await http.post(
      baseUrl + 'user/auth-register/',
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(authData),
    );

    final responseData = json.decode(response.body) as Map<String, dynamic>;
    this._userId = responseData['userId'];
    this._userName = responseData['username'];

    final profileData = {
      "userName": this._userName,
      "email": email,
      "profileImageUrl": null,
      "firstName": null,
      "lastName": null,
      "phoneNo": null,
      "user": this.userId,
    };

    final profileCreateResponse = await http.post(
      baseUrl + 'profile/create/',
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(profileData),
    );

    final profileCreateResponseData =
        json.decode(profileCreateResponse.body) as Map<String, dynamic>;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    this._token = null;
    this._userId = null;
    this._userName = null;
  }

  int get userId {
    return this._userId;
  }

  String get token {
    return this._token;
  }

  String get userName {
    return this._userName;
  }
}
