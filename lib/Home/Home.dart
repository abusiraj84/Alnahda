import 'package:alnahda/Home/caresoul.dart';
import 'package:alnahda/Home/latest_cat.dart';
import 'package:alnahda/Home/thirdnews.dart';
import 'package:alnahda/api/api_service.dart';
import 'package:alnahda/details/detailview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'secondnews.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService _apiService;

  ScrollController _controller;
  bool istop = false;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("لتحت");
        istop = !istop;
        
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print(istop);

        istop = !istop;
        // physics == ScrollPhysics(parent: NeverScrollableScrollPhysics());
      });
    }    if (_controller.offset <= _controller.position.minScrollExtent&&
        _controller.position.outOfRange) {
      setState(() {
        print(istop);

        istop = false;
        // physics == ScrollPhysics(parent: NeverScrollableScrollPhysics());
      });
    } else {istop =true;}
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
        backgroundColor: Color(0xffeef4f8),
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CaresoulView(),
                SizedBox(height: 10),
                // SecondNews(),
                ThirdNews(),
                SizedBox(height: 10),
                // Container(
                //     height: 360,
                //     color: Colors.white,
                //     child: GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             PageTransition(
                //                 type: PageTransitionType.downToUp,
                //                 child: DetailView(1)));
                //       },
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Image.network(
                //             "https://alnahdanews.com/uploads/images/2020/03/wZKve.jpeg",
                //             height: 260,
                //             fit: BoxFit.cover,
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.all(20.0),
                //             child: Text(
                //               "النفط يصعد إلى أعلى مستوياته في أشهر بعد الهجوم الإيراني بالعراق",
                //               style: TextStyle(
                //                   fontFamily: "sst-arabic-bold",
                //                   fontSize: 23,
                //                   height: 1.3),
                //               textAlign: TextAlign.right,
                //             ),
                //           ),
                //         ],
                //       ),
                //     )),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height -90,
                  child: Latest(catId: 12,),
                ),
//  ScrollAndRefreshDemoPage(),
// latestNews(context),
              ],
            ),
          ),
        ));
  }
// new list

// الليست القديمة 
  latestNews(context) {
    return FutureBuilder(
        future: _apiService.getFeatured(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height - 80,
              child: ListView.builder(
                shrinkWrap: true,
                // controller: _controller,
                // physics:PageScrollPhysics(),
                //  istop
                //     ? ScrollPhysics(parent: NeverScrollableScrollPhysics())
                //     : null,
                itemCount: content['data']['latest']['data'].length - 1,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  String imgurl = "https://alnahdanews.com/" +
                      content['data']['latest']['data'][index + 1]['img']
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
                                    child: DetailView(content['data']['latest']
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
                                  content['data']['latest']['data'][index + 1]
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
                                      child: DetailView(content['data']
                                              ['latest']['data'][index + 1]
                                          ['id'])));
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
                                        content['data']['latest']['data']
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
