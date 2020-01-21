import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameofthrones_app/episodes_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'got.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";
  GOT got;

  @override
  void initState() {
    super.initState();
    fetchEpisodies();
  }

  Widget Body() {
    return got == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : myCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Game Of Thrones"),
      ),
      body: Body(),
    );
  }

  void fetchEpisodies() async {
    var res = await http.get(url);
    var decodesResponse = jsonDecode(res.body);
    print(res);
    got = GOT.fromJson(decodesResponse);
    setState(() {});
  }

  Widget myCard() {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: "g1",
                child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(got.image.original)),
              ),
              Text(
                got.name,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Runtime: ${got.runtime.toString()} minutes",
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                got.summary,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                color: Colors.purple,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EpisodePage(
                        episodes: got.eEmbedded.episodes,
                        myImage: got.image,
                      )));
                },
                child: Text(
                  "All Episodes",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
