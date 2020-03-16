import 'package:alnahda/Animations/fadeanimation.dart';

import '../../Screens/details/detailview.dart';
import '../../services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class FeaturedView extends StatefulWidget {
  FeaturedView({Key key}) : super(key: key);

  @override
  _FeaturedViewState createState() => _FeaturedViewState();
}

class _FeaturedViewState extends State<FeaturedView> {
  ApiService _apiService;
  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    // return FeaturedWidget();
    return Column(
      children: <Widget>[
        FutureBuilder(
            future: _apiService.getFeatured(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map content = snapshot.data;
                String imgurl = "https://alnahdanews.com/" +
                    content['data']['featured'][0]['img'].toString();
                return Container(
                    height: 360,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: DetailView(
                                    content['data']['featured'][0]['id'])));
                      },
                      child: FadeAnimation(
                                             0.5, Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             FadeInImage.assetNetwork(
                                 
                                    height: 260,
                                    width: double.infinity ,
                                    fit: BoxFit.cover,
                                 
                                    placeholder: 'assets/images/loader.gif', image: imgurl,
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                content['data']['featured'][0]['title'],
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
                    ));
              } else {
                //  print(widget.catId);
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',width: 200)
                  ),
                );
              }
            }),
        SizedBox(height: 10),
        latestNews(context)
      ],
    );
  }

  latestNews(context) {


    return FutureBuilder(
        future: _apiService.getFeatured(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return Container(
              height: 405,
              child: ListView.builder(
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  String imgurl = "https://alnahdanews.com/" +
                      content['data']['featured'][index + 1]['img'].toString();

                  return FadeAnimation(
                                      0.6, Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.downToUp,
                                    child: DetailView(content['data']['featured']
                                        [index + 1]['id'])));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  FadeInImage.assetNetwork(
                                    width: 160,
                                    height: 105,
                                    fit: BoxFit.cover,
                                 
                                    placeholder: 'assets/images/loader.gif', image: imgurl,
                                  ),
                                  Spacer(),
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 10, left: 0),
                                      width:
                                          MediaQuery.of(context).size.width - 200,
                                      child: Text(
                                        content['data']['featured'][index + 1]
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
                    ),
                  );
                },
              ),
            );
          } else {
            // print(widget.catId);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child:Image.asset('assets/images/loading.gif',width: 100)
              ),
            );
          }
        });
  }
}
