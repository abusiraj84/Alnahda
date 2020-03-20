import '../Services/api_service.dart';
import './categories/CategorieView.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'contactUs/contactUsView.dart';

import 'package:flutter_svg/flutter_svg.dart';
 
class More extends StatefulWidget {
  More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool show;
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Title'),
    //     ),
    //     body: SafeArea(
    //       child: lebanonBuilder(),
    //     ));
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // here the desired height
        child: AppBar(leading: Container())),
      body: SafeArea(
          child: SingleChildScrollView(
                      child: Column(
        children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Color(0xffEFF4F8),
              height: 90,
              child: Image.asset('assets/images/appbarlogo.png',
                  width: 163.0, height: 67.0),
            ),
             
            Container(
          
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: ContactUsView()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/smartphone.png',
                              width: 20.0, height: 20.0),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "تواصل معنا",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
          
 catsBuilder(),
            
        ],
      ),
          )),
    );
  }

  catsBuilder() {
    return FutureBuilder(
      future: _apiService.getCats(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;

          return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            itemCount: content['data']['menu'].length,
                            scrollDirection: Axis.vertical,
                           shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              // print(content['data']['menu'][index]['title']);
                              return CatList(
                                img: content['data']['menu'][index]['custom'],
                                title: content['data']['menu'][index]['title'],
                                catId: content['data']['menu'][index]['id'],
                              );
                            },
                          ),
                        ],
                      ),
          );
        } else {
           return Container(
                  height: MediaQuery.of(context).size.height - 277,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',width: 200)
                  ),
                );
        }
      },
    );
  }
}

class CatList extends StatelessWidget {
  const CatList({Key key, this.img, this.title, this.catId}) : super(key: key);
  final String img;
  final String title;
  final int catId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp,
                child: CategorieView(title: title, catId: catId)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.network(img, width: 20.0, height: 20.0,headers: null,color: null,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
