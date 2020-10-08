import 'package:flutter/foundation.dart';

class Reply {
  String text;
  Map<String, dynamic> replier;
  String commentId;

  Reply({
    @required this.text,
    @required this.replier,
    @required this.commentId,
  });
}
