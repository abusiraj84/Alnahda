import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class DetailView extends StatefulWidget {
  DetailView({Key key}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 300,
                                    child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://alnahdanews.com/uploads/images/2020/03/tYlfi.jpeg")),
                ),
                child: Container(
                    
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment
                            .bottomCenter, // 10% of the width, so there are ten blinds.
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0)
                        ], // whitish to gray
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 0,
              left: 10,
              right: 10,
                          child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    
                    IconButton(icon: Icon(SFSymbols.square_arrow_up,size: 25,color: Colors.white,), onPressed: () =>Navigator.pop(context) ),
                    IconButton(icon: Icon(SFSymbols.arrow_left,size: 25,color: Colors.white,), onPressed: () =>Navigator.pop(context) ),

                  ],
                ),
              ),
            ),
            Positioned(
           
             left: 0,
             right: 0,
             bottom: 0,
             height: MediaQuery.of(context).size.height  - 310,
              child: Container(
             
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                   boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius:
              20.0, // has the effect of softening the shadow
                          spreadRadius:
              5.0, // has the effect of extending the shadow
                          offset: Offset(
                            0.0, // horizontal, move right 10
                            2.0, // vertical, move down 10
                          ),
                        )
                      ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,20,20),
                    child: SingleChildScrollView(
                                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height:20),
                        Text(
                "النفط يصعد إلى أعلى مستوياته في أشهر بعد الهجوم الإيراني بالعراق",
                style: TextStyle(
                      fontFamily: "sst-arabic-bold",
                      fontSize: 23,
                      height: 1.3),
                textAlign: TextAlign.right,
              ),
              SizedBox(height:20),
              Text("13 يناير 2020",style: TextStyle(
                      fontFamily: "sst-roman",
                      fontSize: 10,
                      height: 1.3),
                textAlign: TextAlign.right,),
                SizedBox(height:10),

                 Text("شهد سعر الدولار في سوريا مقابل الليرة السورية في السوق السوداء انخفاضا طفيفا اليوم الأحد 8 3 2020 وسجل سعر صرف الليرة السورية مقابل الدولار 1060 1068 ليرة سورية في دمشق ووصل سعر اليورو مقابل الليرة",style: TextStyle(
                      fontFamily: "sst-roman",
                      fontSize: 18,
                      height: 1.7,),
                textAlign: TextAlign.right, textDirection: TextDirection.rtl,),

                                                   Text("شهد سعر الدولار في سوريا مقابل الليرة السورية في السوق السوداء انخفاضا طفيفا اليوم الأحد 8 3 2020 وسجل سعر صرف الليرة السورية مقابل الدولار 1060 1068 ليرة سورية في دمشق ووصل سعر اليورو مقابل الليرة",style: TextStyle(
                      fontFamily: "sst-roman",
                      fontSize: 18,
                      height: 1.7,),
                textAlign: TextAlign.right, textDirection: TextDirection.rtl,),



                 Text("شهد سعر الدولار في سوريا مقابل الليرة السورية في السوق السوداء انخفاضا طفيفا اليوم الأحد 8 3 2020 وسجل سعر صرف الليرة السورية مقابل الدولار 1060 1068 ليرة سورية في دمشق ووصل سعر اليورو مقابل الليرة",style: TextStyle(
                      fontFamily: "sst-roman",
                      fontSize: 18,
                      height: 1.7,),
                textAlign: TextAlign.right, textDirection: TextDirection.rtl,),

                              Footer(),




                        ],
                      ),
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}


class Footer extends StatelessWidget {
  const Footer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xff1d2839),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("جميع الحقوق محفوظة لـ النهضة نيوز ©2020", style: TextStyle(
                                            fontFamily: "sst-arabic-bold",
                                            fontSize: 10,
                                            height: 1.3,color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
          ),
        ),
           SizedBox(height:20),
      ],
    );
  }
}