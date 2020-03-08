import 'package:flutter/material.dart';

class More extends StatefulWidget {
  More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool show ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        leading: IconButton(icon: Icon(Icons.offline_bolt), onPressed: (){
          setState(() {
            show =!show;
          });
          
          print(show);
          }),
      ),
      body: Transform.translate(
              child: Transform.scale(
                child: AnimatedContainer(
          
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
                    ), duration: Duration(milliseconds: 3000),curve: Curves.bounceInOut,
              
            ), scale: show ? 0.8 : 1 ,
        ), offset: Offset(show ? 60 : 0,0),
      ),
    );
  }
}