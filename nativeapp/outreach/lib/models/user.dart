import 'package:flutter/foundation.dart';

class User {
  int userId;
  String userName;
  String email;
  String profileImageUrl;
  String firstName;
  String lastName;
  String phoneNo;

  User({
    @required this.userId,
    @required this.userName,
    @required this.email,
    this.profileImageUrl,
    this.firstName,
    this.lastName,
    this.phoneNo,
  });
  
}
