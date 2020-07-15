import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 14),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Row(
              children: <Widget>[
                SizedBox(width: 40),
                Image.asset(
                  imageAssetUrl,
                  height: 40,
                  width: 40,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.black26),
            child: Column(
              children: <Widget>[SizedBox(height:40),
                Text(
                  categoryName,
                  style: GoogleFonts.amaranth(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
