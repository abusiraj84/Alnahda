import 'package:alnahda/Home/caresoul.dart';
import 'package:alnahda/Home/home_test.dart';
import 'package:alnahda/Home/thirdnews.dart';
import 'package:flutter/material.dart';

class SliverListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: CustomScrollView(
          slivers: <Widget>[
            ///First sliver is the App Bar
            // SliverAppBar(
            //   ///Properties of app bar
            //   backgroundColor: Colors.white,
            //   floating: false,
            //   pinned: true,
            //   expandedHeight: 200.0,

            //   ///Properties of the App Bar when it is expanded
            //   flexibleSpace: FlexibleSpaceBar(
            //     centerTitle: true,
            //     title: Text(
            //       "SliverList Widget",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontSize: 20.0,
            //           fontWeight: FontWeight.bold,
            //           ),
            //     ),
            //     background: Container(
            //       decoration: BoxDecoration(
            //         border: Border(
            //           top: BorderSide(
            //             color: Colors.black26,
            //             width: 1.0,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                   CaresoulView(),
                  SizedBox(height: 10),
                  // SecondNews(),
                  ThirdNews(),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // SliverFillRemaining(
            //   child: Column(
            //     children: <Widget>[
            //        CaresoulView(),
            //       SizedBox(height: 10),
            //       // SecondNews(),
            //       ThirdNews(),
            //       SizedBox(height: 10),
            //     ],
            //   ),
            // ),
            // SliverList(
            //   ///Use SliverChildListDelegate and provide a list
            //   ///of widgets if the count is limited
            //   ///
            //   ///Lazy building of list
            //   delegate: SliverChildBuilderDelegate(
            //     (BuildContext context, int index) {
            //       /// To convert this infinite list to a list with "n" no of items,
            //       /// uncomment the following line:
            //       /// if (index > n) return null;
            //       /// 
            //       print("index i "+index.toString());
            //       return Container(child: ScrollAndRefreshDemoPage(),height: 600,);
            //     },
            //     /// Set childCount to limit no.of items
            //      childCount: 1,
            //   ),
            // ),
             SliverFillRemaining(
         child:  ScrollAndRefreshDemoPage(),
            ),
          ],
        ),
      ),
    );
  }

}