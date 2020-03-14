import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         appBar: AppBar(
           title: Text('Title'),
         ),
         body: Center(
      child: RaisedButton(
        onPressed: _launchURL,
        child: Text('Show Flutter homepage'),
      ),
    ),
  )
       
    );
  }
  _launchURL() async {
  const url = 'https://flutter.dev';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}