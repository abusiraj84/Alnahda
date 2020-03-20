import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:flutter/cupertino.dart';

import '../../services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

import 'videoplay.dart';

class VideoView extends StatefulWidget {
  const VideoView({
    Key key,
  }) : super(key: key);
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;
  int lastPage = 1;
GlobalKey<RefreshIndicatorState> refreshKey;
  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();

    fetchMore(currentPage);

    _scrollController.addListener(() {
      if (this.mounted) {
        setState(() {
          var isEnd = _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent;
          var isStart = _scrollController.position.pixels ==
              _scrollController.position.minScrollExtent;
          if (isEnd) {
            //        Scaffold.of(context).showSnackBar(SnackBar(
            //   content: Text("جاري تحميل المزيد ...."),
            // ));

            fetchMore(currentPage);
          }
          if (isStart) {
            print('start');

            physics = ScrollPhysics(parent: NeverScrollableScrollPhysics());
            Future.delayed(const Duration(milliseconds: 3000), () {
              if (this.mounted) {
                setState(() {
                  physics = ScrollPhysics(parent: ClampingScrollPhysics());
                });
              }
            });
          } else {
            physics = ScrollPhysics(parent: ClampingScrollPhysics());
          }
        });
      }
    });
  }
  
  Future<Null> refreshAll() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
     refreshKey = GlobalKey<RefreshIndicatorState>();
    });
  }
  
  fetch() {
    ApiService()
      ..getVideos(currentPage).then((value) {
        for (var item in value['data']['data']) {
          if (this.mounted) {
            setState(() {
              data.add(Posts(
                id: item['id'],
                title: item['title'],
                description: item['description'],
                path: item['path'],
                imageUrl: 'https://alnahdanews.com/' + item['img'],
                type: item['type'],
              ));
              isLoading = false;
            });
          }
        }
      });
  }

  fetchMore(int page) {
    if (!isLoading ) {
      if (this.data.length > 0) {
        if (this.mounted) {
          setState(() {
            isLoading = true;
          });
        }
      }
    } else {
      return;
    }
    fetch();
    print(currentPage);
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
          onRefresh: () async { await refreshAll();},
          child: PostsListBuilder(
        scrollController: _scrollController,
        data: data,
        isLoading: isLoading,
        physics: physics,
        curruntPage: currentPage,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}

// posts model map
class Posts {
  int id;
  String title;
  String imageUrl;
  String description;
  String path;
  String type;

  Posts(
      {this.id,
      this.imageUrl,
      this.title,
      this.description,
      this.path,
      this.type});
}
// end posts model map

class PostsListBuilder extends StatelessWidget {
  const PostsListBuilder({
    Key key,
    @required ScrollController scrollController,
    @required this.data,
    @required this.isLoading,
    @required this.physics,
    @required this.curruntPage,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics;
  final int curruntPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0), // here the desired height
            child: AppBar(leading: Container())),
        body: ListView.builder(
          controller: _scrollController,
          physics: physics,
          shrinkWrap: false,
          itemCount: data.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 && data.length > 0) {
              return Column(
                children: <Widget>[
                  Container(
                    height: 350,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.downToUp,
                            child: VideoPlay(
                              title: data[index].title,
                              description: data[index].description,
                              path: data[index].path,
                              type: data[index].type,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              FadeAnimation(
                                                      0.4, Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          FadeInImage.assetNetwork(
                                                            height: 260,
                                                            width: double.infinity,
                                                            fit: BoxFit.cover,
                                                            placeholder:
                                                                'assets/images/loader.gif',
                                                            image: data[index].imageUrl,
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 10),
                                                            child: Text(
                                                              data[index].title,
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
                                child: FadeAnimation(
                                                        0.6, CircleAvatar(
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 55,
                                      color: Colors.white,
                                    ),
                                    radius: 40,
                                    backgroundColor: Colors.white.withOpacity(0.2),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                          SizedBox(height: 10,),

                ],
              );
            } else {
              if (index == data.length) {
                   return Container(
       height: 60,
       child: Visibility(
           visible: isLoading,
           child: Column(
             children: <Widget>[
               SizedBox(height:0),
               Container( child: CupertinoActivityIndicator()),
               SizedBox(
                 height: 40,
                 width: MediaQuery.of(context).size.width,
                 child: Center(
                   child: Container(
                       height: 400,
                       child: Padding(
                         padding: const EdgeInsets.all(0.0),
                         child: Text('جاري تحميل المزيد ...',style: TextStyle(fontSize: 12),),
                       )),
                 ),
               ),
            
             ],
           )),
     );
              }
              return FadeAnimation(
                0.7,
                Column(
                  children: <Widget>[
                    
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.downToUp,
                              child: VideoPlay(
                                  title: data[index].title,
                                  description: data[index].description,
                                  path: data[index].path,
                                  type: data[index].type),
                            ),
                          );
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
                                          'assets/images/loader.gif',
                                      image: data[index].imageUrl,
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
                                          Colors.white.withOpacity(0.2),
                                    ),
                                  )
                                ],
                              ),
                              Spacer(),
                              Container(
                                  padding: EdgeInsets.only(right: 10, left: 0),
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  child: Text(
                                    data[index].title,
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
        ));
  }
}
