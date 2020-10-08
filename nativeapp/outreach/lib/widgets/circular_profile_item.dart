import 'package:flutter/material.dart';

class CircularProfileItem extends StatelessWidget {
  final String imageUrl;

  final double radius;
  final bool haveBorder;

  CircularProfileItem({
    this.imageUrl,
    this.radius,
    this.haveBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.haveBorder ? const EdgeInsets.all(2) : const EdgeInsets.all(0),
        height: this.radius * 2,
        width: this.radius * 2,
        decoration: this.haveBorder ? BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              Color(0xff20f7f0),
              Color(0xff8d05fc),
            ],
          ),
        ) : null,
        child: Container(
          padding: this.haveBorder ? const EdgeInsets.all(2) : const EdgeInsets.all(0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            border: this.haveBorder ? null : Border.all(color: Colors.grey[350],width: 1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: this.imageUrl == null ? Image.asset(
              'assets/images/profile-default.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ) : Image.network(
              this.imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ));
  }
}
