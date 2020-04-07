
import 'package:alnahda/Screens/alray/AlrayView.dart';
import 'package:alnahda/Screens/video/videoView.dart';
import 'package:alnahda/Tests/cachedTest.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'Home/Home.dart';
import 'breaknews/breaknews.dart';
import 'more.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({Key key}) : super(key: key);


  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
     List<Widget> pageList = List<Widget>();
  int _currentIndex = 0;
  final tabs = [
    
    Home(),
    BreakNews(),
    AlrayView(),
    VideoView(),
    // CustomScrollViewTestRoute(),
    More()
  ];

  @override
  void initState() {
      pageList.add(Home());
    pageList.add(BreakNews(),);
    pageList.add(AlrayView(),);
    pageList.add(VideoView(),);
    pageList.add(More());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        activeColor:Color(0xff17202c),
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        iconSize: 18,
      
        
        
        items: [
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.house),
              title: Text("الرئيسية", style: TextStyle(fontFamily: "SST-Arabic-Medium",fontSize: 11,fontWeight: FontWeight.w300),),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.flame),
              title: Text("عاجل", style: TextStyle(fontFamily: "SST-Arabic-Medium",fontSize: 11,fontWeight: FontWeight.w300),),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.person),
              title: Text("الرأي", style: TextStyle(fontFamily: "SST-Arabic-Medium",fontSize: 11,fontWeight: FontWeight.w300),),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.camera),
              title: Text("فيديو", style: TextStyle(fontFamily: "SST-Arabic-Medium",fontSize: 11,fontWeight: FontWeight.w300),),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.ellipsis),
              title: Text("المزيد", style: TextStyle(fontFamily: "SST-Arabic-Medium",fontSize: 11,fontWeight: FontWeight.w300),),
              backgroundColor: Colors.blue),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
        body: IndexedStack(
           children: pageList,
            index: _currentIndex,
          ), 
    );
  }
}
