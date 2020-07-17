import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news/models/category_model.dart';

import 'package:news/widgets/categorycard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:share/share.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends PreferredSize {
  final Widget child;
  final double height;

  CustomAppBar({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(blurRadius: 25.0, spreadRadius: 5.0, color: Colors.white)
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Row(
            children: <Widget>[
              SizedBox(width: 140),
              Text('Times ',
                  style: GoogleFonts.blackHanSans(
                      textStyle: TextStyle(color: Colors.black, fontSize: 20))),
              Image.asset(
                'assets/newss.png',
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<CategorieModel> categories = [
  CategorieModel(imageAssetUrl: 'assets/virus.png', categorieName: 'Covid-19'),
  CategorieModel(
      imageAssetUrl: 'assets/graduation.png', categorieName: 'General'),
  CategorieModel(imageAssetUrl: 'assets/medal.png', categorieName: 'Sports'),
  CategorieModel(
      imageAssetUrl: 'assets/film.png', categorieName: 'Entertainment'),
  CategorieModel(
      imageAssetUrl: 'assets/revenue.png', categorieName: 'Business'),
  CategorieModel(
      imageAssetUrl: 'assets/processor.png', categorieName: 'Technology'),
  CategorieModel(
      imageAssetUrl: 'assets/chemistry.png', categorieName: 'Science'),
  CategorieModel(imageAssetUrl: 'assets/airplane.png', categorieName: 'Travel'),
  CategorieModel(imageAssetUrl: 'assets/hat.png', categorieName: 'Fashion'),
  CategorieModel(
      imageAssetUrl: 'assets/conference.png', categorieName: 'Politics')
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  bool ishindi = false;
  bool isenglish = false;
  bool isloading = true;

  fetchnews() async {
    var response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=5bdee0d2641c4e6092827ab728d8b9d3');
    setState(() {
      var converted = json.decode(response.body);
      data = converted['articles'];
      isloading = false;
    });
  }

  void convert(String title, String description, String lan) {
    translator.translate(description, to: lan).then((s) => {
          setState(() {
            translateddes = s;
            ischanged = true;
          })
        });
    translator.translate(title, to: lan).then((s) => {
          setState(() {
            translatedtit = s;
            ischanged = true;
          })
        });
  }

  Widget newscard(int i) {
    return Card(
        elevation: 10,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              data[i]['urlToImage'] == null
                  ? Image.network(
                      'https://cdn.dribbble.com/users/1554526/screenshots/3399669/no_results_found.png')
                  : Image.network(data[i]['urlToImage']),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: data[i]['title'] == null
                    ? Text(
                        'Top Headlines',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    : ischanged
                        ? Text(
                            translatedtit,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        : Text(
                            data[i]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
              ),
              SizedBox(height: 5),
              data[i]['author'] == null
                  ? Text(
                      'Unkown Source',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )
                  : Text(
                      'By ' + data[i]['author'],
                      textAlign: TextAlign.right,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
              SizedBox(height: 25),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: data[i]['description'] == null
                    ? Text('No description')
                    : ischanged
                        ? Text(
                            translateddes,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          )
                        : Text(
                            data[i]['description'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.normal,
                                fontSize: 18),
                          ),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  SizedBox(width: 85),
                  FlatButton.icon(
                    label: Text('Read More!'),
                    color: Colors.lightBlueAccent,
                    onPressed: () async =>
                        {await launch(data[i]['url'], forceWebView: true)},
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(width: 5),
                  ishindi & !isenglish
                      ? FlatButton.icon(
                          onPressed: () => {
                            setState(() {
                              convert(data[i]['title'], data[i]['description'],
                                  'en');

                              isenglish = true;
                            })
                          },
                          color: Colors.blue,
                          label: Text(
                            'English',
                          ),
                          icon: Icon(Icons.translate),
                        )
                      : FlatButton.icon(
                          onPressed: () => {
                            setState(() {
                              convert(data[i]['title'], data[i]['description'],
                                  'hi');

                              ishindi = true;
                            })
                          },
                          color: Colors.lightBlueAccent,
                          label: Text(
                            'Hindi',
                          ),
                          icon: Icon(Icons.translate),
                        ),
                ],
              ),
              SizedBox(height: 15),
              Center(
                child: FlatButton(
                  onPressed: () =>
                      Share.share('Hey! Check this news out  ' + data[i]['url']),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  shape: CircleBorder(),
                  color: Colors.black,
                ),
              )
            ],
          ),
        ));
  }

  void initState() {
    super.initState();
    fetchnews();
  }

  String translateddes;
  String translatedtit;
  bool ischanged = false;

  final translator = GoogleTranslator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            height: 95,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    SizedBox(width: 165),
                    Text('NewsApp',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            )),
        body: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed('/Category_Screen', arguments: {
                          'name': categories[index].categorieName,
                          'url': categories[index].imageAssetUrl
                        }),
                        child: CategoryCard(
                          imageAssetUrl: categories[index].imageAssetUrl,
                          categoryName: categories[index].categorieName,
                        ),
                      );
                    })),
            Expanded(
              child: isloading
                  ? Center(child: CircularProgressIndicator())
                  : Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return newscard(index);
                      },
                      onIndexChanged: (index) {
                        setState(() {
                          ischanged = false;
                          ishindi = false;
                          isenglish = false;
                        });
                      },
                      indicatorLayout: PageIndicatorLayout.COLOR,
                      autoplay: false,
                      itemCount: data.length,
                      pagination: new SwiperPagination(),
                      control: new SwiperControl(),
                    ),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ));
  }
}
