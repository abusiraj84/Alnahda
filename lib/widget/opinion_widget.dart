import 'package:alnahda/api/api_service.dart';
import 'package:flutter/material.dart';

class OpinionWidget extends StatefulWidget {
  OpinionWidget({Key key}) : super(key: key);

  @override
  _OpinionWidgetState createState() => _OpinionWidgetState();
}

class _OpinionWidgetState extends State<OpinionWidget> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return opinionBuilder();
  }

  opinionBuilder() {
    return FutureBuilder(
      future: _apiService.getOpinon(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return ListView.builder(
            itemCount: content['data']['posts']['data'].length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              String imgurl = "https://alnahdanews.com/" +
                  content['data']['posts']['data'][index]['author']['img'];
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.white,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                imgurl,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 280,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    content['data']['posts']['data'][index]
                                            ['title']
                                        .toString(),
                                    style: TextStyle(
                                        fontFamily: "sst-arabic-bold",
                                        fontSize: 14,
                                        height: 1.3),
                                    textAlign: TextAlign.right,
                                      maxLines: 2
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    content['data']['posts']['data'][index]
                                        ['author']['name'],
                                    style: TextStyle(
                                        fontFamily: "sst-roman",
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        height: 1.3),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
