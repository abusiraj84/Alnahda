import 'package:alnahda/details/detailview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SecondNews extends StatelessWidget {
  const SecondNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 405,
      child: ListView.builder(
        itemCount: 3,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child: DetailView()));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          'https://alnahdanews.com/uploads/images/2020/01/1s2Ur.jpeg',
                          width: 160,
                          height: 105,
                          fit: BoxFit.cover,
                        ),
                        Spacer(),
                        Container(
                            padding: EdgeInsets.only(right: 10, left: 0),
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(
                              "ترامب لقادة إيران: لا تقتلوا المجتجين فنحن نراقبكم",
                              style: TextStyle(
                                  fontFamily: "SST-Arabic-Medium",
                                  fontSize: 21,
                                  height: 1.5),
                              textAlign: TextAlign.right,
                            )),
                      ]),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
