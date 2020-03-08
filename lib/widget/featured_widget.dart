import 'dart:convert';

import 'package:alnahda/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;

class FeaturedWidget extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<FeaturedWidget> {
  ApiService _apiService;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return featuredBuilder();
  }


  featuredBuilder() {
    return FutureBuilder(
      future: _apiService.getLastFiveNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;

          return Container(
                color: Colors.white,
                height: 350,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      String  imgurl ="https://alnahdanews.com/"+content['data']['featured'][index]['img'].toString();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage( imgurl)),
                            ),
                            child: Container(
                                height: 240,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment
                                        .topCenter, // 10% of the width, so there are ten blinds.
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.1)
                                    ], // whitish to gray
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Text(
                              content['data']['featured'][index]['title'].toString(),
                              style: TextStyle(
                                  fontFamily: "sst-arabic-bold",
                                  fontSize: 23,
                                  height: 1.3),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      );
                    },
                    itemCount: 4,
                    viewportFraction: 1,
                    scale: 1,
                    autoplay: true,
                    pagination: new SwiperPagination(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.fromLTRB(0, 90, 20, 0),
                        builder: SwiperPagination.dots),
                  ),
                ),
             
            
          );
        } else {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        }
      },
    );

// builder
    // Widget _buildFeatured() {
    //   return FutureBuilder(
    //     future: _apiService.getLastFiveNews(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text(
    //               "Something wrong with message: ${snapshot.error.toString()}"),
    //         );
    //       } else if (snapshot.connectionState == ConnectionState.done) {
    //         dynamic content = snapshot.data;
    //         return _buildListViewFeatured(content);
    //       } else {
    //         return SizedBox(
    //             height: 60, child: Center(child: Text('جاري تحميل المعلومات')));
    //       }
    //     },
    //   );
    // }

    // Widget _buildListViewFeatured(dynamic featured) {
    //   return Container(
    //     color: Colors.white,
    //     height: 350,
    //     child: Container(
    //       width: MediaQuery.of(context).size.width,
    //       child: Swiper(
    //         itemBuilder: (BuildContext context, int index) {
    //           Featured _featured = featured[index];
    //           return Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Container(
    //                 decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: NetworkImage(_featured.img)),
    //                 ),
    //                 child: Container(
    //                     height: 240,
    //                     decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                         begin: Alignment.bottomCenter,
    //                         end: Alignment
    //                             .topCenter, // 10% of the width, so there are ten blinds.
    //                         colors: [
    //                           Colors.black.withOpacity(0.7),
    //                           Colors.black.withOpacity(0.1)
    //                         ], // whitish to gray
    //                       ),
    //                     )),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 20, vertical: 20),
    //                 child: Text(
    //                   _featured.title,
    //                   style: TextStyle(
    //                       fontFamily: "sst-arabic-bold",
    //                       fontSize: 23,
    //                       height: 1.3),
    //                   textAlign: TextAlign.right,
    //                 ),
    //               )
    //             ],
    //           );
    //         },
    //         itemCount: 4,
    //         viewportFraction: 1,
    //         scale: 1,
    //         autoplay: true,
    //         pagination: new SwiperPagination(
    //             alignment: Alignment.centerRight,
    //             margin: EdgeInsets.fromLTRB(0, 90, 20, 0),
    //             builder: SwiperPagination.dots),
    //       ),
    //     ),
    //   );
    // }
  }
}
