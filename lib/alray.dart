import 'package:flutter/material.dart';

class Alray extends StatelessWidget {
  const Alray({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('الرأي'),
        ),
        body: Column(
          children: <Widget>[
            SingleAlray(),
            SingleAlray(),
            SingleAlray(),
            SingleAlray(),
          ],
        ));
  }
}

class SingleAlray extends StatelessWidget {
  const SingleAlray({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        color: Colors.white,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://img.buzzfeed.com/buzzfeed-static/static/2019-11/6/21/asset/32ddc350937a/sub-buzz-4662-1573075386-1.jpg",
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "النفط يصعد إلى أعلى مستوياته في أشهر بعد الهجوم الإيراني بالعراق",
                          style: TextStyle(
                              fontFamily: "sst-arabic-bold",
                              fontSize: 14,
                              height: 1.3),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "حسام نصرالله",
                          style: TextStyle(
                              fontFamily: "sst-roman",
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              height: 1.3),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
