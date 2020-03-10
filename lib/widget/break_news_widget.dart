import 'package:alnahda/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class BreakNewsWidget extends StatefulWidget {
  BreakNewsWidget({Key key}) : super(key: key);

  @override
  _BreakNewsState createState() => _BreakNewsState();
}

class _BreakNewsState extends State<BreakNewsWidget> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return lebanonBuilder();
  }

  lebanonBuilder() {
    return FutureBuilder(
      future: _apiService.getBreakNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return ListView.builder(
            itemCount: content['data'].length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
          
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.white,
                 
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              SFSymbols.flame_fill,
                              color: Color(0xffeb4e54),
                              size: 15,
                              
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(content['data'][index]['time'].toString(),
                                style: TextStyle(
                                    color: Color(0xffeb4e54),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 400,
                          child: Text(
                           content['data'][index]['title'].toString(),
                            style: TextStyle(
                                fontFamily: "sst-arabic-bold",
                                fontSize: 14,
                                height: 1.7),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container(
              height: 100,
              child: Center(
                  child: Image.asset('assets/images/logo.png',
                      width: 100.0, height: 100.0)));
        }
      },
    );
  }
}
