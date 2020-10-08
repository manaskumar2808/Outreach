import 'package:flutter/foundation.dart';

class Feed {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final String videoUrl;
  final Map<String, dynamic> creator;

  Feed({
    @required this.id,
    @required this.title,
    this.content,
    this.imageUrl,
    this.videoUrl,
    @required this.creator,
  });
}
