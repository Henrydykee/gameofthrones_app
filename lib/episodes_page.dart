import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'got.dart';

class EpisodePage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage myImage;
  EpisodePage({this.episodes, this.myImage});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          children: <Widget>[
             Hero(tag: "g1",
               child: CircleAvatar(
                 backgroundImage: NetworkImage(myImage.medium),
               ),
             ),
            SizedBox(width: 10.0,),
            Text("All Episodes")
          ],
        ),
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        itemCount: episodes.length,
        itemBuilder: (context, index) => Card(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    episodes[index].image.original,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          episodes[index].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    top: 0.0,
                    child: Container(
                      color: Colors.purple,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${episodes[index].season}-${episodes[index].number}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
