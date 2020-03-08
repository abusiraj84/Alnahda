import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class BreakNews extends StatelessWidget {
  const BreakNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عاجل'),
      ),
      body: Column(
        children: <Widget>[
          SingleNews(),
           SingleNews(),
            SingleNews(),
             SingleNews(),
        ],
      )
    );
  }
}

class SingleNews extends StatelessWidget {
  const SingleNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          color: Colors.white,
          height: 130,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  
                 Icon(SFSymbols.flame_fill,color: Color(0xffeb4e54),),
                 SizedBox(width: 7,),
                 Text("09:10",style:TextStyle(color: Color(0xffeb4e54),fontWeight: FontWeight.bold,fontSize: 18)),
                 
                ],),
                 SizedBox(height:10,),
                Container(
                  width: 400,

                  child: Text(
                                    "النفط يصعد إلى أعلى مستوياته في أشهر بعد الهجوم الإيراني بالعراق",
                                    style: TextStyle(
                                        fontFamily: "sst-arabic-bold",
                                        fontSize: 14,
                                        height: 1.3),
                                    textAlign: TextAlign.right,
                                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}