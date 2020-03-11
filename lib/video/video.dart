import 'package:alnahda/api/api_service.dart';
import 'package:alnahda/details/detailview.dart';
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
      appBar: AppBar(title: Text(widget.title)),
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

                itemCount: content['data']['posts']['data'].length - 1,
                itemBuilder: (BuildContext context, int index) {
                  String imgurl = "https://alnahdanews.com/" +
                      content['data']['posts']['data'][index + 1]['img']
                          .toString();

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
                                    child: DetailView(content['data']['posts']
                                        ['data'][index + 1]['id'])));
                          },
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
                                  content['data']['posts']['data'][index + 1]
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
                        ));
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
                                      child: DetailView(content['data']['posts']
                                          ['data'][index + 1]['id'])));
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(
                                    imgurl,
                                    width: 160,
                                    height: 105,
                                    fit: BoxFit.cover,
                                  ),
                                  Spacer(),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 0),
                                      width: MediaQuery.of(context).size.width -
                                          200,
                                      child: Text(
                                        content['data']['posts']['data']
                                            [index + 1]['title'],
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
            print(widget.catId);
            return Container(
                height: 100,
                child: Center(
                    child: Image.asset('assets/images/logo.png',
                        width: 100.0, height: 100.0)));
          }
        });
  }
}
