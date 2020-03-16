import 'package:alnahda/Animations/fadeanimation.dart';

import '../../services/api_service.dart';
import '../details/detailview.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

class Latest extends StatefulWidget {
  final int catId;

  const Latest({Key key, @required this.catId}) : super(key: key);
  @override
  _LatestState createState() => _LatestState();
}

class _LatestState extends State<Latest> {
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
    //        Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text("جاري تحميل المزيد ...."),
    // ));
    
          fetchMore(currentPage);
          
        }
        if (isStart) {
          print('start');
          
          physics = ScrollPhysics(parent: NeverScrollableScrollPhysics());
          Future.delayed(const Duration(milliseconds: 3000), () {
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
    ApiService()..getLatest(currentPage).then((value) {
      for (var item in value['data']['latest']['data']) {
        setState(() {
          data.add(Posts(
              imageUrl: 'https://alnahdanews.com/' + item['img'],
              id: item['id'],
              title: item['title']));
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
  int id;

  Posts({this.id, this.imageUrl, this.title});
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
      physics: physics,
      shrinkWrap: false,
      itemCount: data.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 && data.length > 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20,top: 10),
            child: Container(
                height: 370,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.downToUp,
                            child: DetailView(data[index].id)));
                  },
                  child: FadeAnimation(
                                      0.5, Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/placeholder_big.png',
                          image: data[index].imageUrl,
                        ),
                        FadeAnimation(
                                                 0.5, Padding(
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
                        ),
                        
                      ],
                    ),
                  ),
                )),
          );
        } else {
          if (index == data.length) {
            return Container(
                height: 100,
                child: Visibility(
                    visible: isLoading,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height:20),
                        Container( child: CircularProgressIndicator()),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('جاري تحميل المزيد ...',style: TextStyle(fontSize: 12),),
                                )),
                          ),
                        ),
                     
                      ],
                    )),
              );
          }
          return FadeAnimation(
                      0.4, Column(
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
                            placeholder: 'assets/images/loader.gif',
                            image: data[index].imageUrl,
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
            ),
          );
        }
      },
    );
  }
}
