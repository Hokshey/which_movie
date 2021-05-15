import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/http_helper.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/movie_details.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpComingMovie extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<UpComingMovie> {
  HttpHelper helper;
  String result;
  List movies;
  int moviesCount;
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('UpComing Movies');
  @override
  void initState() {
    // TODO: implement initState
    helper = HttpHelper();
    initialize();

    result = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getConnetion(context);
    // buildListView();
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {
                if (this.visibleIcon.icon == Icons.search) {
                  this.visibleIcon = Icon(Icons.cancel);
                  this.searchBar = TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (text) {
                      search(text);
                    },
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                } else {
                  setState(() {
                    this.visibleIcon = Icon(Icons.search);
                    this.searchBar = Text('UpComing Movies');
                  });
                }
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {
          initialize();
        }),
        child: buildListView(),
      ),
      drawer: buildDrawer(context),
    );
  }

  ListView buildListView() {
    NetworkImage image;
    return ListView.builder(
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        itemBuilder: (BuildContext context, int position) {
          if (movies[position].posterPath != null) {
            image = NetworkImage(iconBase + movies[position].posterPath);
          } else {
            image = NetworkImage(defaultImage);
          }

          return Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                title: Text(movies[position].title),
                subtitle: Text('Released: ' +
                    movies[position].releaseDate +
                    ' - Vote: ' +
                    movies[position].voteAverage.toString()),
                leading: CircleAvatar(
                  backgroundImage: image,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetail(movies[position])));
                },
              ));
        });
  }

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }
}

getConnetion([BuildContext context]) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected455555555555555');
    }
  } on SocketException catch (_) {
    Alert(
      context: context,

      type: AlertType.warning,
      title: "No Internet Connection...",
      // desc: "..",
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => exit(0),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}
