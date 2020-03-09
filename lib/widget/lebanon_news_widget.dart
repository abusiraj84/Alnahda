import 'package:alnahda/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../details/detailview.dart';

class LebanonNews extends StatefulWidget {
  const LebanonNews({Key key}) : super(key: key);

  @override
  _LebanonNewsState createState() => _LebanonNewsState();
}

class _LebanonNewsState extends State<LebanonNews> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return featuredBuilder();
  }

  featuredBuilder() {
    return FutureBuilder(
      future: _apiService.getLastFiveNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              String imgurl = "https://alnahdanews.com/" +
                  content['data']['widget_1']['posts'][index]['img'].toString();

              return Container(
                  width: 170,
                  height: 200,
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: DetailView()));
                      },
                      child: Column(
                        children: <Widget>[
                          Image.network(imgurl,
                            height: 100,
                            width: 170,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(content['data']['widget_1']['posts'][index]['title'].toString(),
                              style: TextStyle(
                                  fontFamily: "SST-Arabic-Medium",
                                  fontSize: 15,
                                  height: 1.5,
                                  ),
                              textAlign: TextAlign.right,
                              maxLines: 3,
                            ),
                          )
                        ],
                      )));
            },
          );
        } else {
          return Container(
            height:100,
             child: Center(child:Image.asset('assets/images/logo.png', width: 100.0, height: 100.0)

));
        }
      },
    );
  }
}
