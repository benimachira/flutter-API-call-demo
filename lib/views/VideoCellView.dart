import 'package:flutter/material.dart';


class VideoCellView extends StatelessWidget {
  //create a constructor for this video class

  var _video;

  VideoCellView(video) {
    this._video = video;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(_video["imageUrl"]),
              new Container(height: 8.0),
              new Text(
                _video["name"],
                style:
                new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              new Divider(),
            ],
          ),
        ),
      ],
    );
  }
}