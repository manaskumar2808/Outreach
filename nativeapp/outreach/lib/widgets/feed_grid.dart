import 'package:flutter/material.dart';
import 'package:outreach/widgets/video.dart';

class FeedGrid extends StatelessWidget {
  final feedList;

  FeedGrid({
    this.feedList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: (MediaQuery.of(context).size.width/3)*(this.feedList.length/3 + (this.feedList.length%3 == 0 ? 0 : 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: this.feedList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width/3,
              height: MediaQuery.of(context).size.width/3,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[750],
              ),
              child: this.feedList[index].videoUrl != null ? 
              Video(url: this.feedList[index].videoUrl,show: true,) : Image.network(
                this.feedList[index].imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
