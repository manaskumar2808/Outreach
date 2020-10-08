import 'package:flutter/foundation.dart';

class Comment {
  String id;
  String text;
  Map<String, dynamic> commentor;
  int feedId;

  Comment({
    @required this.id,
    @required this.text,
    @required this.commentor,
    @required this.feedId,
  });
}
