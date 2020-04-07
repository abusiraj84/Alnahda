import 'package:alnahda/Animations/fadeanimation.dart';

import 'lebanon_news_widget.dart';
import 'package:flutter/material.dart';
import '../Tools/globals.dart' as g;

class ThirdNews extends StatelessWidget {
  const ThirdNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(right: 20, top: 20),
      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: g.dark.withOpacity(0.2),
                              blurRadius: 1.0,
                              spreadRadius: 0.1,
                              offset: Offset(
                                0.0,
                                0.2,
                              ),
                            )
                          ],
                        ),
      child: FadeAnimation(
              1, Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "أخبار لبنان",
                style: TextStyle(
                    fontFamily: "sst-arabic-bold", fontSize: 23, height: 1.3),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(height: 200, child: LebanonNews()),
        ]),
      ),
    );
  }
}
