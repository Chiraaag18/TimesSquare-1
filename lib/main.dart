import 'package:flutter/material.dart';

import 'package:news/screens/about.dart';
import 'package:news/screens/cat_news.dart';
import 'package:news/screens/homescreen.dart';
import 'package:news/screens/intro.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 


  @override
  initState() {
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project   
     // If you have skipped STEP 3 then change app_icon to @mipmap/ic_launcher
   
  }
 
  @override
  Widget build(BuildContext context) {
     
    return 
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       navigatorKey: GlobalKey(),
       
      // Setup an observer that will save the current route into the saved state

      
      home: OnBoardingPage(),
      routes: {
        '/Category_Screen': (ctx)=>CategoryNews(),
        '/home_screen':(ctx)=> HomeScreen(),
        '/about':(ctx)=> About(),
        '/intro': (ctx)=> OnBoardingPage(),
      },
    );
  }
  
}

