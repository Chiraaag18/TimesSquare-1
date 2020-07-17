import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'package:url_launcher/url_launcher.dart';


class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile({this.imgUrl, this.desc, this.title, this.content, @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return 
       InkWell(onTap: ()async=>{await launch(posturl,forceWebView: true),},
                child: Container(
            margin: EdgeInsets.only(bottom: 24),
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          imgUrl,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 12,),
                    Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      desc,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    Row(children: <Widget>[SizedBox(width:305),IconButton(icon: Icon(Icons.share),onPressed: ()=>Share.share('Hey Check this news out  '+ posturl),)])
                  ],
                ),
              ),
            )
    ),
       );
  }
}