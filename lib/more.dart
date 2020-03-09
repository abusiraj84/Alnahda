import 'package:flutter/material.dart';

class More extends StatefulWidget {
  More({Key key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool show;

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
          CatList(
            img: 'assets/images/file.png',
            title: "أخبار",
          ),
          CatList(
            img: 'assets/images/leb.png',
            title: "أخبار لبنان",
          ),
          CatList(
            img: 'assets/images/meeting.png',
            title: "تقارير وحوارات",
          ),
          CatList(
            img: 'assets/images/jet.png',
            title: "الرصد العسكري",
          ),
          CatList(
            img: 'assets/images/atom.png',
            title: "علوم",
          ),
          CatList(
            img: 'assets/images/misc.png',
            title: "منوعات",
          ),
          CatList(
            img: 'assets/images/music.png',
            title: "فن ومشاهير",
          ),
          CatList(
            img: 'assets/images/sport.png',
            title: "رياضة",
          ),
          CatList(
            img: 'assets/images/box.png',
            title: "ثقافة وأدب",
          ),
          CatList(
            img: 'assets/images/smartphone.png',
            title: "تواصل معنا",
          ),
        ],
      )),
    );
  }
}

class CatList extends StatelessWidget {
  const CatList({
    Key key,
    this.img,
    this.title,
  }) : super(key: key);
  final String img;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
