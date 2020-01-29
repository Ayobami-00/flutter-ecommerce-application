import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          
          Category(
            image_caption: "shirt",
            image_location: "images/cats/tshirt.png",
          ),

          Category(
            image_caption: "dress",
            image_location: "images/cats/dress.png",
          ),

          Category(
            image_caption: "pants",
            image_location: "images/cats/jeans.png",
          ),

          Category(
            image_caption: "formal",
            image_location: "images/cats/formal.png",
          ),

          Category(
            image_caption: "informal",
            image_location: "images/cats/informal.png",
          ),


        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 80.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 40.0,
              height: 40.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption),
            ),
          ),
        ),
      ),
    );
  }
}
