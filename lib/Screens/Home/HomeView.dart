import 'package:alnahda/Animations/fadeanimation.dart';
import 'package:alnahda/Screens/Home/FeaturedView.dart';
import 'package:alnahda/Screens/Home/latest_cat.dart';
import 'package:alnahda/Screens/Home/thirdnews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ApiService _apiService;
  bool _goUP;

  bool isBottom = false;

  ScrollController _controller;

  _moveDown() {
    // _controller.animateTo(_controller.offset + 10,
    //     curve: Curves.linear, duration: Duration(milliseconds: 2000));
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // setState(() {
      //   message = "reach the bottom";
      // });
      print('BOTOM HOME');
      _goUP = true;
      setState(() {
        _moveDown();
        //               Scaffold.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1000), backgroundColor: Colors.red,
        //   content: Text("يتم الآن تحميل المزيد من الأخبار .. يرجى المتابعة إلى الأسفل",style: TextStyle(fontFamily: "SST-Arabic-Medium"),),
        // ));
        //   Fluttertoast.showToast(
        //     msg: "يتم الآن تحميل المزيد من الأخبار ",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIos: 1,
        //     backgroundColor: Color(0xff17202c),
        //     textColor: Colors.white,
        //     fontSize: 14.0,
        //   );
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _goUP = false;
      });

      print('TOP HOME');
    }
  }

  @override
  void initState() {
    _goUP = false;
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();

    // _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.0), // here the desired height
            child: AppBar(leading: Container())),
        floatingActionButton: _goUP
            ? FloatingActionButton(
                backgroundColor: Color(0xff17202c),
                onPressed: () {
                  _controller.animateTo(_controller.offset - 1600,
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 500));
                },
                child: Icon(Icons.arrow_upward),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Color(0xffeef4f8),
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: <Widget>[
                FeaturedView(),
                SizedBox(height: 10),
                // SecondNews(),
                FadeAnimation(0.5, ThirdNews()),
                SizedBox(height: 10),

                Container(
                  height: MediaQuery.of(context).size.height - 90,
                  child: Latest(catId: 7),
                ),
              ],
            ),
          ),
        ));
  }
}
