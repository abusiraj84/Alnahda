import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:alnahda/Screens/tabbar.dart';
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
        darkTheme:ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
             brightness: Brightness.light,
             
            fontFamily: "SST-Arabic-Medium",
            
            primaryColor: Color(0xff17202c),
            accentColor: Color(0xff17202c)),
        theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
             brightness: Brightness.light,
             
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
            seconds: 2,
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
