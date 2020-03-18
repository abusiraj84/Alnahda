import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:alnahda/Screens/Home/FeaturedView.dart';
import 'package:alnahda/Screens/Home/latest_cat.dart';
import 'package:alnahda/Screens/Home/thirdnews.dart';
import 'package:alnahda/Screens/details/detailview.dart';
import 'package:alnahda/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Test extends StatefulWidget {
  Test({
    
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
  _TestState createState() => _TestState();
}


class _TestState extends State<Test> {
  ApiService _apiService;
    ScrollController _scrollController = ScrollController();
  List<Posts> data = [];
  bool isLoading = false;
  int currentPage = 1;
  ScrollPhysics physics;
  
  bool _goUP;

  bool isBottom = false;

  ScrollController _controller;
 

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {

      print('BOTOM HOME');
      _goUP = true;
 fetchMore(currentPage);
      setState(() {
       

      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _goUP = false;
      });

      print('TOP HOME');
    }
  }



  @override
  void initState() {
    super.initState();
      _goUP = false;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    fetchMore(currentPage);
    

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
    return Scaffold(
       appBar: PreferredSize(
            preferredSize: Size.fromHeight(0), // here the desired height
            child: AppBar(leading: Container())),
        floatingActionButton: _goUP
            ? FloatingActionButton(
                backgroundColor: Color(0xff17202c),
                onPressed: () {
                  _controller.animateTo(_controller.offset - 1600,
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 500));
                },
                child: Icon(Icons.arrow_upward),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Color(0xffeef4f8),
      body: SafeArea(
         top: true,
          bottom: false,
              child: SingleChildScrollView(
           controller: _controller,
          child:Column(
                children: <Widget>[
                  ListView.builder(
                     padding: EdgeInsets.symmetric(vertical: 0),
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          FeaturedView(),
                  SizedBox(height: 10),
                  // SecondNews(),
                  ThirdNews(),
 SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                  ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
                physics: ClampingScrollPhysics(),

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
                  height: 120,
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
    )
                ],
              )
     
        ),
      ),
    );
  }
}
