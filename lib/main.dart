import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:alnahda/Screens/tabbar.dart';
import 'package:alnahda/Tests/test.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splashscreen/splashscreen.dart';

// import 'Screens/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            fontFamily: "SST-Arabic-Medium",
            primaryColor: Color(0xff17202c),
            accentColor: Color(0xff17202c)),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'), // arabic
        ],
        debugShowCheckedModeBanner: false,
        home: FadeAnimation(
                  0.5, SplashScreen(
            seconds: 4,
            navigateAfterSeconds: MyTabBar(),
            backgroundColor: Color(0xFF17202C),
            photoSize: 200,
            image: Image.asset(
              'assets/images/splashLogo.gif',
           

            ),
            
          ),
        ),
      ),
    );
  }
}

// class Home extends StatefulWidget {
//   Home({Key key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool toggle;

//   @override
//   void initState() {
//     super.initState();

//     toggle = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: <Widget>[
//         AnimatedPositioned(
//           top: toggle ? 0 : MediaQuery.of(context).size.width / 2,
//           left: 0,
//           right: 0,
//           duration: Duration(milliseconds: 200),
//           child: Padding(
//             padding: EdgeInsets.all(toggle ? 0 : 8.0),
//             child: Column(
//               children: <Widget>[
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       toggle = !toggle;
//                     });
//                     print(toggle);
//                   },
//                   child: AnimatedContainer(
//                     width: toggle ? MediaQuery.of(context).size.width : 400,
//                     height: toggle ? MediaQuery.of(context).size.height : 100,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       color: Colors.amber,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.amber.withOpacity(0.2),
//                           blurRadius:
//                               20.0, // has the effect of softening the shadow
//                           spreadRadius:
//                               5.0, // has the effect of extending the shadow
//                           offset: Offset(
//                             0.0, // horizontal, move right 10
//                             20.0, // vertical, move down 10
//                           ),
//                         )
//                       ],
//                     ),
//                     duration: Duration(milliseconds: 200),
//                     curve: Curves.elasticInOut,
//                     child: Column(
//                       children: <Widget>[
//                         Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: toggle ? 50 : 20),
//                             child: Container(
//                               height: toggle ? 500 : 50,
//                               child: Column(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Text(
//                                         "Our Flutter is ready!",
//                                         style: TextStyle(
//                                             fontSize: 25,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Spacer(),
//                                       CircleAvatar(
//                                         backgroundColor: Colors.black,
//                                         foregroundColor: Colors.white,
//                                         radius: 15,
//                                         child: Icon(
//                                             toggle
//                                                 ? Icons.close
//                                                 : Icons.cloud_download,
//                                             size: 15),
//                                       )
//                                     ],
//                                   ),

//                                   // Opacity(child: AnimatedContainer(height: toggle ? 100: 0, child: Text(",,,sdfsdfsdfsdfsdfsdf,sdfsdfsdf,sdfsd,fsdfsdfsdfsfsdfsdfsdfsdfsdfsdfsdf,sdfsdfsdfsdfsdfsdf,sdfsdfsdf,sdfsd,fsdfsdfsdfsfsdf"), duration: Duration(milliseconds: 200),), opacity: toggle? 1: 0,)
//                                 ],
//                               ),
//                             ))
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(toggle ? 0 : 8.0),
//                   child: Placeholder(),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
// }
