import '../../services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

import 'alraydetail.dart';

class AlrayView extends StatefulWidget {
  const AlrayView({
    Key key,
  }) : super(key: key);
  @override
  _AlrayViewState createState() => _AlrayViewState();
}

class _AlrayViewState extends State<AlrayView> {
  ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;

  @override
  void initState() {
    super.initState();
    fetchMore(currentPage);
    _scrollController.addListener(() {
      setState(() {
        var isEnd = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
        var isStart = _scrollController.position.pixels ==
            _scrollController.position.minScrollExtent;
        if (isEnd) {
          fetchMore(currentPage);
        }
        if (isStart) {
          print('start');
          physics = ScrollPhysics(parent: NeverScrollableScrollPhysics());
          Future.delayed(const Duration(milliseconds: 2000), () {
            setState(() {
              physics = ScrollPhysics(parent: ClampingScrollPhysics());
            });
          });
        } else {
          physics = ScrollPhysics(parent: ClampingScrollPhysics());
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
    ApiService().getAlray(currentPage).then((value) {
      for (var item in value['data']['posts']['data']) {
        setState(() {
          data.add(Posts(
              imageUrl: 'https://alnahdanews.com/' + item['author']['img'],
              id: item['id'],
              title: item['title'],
              name: item['author']['name']));
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
    currentPage += 1;
  }

  @override
  Widget build(BuildContext context) {
    return PostsListBuilder(
      scrollController: _scrollController,
      data: data,
      isLoading: isLoading,
      physics: physics,
      curruntPage: currentPage,
    );
  }
}

// posts model map
class Posts {
  String title;
  String imageUrl;
  String name;
  int id;

  Posts({this.id, this.imageUrl, this.title, this.name});
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
    return ListView.builder(
      controller: _scrollController,
      // physics: physics,
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
                  child: Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('جاري تحميل المزيد ...'),
                      )),
                ),
              ));
        }
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.downToUp,
                    child: AlrayDetail(data[index].id, data[index].imageUrl)));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.white,
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
                            data[index].imageUrl,
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
                              Text(data[index].title,
                                  style: TextStyle(
                                      fontFamily: "sst-arabic-bold",
                                      fontSize: 14,
                                      height: 1.6),
                                  textAlign: TextAlign.right,
                                  maxLines: 2),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                data[index].name,
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
          ),
        );
        // return Column(
        //   children: <Widget>[
        //     Container(
        //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //       color: Colors.white,
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               PageTransition(
        //                   type: PageTransitionType.downToUp,
        //                   child: DetailView(data[index].id)));
        //         },
        //         child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               FadeInImage.assetNetwork(
        //                 width: 160,
        //                 height: 105,
        //                 fit: BoxFit.cover,
        //                 placeholder: 'assets/images/placeholder_small.png',
        //                 image: data[index].imageUrl,
        //               ),
        //               Spacer(),
        //               Container(
        //                   padding: EdgeInsets.only(right: 10, left: 0),
        //                   width: MediaQuery.of(context).size.width - 200,
        //                   child: Text(
        //                     data[index].title,
        //                     style: TextStyle(
        //                         fontFamily: "SST-Arabic-Medium",
        //                         fontSize: 18,
        //                         height: 1.5),
        //                     textAlign: TextAlign.right,
        //                     maxLines: 3,
        //                   )),
        //             ]),
        //       ),
        //     ),
        //     SizedBox(height: 10),
        //   ],
        // );
      },
    );
  }
}
