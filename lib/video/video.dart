import 'package:alnahda/api/api_service.dart';
import 'package:alnahda/details/detailview.dart';
import 'package:alnahda/video/videoplay.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShowVideo extends StatefulWidget {
  ShowVideo({Key key}) : super(key: key);
  // final String title;
  // final int catId;

  @override
  _ShowVideoState createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  ApiService _apiService;
  ScrollController _controller;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("فيديو")),
      body: latestNews(context),
    );
  }

  latestNews(context) {
    return FutureBuilder(
        future: _apiService.getVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                controller: _controller,
                itemCount: content['data']['data'].length - 1,
                itemBuilder: (BuildContext context, int index) {
                  String imgurl = "https://alnahdanews.com/" +
                      content['data']['data'][index + 1]['img'].toString();

                  if (index == 0) {
                    return Container(
                      height: 350,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.downToUp,
                                  child: VideoPlay(content['data']['data']
                                      [index + 1]['id'])));
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(
                                    imgurl,
                                    height: 260,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      content['data']['data'][index + 1]
                                          ['title'],
                                      style: TextStyle(
                                          fontFamily: "sst-arabic-bold",
                                          fontSize: 23,
                                          height: 1.3),
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 100,
                              right: 100,
                              top: 90,
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                radius: 40,
                                backgroundColor: Colors.grey.withOpacity(0.9),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.downToUp,
                                      child: DetailView(content['data']['data']
                                          [index + 1]['id'])));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Positioned(
                                        child: Image.network(
                                          imgurl,
                                          width: 160,
                                          height: 105,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        right: 20,
                                        top: 30,
                                        child: CircleAvatar(
                                          child: Icon(
                                            Icons.play_arrow,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          radius: 20,
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.9),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 0),
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: Text(
                                        content['data']['data'][index + 1]
                                            ['title'],
                                        style: TextStyle(
                                            fontFamily: "SST-Arabic-Medium",
                                            fontSize: 18,
                                            height: 1.5),
                                        textAlign: TextAlign.right,
                                        maxLines: 3,
                                      )),
                                ]),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }
                },
              ),
            );
          } else {
            //print(widget.catId);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Image.asset('assets/images/2.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,fit: BoxFit.fill,),
                    
              ),
            );
          }
        });
  }
}
