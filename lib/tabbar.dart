import 'package:alnahda/more.dart';

import 'home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class MyTabBar extends StatefulWidget {
  MyTabBar({Key key}) : super(key: key);

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _currentIndex = 0;
  final tabs = [
    HomeView(),
    Center(child: Text("عاجل")),
    Center(child: Text("الرأي")),
    Center(child: Text("فيديو")),
    More(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.house),
              title: Text("الرئيسية"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.flame),
              title: Text("عاجل"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.person),
              title: Text("الرأي"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.camera),
              title: Text("فيديو"),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(SFSymbols.ellipsis),
              title: Text("المزيد"),
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
