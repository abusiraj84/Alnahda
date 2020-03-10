import 'package:alnahda/details/detailview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ShowCat extends StatefulWidget {
  ShowCat({Key key,this.title}) : super(key: key);
final String title;
  @override
  _ShowCatState createState() => _ShowCatState();
}

class _ShowCatState extends State<ShowCat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.title)),
      body: Column(
            children: <Widget>[
      Container(
              height: 360,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.downToUp,
            child: DetailView(1)));
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
               
              latestNews(context)  
            ],
          ),
              
                
    );
  }
}


latestNews(context){

  return Container(
    height: MediaQuery.of(context).size.height - 495,
      child: ListView.builder(
      itemCount: 1000,
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
                          type: PageTransitionType.downToUp,
                          child: DetailView(1)));
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