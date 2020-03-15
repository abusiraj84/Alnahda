import '../Services/api_service.dart';
import './categories/CategorieView.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class More extends StatefulWidget {
  More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool show;
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Title'),
    //     ),
    //     body: SafeArea(
    //       child: lebanonBuilder(),
    //     ));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0), // here the desired height
        child: AppBar(leading: Container())),
      body: SafeArea(
          child: SingleChildScrollView(
                      child: Column(
        children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Color(0xffEFF4F8),
              height: 90,
              child: Image.asset('assets/images/appbarlogo.png',
                  width: 163.0, height: 67.0),
            ),
            Container(
              color: Colors.grey.withOpacity(0.3),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     PageTransition(
                  //         type: PageTransitionType.downToUp,
                  //         child: ShowCat(title: title,catId: catId)));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/smartphone.png',
                              width: 20.0, height: 20.0),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "تواصل معنا",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            catsBuilder(),

            // CatList(
            //   img: 'assets/images/file.png',
            //   title: "أخبار",
            // ),
            // CatList(
            //   img: 'assets/images/leb.png',
            //   title: "أخبار لبنان",
            // ),
            // CatList(
            //   img: 'assets/images/meeting.png',
            //   title: "تقارير وحوارات",
            // ),
            // CatList(
            //   img: 'assets/images/jet.png',
            //   title: "الرصد العسكري",
            // ),
            // CatList(
            //   img: 'assets/images/atom.png',
            //   title: "علوم",
            // ),
            // CatList(
            //   img: 'assets/images/misc.png',
            //   title: "منوعات",
            // ),
            // CatList(
            //   img: 'assets/images/music.png',
            //   title: "فن ومشاهير",
            // ),
            // CatList(
            //   img: 'assets/images/sport.png',
            //   title: "رياضة",
            // ),
            // CatList(
            //   img: 'assets/images/box.png',
            //   title: "ثقافة وأدب",
            // ),
        ],
      ),
          )),
    );
  }

  catsBuilder() {
    return FutureBuilder(
      future: _apiService.getCats(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;

          return Container(
            height: MediaQuery.of(context).size.height - 90 - 193,
            child: ListView.builder(
              itemCount: content['data']['menu'].length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                // print(content['data']['menu'][index]['title']);
                return CatList(
                  img: 'assets/images/file.png',
                  title: content['data']['menu'][index]['title'],
                  catId: content['data']['menu'][index]['id'],
                );
              },
            ),
          );
        } else {
           return Container(
                  height: MediaQuery.of(context).size.height - 277,
                  child: Center(
                    child: Image.asset('assets/images/loading.gif',width: 200)
                  ),
                );
        }
      },
    );
  }
}

class CatList extends StatelessWidget {
  const CatList({Key key, this.img, this.title, this.catId}) : super(key: key);
  final String img;
  final String title;
  final int catId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.downToUp,
                child: CategorieView(title: title, catId: catId)));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(img, width: 20.0, height: 20.0),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
