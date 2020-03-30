import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int lastPage = 1;

  @override
  void initState() {
    super.initState();

    fetchMore(page: currentPage, isRefresh: false);
    HapticFeedback.mediumImpact();
    
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

            fetchMore(page: currentPage, isRefresh: false);
           
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

  fetch() {
    ApiService().getOP(currentPage).then((value) {
      for (var item in value['data']['posts']['data']) {
        print(item['id']);
        if (this.mounted) {
          setState(() {
            data.add(Posts(
              id: item['id'],
              title: item['title'],
              imageUrl: item['author']['img'] == null
                  ? 'assets'
                  : ApiService().getImage (item['author']['img']),
              name: item['author']['name'],
            ));
            isLoading = false;
             HapticFeedback.mediumImpact();
          });
        }
      }
    });
  }

  fetchMore({int page, bool isRefresh = false}) {
    if (!isLoading) {
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

    setState(() {
      if (isRefresh) {
        data.clear();
      }
      fetch();
      currentPage += 1;
      isLoading = true;
    });

    print(page);
  }

  Future _handleRefresh() async {
    // prefix += 1;
    return fetchMore(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return PostsListBuilder(
      scrollController: _scrollController,
      data: data,
      isLoading: isLoading,
      physics: physics,
      curruntPage: currentPage,
      handleRefresh: _handleRefresh,
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
  String title;
  String imageUrl;
  String name;
  int id;

  Posts({this.id, this.imageUrl, this.title, this.name});
}
// end posts model map

class PostsListBuilder extends StatefulWidget {
  const PostsListBuilder(
      {Key key,
      @required ScrollController scrollController,
      @required this.data,
      @required this.isLoading,
      @required this.physics,
      @required this.curruntPage,
      @required this.handleRefresh})
      : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics;
  final int curruntPage;
  final Function handleRefresh;

  @override
  _PostsListBuilderState createState() => _PostsListBuilderState();
}

class _PostsListBuilderState extends State<PostsListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeef4f8),
        appBar: AppBar(leading: Container(),title: Text("الرأي"),),
        body: RefreshIndicator(
          onRefresh: widget.handleRefresh,
          child: ListView.builder(
            controller: widget._scrollController,
            shrinkWrap: false,
            itemCount: widget.data.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == widget.data.length) {
             return Container(
               padding: EdgeInsets.only(top:20),
                      height: 90,
                      child: Visibility(
                          visible: widget.isLoading,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 0),
                              Container( height:20,width: 20,child: CircularProgressIndicator(strokeWidth: 3,)),
                              SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Container(
                                      height: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Text(
                                          'جاري التحميل ...',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )),
                    );
              }
              return InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: AlrayDetail(
                              widget.data[index].id, widget.data[index].imageUrl)));
                },
                child: FadeAnimation(
                  0.5,
                  Padding(
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
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.red.shade800, width: 4),
                                    image: DecorationImage(
                                        image: widget.data[index].imageUrl == 'assets'
                                            ? AssetImage(
                                                'assets/images/person.png')
                                            : NetworkImage(
                                                widget.data[index].imageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 280,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(widget.data[index].title,
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
                                        widget.data[index].name,
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
                ),
              );
            },
          ),
        ));
  }
}
