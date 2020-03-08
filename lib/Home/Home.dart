import 'package:alnahda/Home/caresoul.dart';
import 'package:alnahda/Home/thirdnews.dart';
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
                SecondNews(),
                ThirdNews(),
                SizedBox(height: 10),
                Container(
                    height: 360,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.downToUp,
                                child: DetailView()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            "https://alnahdanews.com/uploads/images/2020/03/wZKve.jpeg",
                            height: 260,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "النفط يصعد إلى أعلى مستوياته في أشهر بعد الهجوم الإيراني بالعراق",
                              style: TextStyle(
                                  fontFamily: "sst-arabic-bold",
                                  fontSize: 23,
                                  height: 1.3),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 10),
                SecondNews(),
              ],
            ),
          ),
        ));
  }
}
