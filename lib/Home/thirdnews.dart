import 'package:alnahda/details/detailview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ThirdNews extends StatelessWidget {
  const ThirdNews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(right: 20, top: 20),
      color: Colors.white,
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "أخبار لبنان",
              style: TextStyle(
                  fontFamily: "sst-arabic-bold", fontSize: 23, height: 1.3),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(height: 20),
        Container(height: 200, child: ListSlider()),
      ]),
    );
  }
}

class ListSlider extends StatelessWidget {
  const ListSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            width: 170,
            height: 200,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: DetailView()));
                },
                child: Column(
                  children: <Widget>[
                    Image.network(
                      "https://alnahdanews.com/uploads/images/2020/02/X6h3V.jpeg",
                      height: 100,
                      width: 170,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " وزير سابق: لبنان قريب من الانهيار ويحتاج 25 مليار دولار",
                        style: TextStyle(
                            fontFamily: "SST-Arabic-Medium",
                            fontSize: 15,
                            height: 1.5),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                )));
      },
    );
    
  featuredBuilder() {
    return FutureBuilder(
      future: _apiService.getLastFiveNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
return ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            width: 170,
            height: 200,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300)),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: DetailView()));
                },
                child: Column(
                  children: <Widget>[
                    Image.network(
                      "https://alnahdanews.com/uploads/images/2020/02/X6h3V.jpeg",
                      height: 100,
                      width: 170,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        " وزير سابق: لبنان قريب من الانهيار ويحتاج 25 مليار دولار",
                        style: TextStyle(
                            fontFamily: "SST-Arabic-Medium",
                            fontSize: 15,
                            height: 1.5),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                )));
      },
    );
          // return Container(
          //       color: Colors.white,
          //       height: 350,
          //       child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         child: Swiper(
          //           itemBuilder: (BuildContext context, int index) {
          //             String  imgurl ="https://alnahdanews.com/"+content['data']['featured'][index]['img'].toString();
          //             return Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Container(
          //                   decoration: BoxDecoration(
          //                     image: DecorationImage(
          //                         fit: BoxFit.cover,
          //                         image: NetworkImage( imgurl)),
          //                   ),
          //                   child: Container(
          //                       height: 240,
          //                       decoration: BoxDecoration(
          //                         gradient: LinearGradient(
          //                           begin: Alignment.bottomCenter,
          //                           end: Alignment
          //                               .topCenter, // 10% of the width, so there are ten blinds.
          //                           colors: [
          //                             Colors.black.withOpacity(0.7),
          //                             Colors.black.withOpacity(0.1)
          //                           ], // whitish to gray
          //                         ),
          //                       )),
          //                 ),
          //                 Padding(
          //                   padding: const EdgeInsets.symmetric(
          //                       horizontal: 20, vertical: 20),
          //                   child: Text(
          //                     content['data']['featured'][index]['title'].toString(),
          //                     style: TextStyle(
          //                         fontFamily: "sst-arabic-bold",
          //                         fontSize: 23,
          //                         height: 1.3),
          //                     textAlign: TextAlign.right,
          //                   ),
          //                 )
          //               ],
          //             );
          //           },
          //           itemCount: 4,
          //           viewportFraction: 1,
          //           scale: 1,
          //           autoplay: true,
          //           pagination: new SwiperPagination(
          //               alignment: Alignment.centerRight,
          //               margin: EdgeInsets.fromLTRB(0, 90, 20, 0),
          //               builder: SwiperPagination.dots),
          //         ),
          //       ),
             
            
          // );
        } else {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        }
      },
    );

  }
}
