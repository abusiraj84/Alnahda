import 'package:alnahda/widget/featured_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CaresoulView extends StatefulWidget {
  CaresoulView({Key key}) : super(key: key);

  @override
  _CaresoulViewState createState() => _CaresoulViewState();
}

class _CaresoulViewState extends State<CaresoulView> {
  @override
  Widget build(BuildContext context) {

    return FeaturedWidget();
    // return Container(
    //   color: Colors.white,
    //   height: 350,
    //   child: Container(
    //     width: MediaQuery.of(context).size.width,
    //     child: Swiper(
    //       itemBuilder: (BuildContext context, int index) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Container(
    //               decoration: BoxDecoration(
    //                 image: DecorationImage(
    //                     fit: BoxFit.cover,
    //                     image: NetworkImage(
    //                         "https://alnahdanews.com/uploads/images/2020/03/QhwBM.jpeg")),
    //               ),
    //               child: Container(
    //                   height: 240,
    //                   decoration: BoxDecoration(
    //                     gradient: LinearGradient(
    //                       begin: Alignment.bottomCenter,
    //                       end: Alignment
    //                           .topCenter, // 10% of the width, so there are ten blinds.
    //                       colors: [
    //                         Colors.black.withOpacity(0.7),
    //                         Colors.black.withOpacity(0.1)
    //                       ], // whitish to gray
    //                     ),
    //                   )),
    //             ),
    //             Padding(
    //               padding:
    //                   const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //               child: Text(
    //                 "ترامب لقادة إيران: لا تقتلوا المجتجين فنحن نراقبكم",
    //                 style: TextStyle(
    //                     fontFamily: "sst-arabic-bold",
    //                     fontSize: 23,
    //                     height: 1.3),
    //                 textAlign: TextAlign.right,
    //               ),
    //             )
    //           ],
    //         );
    //       },
    //       itemCount: 4,
    //       viewportFraction: 1,
    //       scale: 1,
    //       autoplay: true,
    //       pagination: new SwiperPagination(
    //           alignment: Alignment.centerRight,
    //           margin: EdgeInsets.fromLTRB(0, 90, 20, 0),
    //           builder: SwiperPagination.dots),
    //     ),
    //   ),
    // );
  }
}
