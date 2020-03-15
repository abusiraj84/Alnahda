import 'package:alnahda/Screens/details/detailview.dart';

import '../../services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:page_transition/page_transition.dart';

class CategorieView extends StatefulWidget {
  CategorieView({Key key, this.title, this.catId}) : super(key: key);
  final String title;
  final int catId;
  @override
  _CategorieViewState createState() => _CategorieViewState();
}

class _CategorieViewState extends State<CategorieView> {
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
    ApiService().getPosts(widget.catId, currentPage).then((value) {
      for (var item in value['data']['posts']['data']) {
        setState(() {
          data.add(Posts(
              imageUrl: 'https://alnahdanews.com/' + item['img'],
              id: item['id'],
              title: item['title'],
          ));
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
      pageTitle: widget.title,
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
    @required this.curruntPage,@required this.pageTitle,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<Posts> data;
  final bool isLoading;
  final ScrollPhysics physics;
  final int curruntPage;
  final String pageTitle;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body:   ListView.builder(
        controller: _scrollController,
        physics: physics,
        shrinkWrap: false,
        itemCount: data.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 && data.length > 0) {
            return Padding(
             padding: const EdgeInsets.only(bottom: 10,top: 0),
              child: Container(
                  height: 350,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.downToUp,
                              child: DetailView(data[index].id)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInImage.assetNetwork(
                          height: 260,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/loader.gif',
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
                                  child: Text('جاري تحميل المزيد ...'),
                                )),
                          ),
                        ),
                     
                      ],
                    )),
              );
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
            );
          }
        },
      ),
    );
        
   
  }
  
}
