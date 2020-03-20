
import 'package:alnahda/Screens/alray/AlrayView.dart';
import 'package:alnahda/Screens/video/videoView.dart';
import 'package:alnahda/Tests/test.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'alray/alrayTest.dart';
import 'breaknews/breaknews.dart';
import 'more.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({Key key}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;
  final tabs = [
    Test(),
    BreakNews(),
    AlrayPostsView(),
    VideoView(),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
       // backgroundColor: Color(0xff17202c),
        iconSize: 18,
        activeColor:  Color(0xff17202c),
        inactiveColor: Colors.grey.shade500,
        
        
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
      body: tabs[_currentIndex],
    );
  }
}
