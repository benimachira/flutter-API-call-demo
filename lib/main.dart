import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'views/VideoCellView.dart';
import 'views/DetailsPage.dart';

void main() => runApp(new RealWorldApp());

class RealWorldApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RealWorldAppState();
  }
}

class RealWorldAppState extends State<RealWorldApp> {
  var _is_loading = false;
  var videos;

  _fetch_data() async {
    print("attempting to fetch data from the net");
    final test_url = "https://api.letsbuildthatapp.com/youtube/home_feed";

    final response = await http.get(test_url);

    if (response.statusCode == 200) {
      print(response.body);
      final map = json.decode(response.body);

      final json_vids = map["videos"];

//      json_vids.forEach((video) {
//        print(video["name"] + "\n");
//      });

      setState(() {
        _is_loading = false;
        this.videos = json_vids;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("The real deal"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("shit is refreshing");

                setState(() {
                  _is_loading = true;
                });

                _fetch_data();
              },
            )
          ],
        ),
        body: new Center(
          child: _is_loading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.videos != null ? this.videos.length : 0,
                  itemBuilder: (context, i) {
                    //this videos is the dictionary created from the json
                    var videos = this.videos[i];

                    //return the widget tree for
                    return FlatButton(
                      child: new VideoCellView(videos),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>  new DetailsPage()
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
