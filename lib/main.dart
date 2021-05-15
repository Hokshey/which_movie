//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/popular.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:connectivity/connectivity.dart';
import 'upComing.dart';

void main() {
  runApp(MyMovies());
}

class MyMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget widget) {
        Widget error = Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator)
          error = Scaffold(body: Center(child: error));
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) => error;
        return widget;
      },
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
      routes: {
        'popular': (context) => PopbularList(),
        'upComing': (context) => UpComingMovie(),
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return buildSplashScreen();
    // return MovieList();
  }

  SplashScreen buildSplashScreen() {
    return new SplashScreen(
      seconds: 1,
      navigateAfterSeconds: new UpComingMovie(),
      title: new Text(
        'Movie...',
        style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      image: new Image.asset('images/splash.jpg'),
      photoSize: 200,
      backgroundColor: Colors.orange,
    );
  }
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        Container(
          height: 90,
          child: DrawerHeader(
            margin: EdgeInsets.all(2.0),
            padding: EdgeInsets.only(left: 100, top: 20),
            child: Text(
              'Movie',
              style: TextStyle(fontSize: 36.0, color: Colors.white),
            ),
            decoration: BoxDecoration(color: Colors.deepOrange),
          ),
        ),
        ListTile(
          tileColor: Colors.orange,
          title: Text(
            'Popular Movie',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          trailing: Icon(Icons.arrow_forward_sharp, color: Colors.white),
          onTap: () => Navigator.pushReplacementNamed(context, 'popular'),
        ),
        ListTile(
          tileColor: Colors.orangeAccent,
          title: Text(
            'Up coming Movie',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          trailing: Icon(Icons.arrow_forward_sharp, color: Colors.white),
          onTap: () => Navigator.pushReplacementNamed(context, 'upComing'),
        )
      ],
    ),
  );
}
