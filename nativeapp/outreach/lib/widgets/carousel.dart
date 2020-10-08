import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  var currentIndex = 0;
  List carouselImages = [
    {
      'index': 0,
      'image': 'beach.jpg',
    },
    {
      'index': 1,
      'image': 'city.jpg',
    },
    {
      'index': 2,
      'image': 'gorge.jpg',
    },
    {
      'index': 3,
      'image': 'heart.jpg',
    },
    {
      'index': 4,
      'image': 'neon.jpg',
    },
    {
      'index': 5,
      'image': 'new-york-city.jpg',
    },
    {
      'index': 6,
      'image':  'rose.jpg',
    },
    {
      'index': 7,
      'image':  'sunflowers.jpg',
    },
    {
      'index': 8,
      'image':  'winding-road.jpg',
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  this.currentIndex = index;
                });
              },
            ),
            items: this.carouselImages.map((image) {
              return Builder(
                builder: (context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/slideshow/' + image['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: this.carouselImages.map((image) {
              return Builder(
                builder: (context) {
                  return Container(
                      height: 5,
                      width: 5,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: this.currentIndex == image['index'] ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                  );
                },
              );
            }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
