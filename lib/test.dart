import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {


  Future<Map> getWeather() async {
    String myUrl =
        'https://alnahdanews.com/api/v1/home';
    http.Response response = await http.get(myUrl);
    return json.decode(response.body);
  }
  myWeatherFinal() {
    return FutureBuilder(
      future: getWeather(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          
          //var image = "assets/images/${content['weather'][0]['icon']}\.png";
          return Container(
            width: 400,
            height: 1100,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
              return Text(
                  content['data']['featured'][index]['title'].toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                      textAlign: TextAlign.center,
                );
             },
            ),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: Center(child: Row(children: <Widget>[
         myWeatherFinal()
       ],)),
    )
    );
  }
}

