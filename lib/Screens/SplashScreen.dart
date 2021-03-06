import 'dart:async';

import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:alnahda/Screens/tabbar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
    Navigator.push(context, MyCustomRoute(builder: (context) => MyTabBar()));
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17202c),
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 300,
              left: 100,
              right: 100,
              child: FadeAnimation(
                             0.4,Image.asset(
                  'assets/images/splashLogo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Positioned(
              top:500,
              left:100,
 width: MediaQuery.of(context).size.width - 200 ,
              child: Center(
                child: Image.asset(
                  'assets/images/load.gif',
                 
                  
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 280,

              child: Image.asset(
                'assets/images/earth.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              //  child:   Placeholder()
            )

            // Parent(
            //   style: ParentStyle()..width(double.infinity)..height(40)..background.color(Colors.white.withOpacity(0.0)),
            //   child: Center(child: Txt('جميع الحقوق محفوظة 2020',style: TxtStyle()..fontSize(11)..textColor(Colors.blue.shade700),)),
            // )
          ],
        ),
      ),
    );
  }
}
