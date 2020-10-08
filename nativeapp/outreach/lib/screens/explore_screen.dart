import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/feed_provider.dart';

import '../widgets/skeleton.dart';

class ExploreScreen extends StatelessWidget {
  static const String routeName = 'explore/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
        centerTitle: false,
        toolbarHeight: 50,
        title: Container(
          height: 50,
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Outreach',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Sincery Bartlow',
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
            future: Provider.of<FeedProvider>(context, listen: false).feeds,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) => AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                            ),
                            child: snapshot.data[index].videoUrl != null
                                ? null
                                : Image.network(
                                    snapshot.data[index].imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                          ),
                        ),
                      )),
      ),
    );
  }
}
