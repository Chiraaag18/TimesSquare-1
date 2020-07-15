import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news/widgets/newstile.dart';

class CategoryNews extends StatefulWidget {
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
 
 
 String categoryName;
 String categoryUrl;
 List data = [];
 bool isloading=true;

  fetchnews() async {
    var response = await http.get(
        'https://newsapi.org/v2/everything?q=$categoryName&pageSize=90&sortBy=popularity&apiKey=5bdee0d2641c4e6092827ab728d8b9d3');
    setState(() {
      var converted = json.decode(response.body);
      data = converted['articles'];
      isloading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
   final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
  categoryName= routeArgs['name'];
  categoryUrl= routeArgs['url'];
   fetchnews();
    return 
     Scaffold(
      appBar: PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: AppBar(
          title: Column(
            children: <Widget>[
              SizedBox(height:4)
              ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  Container(child:Image.asset(categoryUrl),height: 30,)
                  ,SizedBox(width:5)
                  ,Text(
                    categoryName,
                    
              
                    style:
                    GoogleFonts.blackHanSans(textStyle: TextStyle(color:Colors.black)
                  ),
                  )
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.share,)),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      body: isloading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile(
                      imgUrl: data[index]['urlToImage'] ?? "",
                      title: data[index]['title'] ?? "",
                      desc: data[index]['description'] ?? "",
                      content: data[index]['content'] ?? "",
                      posturl: data[index]['url'] ?? "",
                    );
                  }),
            ),
        ),
      ),
    );
  }  
}