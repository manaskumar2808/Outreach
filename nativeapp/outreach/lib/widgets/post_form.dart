import 'package:flutter/material.dart';

import '../validators/feed_validators.dart';

class PostForm extends StatefulWidget {
  void Function({
    BuildContext context,
    String title,
    String content,
    String imageUrl,
    String videoUrl,
  }) submitPost;

  String title;
  String content;
  String imageUrl;
  String videoUrl;

  PostForm({
    @required this.submitPost,
  });

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _form = GlobalKey<FormState>();

  void submitPostForm() {
    this.widget.submitPost(
          context: context,
          title: this.widget.title,
          content: this.widget.content,
          imageUrl: this.widget.imageUrl,
          videoUrl: this.widget.videoUrl,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: this._form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[850],
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromRGBO(128, 126, 126, 1),
                  //     Color.fromRGBO(181, 179, 179, 1),
                  //   ],
                  //   begin: FractionalOffset.topLeft,
                  //   end: FractionalOffset.bottomRight,
                  // ),
                ),
                child: this.widget.imageUrl == null
                    ? Center(
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          this.widget.imageUrl,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: TextFormField(
                  key: ValueKey('title'),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                  ),
                  validator: (value) => titleValidator(value),
                  onChanged: (value) {
                    setState(() {
                      this.widget.title = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.widget.title = newValue;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: TextFormField(
                  key: ValueKey('content'),
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                    ),
                  ),
                  validator: (value) => contentValidator(value),
                  onChanged: (value) {
                    setState(() {
                      this.widget.content = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.widget.content = newValue;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: TextFormField(
                  key: ValueKey('imageUrl'),
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  validator: (value) => imageUrlValidator(value),
                  onChanged: (value) {
                    setState(() {
                      this.widget.imageUrl = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.widget.imageUrl = newValue;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: TextFormField(
                  key: ValueKey('videoUrl'),
                  decoration: InputDecoration(
                    hintText: 'Video URL',
                    hintStyle: TextStyle(color: Colors.grey[350]),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  validator: (value) => videoUrlValidator(value),
                  onChanged: (value) {
                    setState(() {
                      this.widget.videoUrl = value;
                    });
                  },
                  onSaved: (newValue) {
                    this.widget.videoUrl = newValue;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 30,
              //   child: RaisedButton(
              //     onPressed: () {},
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //     elevation: 0,
              //     padding: const EdgeInsets.all(0),
              //     materialTapTargetSize: MaterialTapTargetSize.padded,
              //     textColor: Colors.white,
              //     child: Ink(
              //       decoration: BoxDecoration(
              //         gradient: LinearGradient(
              //           colors: [
              //             Color.fromRGBO(254, 107, 139, 1),
              //             Color.fromRGBO(255, 143, 83, 1)
              //           ],
              //           begin: FractionalOffset.topLeft,
              //           end: FractionalOffset.bottomRight,
              //         ),
              //       ),
              //       child: Container(
              //         constraints: BoxConstraints(
              //           maxWidth: 300,
              //           minHeight: 30,
              //         ),
              //         child: Text('Post'),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: 50.0,
                child: RaisedButton(
                  onPressed: this.submitPostForm,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff0526fc), Color(0xff00bfff)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 350.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Post",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
