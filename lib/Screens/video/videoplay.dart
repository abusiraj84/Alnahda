import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class VideoPlay extends StatefulWidget {
  const VideoPlay({Key key, this.title, this.description, this.path})
      : super(key: key);

  final String description;
  final String path;
  final String title;

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,height: 1.3)),
            ),
            HtmlWidget(
              " <iframe width='560' height='315' src=" +
                  widget.path +
                  "frameborder='0' allow='accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>",
              webView: true,
              webViewJs: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(widget.description,style: TextStyle(),textAlign: TextAlign.right,),
            ),
          ],
        ),
      ),
    );
  }
}

// HtmlWidget(
//    """
//    <iframe src="https://www.facebook.com/plugins/post.php?href=https://www.facebook.com/NasDailyArabic/posts/2653397148115727"  ></iframe>
//    <iframe width="560" height="315" src="https://www.youtube.com/watch?v=G4xhbiJ605o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
// """,
//           webView: true,
//           webViewJs: true,
//         ),
