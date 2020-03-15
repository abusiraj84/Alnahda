import 'package:alnahda/Animations/fadeanimation.dart';

import '../../Screens/details/detailview.dart';
import 'package:alnahda/Services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'videoplay.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _apiService = ApiService();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the bottom";
        print("bottom");
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = "reach the top";
        print("top");
      });
    }
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
                itemCount: content['data']['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  String imgurlBig = "https://alnahdanews.com/" +
                      content['data']['data'][index]['img'].toString();
                  String imgurlSmall = "https://alnahdanews.com/" +
                      content['data']['data'][index]['img'].toString();
                  String title = content['data']['data'][index]['title'];
                  String description = content['data']['data'][index]['description'];
                  String path = content['data']['data'][index]['path'];

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
                                  child: VideoPlay(
                                     title: title,
                                     description: description,path: path,
                                      ),),);
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: FadeAnimation(
                                                              0.6, Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FadeInImage.assetNetwork(
                                      height: 260,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          'assets/images/placeholder_big.png',
                                      image: imgurlBig,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        content['data']['data'][index]['title'],
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
                    return FadeAnimation(
                                          0.7, Column(
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
                                    child: VideoPlay(
                                       title: title,
                                       description: description,path: path,
                                        ),),);
                                    
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Positioned(
                                          child: FadeInImage.assetNetwork(
                                            width: 160,
                                            height: 105,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                'assets/images/placeholder_small.png',
                                            image: imgurlSmall,
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
                                          content['data']['data'][index]['title'],
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
                      ),
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
                    child: Image.asset('assets/images/loading.gif',width: 200)
                  ),
                );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("فيديو"),leading: Container(),),
      body: latestNews(context),
    );
  }
}
