import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String url;
  final bool show;

  Video({
    @required this.url,
    this.show = false,
  });

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = VideoPlayerController.network(this.widget.url)
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: this._controller.value.initialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (this._controller.value.isPlaying) {
                      this._controller.pause();
                    } else {
                      this._controller.play();
                    }
                  });
                },
                child: Stack(
                  children: [
                    AspectRatio(
                      child: VideoPlayer(this._controller),
                      aspectRatio: 1 / 1,
                    ),
                    this.widget.show ? 
                    Container(
                      child: Positioned(
                        top: 5,
                        right: 5,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ) : 
                    Container(
                      child: Center(
                        child: this._controller.value.isPlaying
                            ? null
                            : Icon(
                                Icons.play_circle_outline,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ));
  }
}
