import '../../services/api_service.dart';
import '../details/detailview.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

class Latest extends StatefulWidget {

  final int catId ;

  const Latest({Key key, @required this.catId}) : super(key: key);
  @override
  _LatestState createState() =>
      _LatestState();
}

class _LatestState extends State<Latest> {
  
  
  ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
      ScrollPhysics physics;

  @override
  void initState() {
    fetchMore(currentPage);
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        var isEnd = _scrollController.position.pixels  ==
            _scrollController.position.maxScrollExtent;
           var isStart = _scrollController.position.pixels  ==
            _scrollController.position.minScrollExtent;  
        if (isEnd) {
          fetchMore(currentPage);
        }
      if (isStart) {
          print('start');
          physics  = ScrollPhysics(parent: NeverScrollableScrollPhysics());
          Future.delayed(const Duration(milliseconds: 2000), () {
          setState(() {
          physics  = ScrollPhysics(parent :ClampingScrollPhysics());
          });
                  


});
        }else{
           physics  = ScrollPhysics(parent :ClampingScrollPhysics());

        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetch() {
    ApiService().getPosts(widget.catId, currentPage).then((value) {
      for (var item in value['data']['posts']['data']) {
        setState(() {
          data.add(Posts(imageUrl: 'https://alnahdanews.com/' + item['img'] , id: item['id'] ,title: item['title']));
          isLoading = false;
         
        });
      }
    });
  }

  fetchMore(int page) {
    if (!isLoading) {
      if (this.data.length > 0) {

        setState(() {
          isLoading = true;
        });
      }
    } else {
      return;
    }
    fetch();
     print(currentPage);
    currentPage+=1;
  }

  @override
  Widget build(BuildContext context) {
    return PostsListBuilder(scrollController: _scrollController, data: data, isLoading: isLoading , physics: physics,);

      // FutureBuilder(
      //     future: ApiService().getPosts(12, currentPage),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData) {
      //         Map content = snapshot.data;
      //         return Container(
      //           height: MediaQuery.of(context).size.height,
      //           child: Column(
      //             children: <Widget>[
      //               Text(content['data']['posts']['current_page'].toString()),
      //               fetchData(content['data']['posts'], context),
      //               Row(
      //                 children: <Widget>[
      //                   RaisedButton(
      //                     onPressed: () {
      //                       print(currentPage);
      //                       setState(() {
      //                         currentPage += 1;
      //                       });
      //                     },
      //                     child: Text('next'),
      //                   ),
      //                   RaisedButton(
      //                     onPressed: () {
      //                       print(currentPage);
      //                       setState(() {
      //                         currentPage =
      //                             content['data']['posts']['last_page'];
      //                       });
      //                     },
      //                     child: Text('last page'),
      //                   ),
      //                   RaisedButton(
      //                     onPressed: () {
      //                       print(currentPage);
      //                       setState(() {
      //                         currentPage = 1;
      //                       });
      //                     },
      //                     child: Text('first page'),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //         );
      //       } else {
      //         return Container(
      //             height: 100,
      //             child: Center(
      //                 child: Image.asset('assets/images/logo.png',
      //                     width: 100.0, height: 100.0)));
      //       }
      //     })

      // FutureBuilder(
      //     future: _apiService.getPosts(12, 1),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData) {
      //         Map content = snapshot.data;
      //         return ListView.builder(
      //           controller: _scrollController,
      //           itemBuilder: (context, index) {
      //             if (index == data.length) {
      //               return Visibility(
      //                   visible: isLoading,
      //                   child: SizedBox(
      //                     height: 40,
      //                     width: MediaQuery.of(context).size.width,
      //                     child: Center(
      //                       child: Text("加载中..."),
      //                     ),
      //                   ));
      //             }
      //             return Card(
      //               child: Container(
      //                 height: 60,
      //                 alignment: Alignment.centerLeft,
      //                 child: Text("Item ${this.prefix}_${data[index]}"),
      //               ),
      //             );
      //           },
      //           itemCount: content['data']['posts']['data'].length + 1,
      //         );
      //       } else {
      //         print(7);
      //         return Container(
      //             height: 100,
      //             child: Center(
      //                 child: Image.asset('assets/images/logo.png',
      //                     width: 100.0, height: 100.0)));
      //       }
      //     }),
    
  }

  // latestNews(context) {
  //   return FutureBuilder(
  //       future: _apiService.getPosts(12, 1),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasData) {
  //           Map content = snapshot.data;
  //           return Container(
  //             height: MediaQuery.of(context).size.height,
  //             child: PostsList(content: content),
  //           );
  //         } else {
  //           print(7);
  //           return Container(
  //               height: 100,
  //               child: Center(
  //                   child: Image.asset('assets/images/logo.png',
  //                       width: 100.0, height: 100.0)));
  //         }
  //       });
  // }

}

class PostsListBuilder extends StatelessWidget {
  const PostsListBuilder({
    Key key,
    @required ScrollController scrollController,
    @required this.data,
    @required this.isLoading, @required this.physics,
  }) : _scrollController = scrollController, super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics ;

  @override
  Widget build(BuildContext context) {

        return ListView.builder(
          controller: _scrollController,
          physics: physics  ,
          shrinkWrap: false,
      itemCount: data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == data.length) {
          return Visibility(
              visible: isLoading,
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(height: 50,child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('جاري تحميل المزيد ...'),
                  )),
                ),
              ));
        }
        return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.downToUp,
                            child: DetailView(data[index].id)));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                 
                        FadeInImage.assetNetwork(
                                  width: 160,
                                  height: 105,
                                  fit: BoxFit.cover,
                               
                                  placeholder: 'assets/images/placeholder_small.png', image: data[index].imageUrl,
                                ),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.only(right: 10, left: 0),
                            width: MediaQuery.of(context).size.width - 200,
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
          );
        // old one 
        // Column(
        //   children: <Widget>[
        //     Text("Page" + currentPage.toString()),
        //     Column(
        //       children: <Widget>[
        //         // Text(data[index]),
        //         // Image.network(
        //         //   data[index].imageUrl,
        //         //   height: 200,
        //         //   fit: BoxFit.cover,
        //         // ),
                
        //         Text(data[index].id.toString()),
        //         SizedBox(
        //           height: 50,
        //         )
        //       ],
        //     ),
        //   ],
        // );
      },
    );
  }
}

fetchData(Map content, BuildContext context) {
  // var namesGrowable = List();
  // Map contentDataMap;
  // for (var item in content['data']) {
  //   // print(item.toString());
  //   contentDataMap.addAll(item);
  // }
  // print(contentDataMap[1].toString());

  return Container(
    height: MediaQuery.of(context).size.height - 158,
    child: ListView.builder(
      itemCount: content['data'].length,
      itemBuilder: (BuildContext context, int index) {
        // data.add(content['data'][index]['title']);

        return Text(content['data'][index]['title']);
        // return Container(
        //   height: MediaQuery.of(context).size.height - 158,
        //   child: ListView.builder(
        //     itemCount: data.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Text(data[index]);
        //     },
        //   ),
        // );
      },
    ),
  );
}

/// poSTS LIST
class PostsList extends StatefulWidget {
  const PostsList({
    Key key,
    @required this.content,
  }) : super(key: key);

  final Map content;

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  ScrollController _controller = ScrollController();
  int currentPage = 1;

  bool onNotification(ScrollNotification notification) {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      print("لتحت");
      ApiService().getPosts(12, currentPage + 1).then((val) {
        print('end');

        currentPage = val['data']['posts']['current_page'];
        print(currentPage);
        setState(() {
          posts.addAll(val);
        });
      });
    }
    // if (notification is ScrollUpdateNotification) {
    //   if (_controller.position.maxScrollExtent > _controller.offset && _controller.position.maxScrollExtent - _controller.offset <=10 ) {
    //     ApiService().getPosts(12, currentPage+1).then((val) {
    //       print(_controller.position.maxScrollExtent );
    //    currentPage=  val['data']['posts']['current_page'] ;
    //       setState(() {
    //         posts.addAll(val);
    //       });
    //     });
    //   }

    // }
    return true;
  }

  Map posts;
  @override
  void initState() {
    super.initState();
    posts = widget.content;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: ListView.builder(
        controller: _controller,
        itemCount: posts['data']['posts']['data'].length - 1,
        itemBuilder: (BuildContext context, int index) {
          String imgurl = "https://alnahdanews.com/" +
              posts['data']['posts']['data'][index + 1]['img'].toString();

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
                            child: DetailView(posts['data']['posts']['data']
                                [index + 1]['id'])));
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
                          posts['data']['posts']['data'][index + 1]['title'],
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: DetailView(posts['data']['posts']['data']
                                  [index + 1]['id'])));
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
                              padding: EdgeInsets.only(right: 10, left: 0),
                              width: MediaQuery.of(context).size.width - 200,
                              child: Text(
                                posts['data']['posts']['data'][index + 1]
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
  }
}

class Posts {
  String title;
  String imageUrl;
  int id;

  Posts({this.id, this.imageUrl, this.title});
}
