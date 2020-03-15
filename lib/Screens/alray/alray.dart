// import '../alray/alraydetail.dart';
// import '../../services/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';

// import 'alraydetail.dart';

// class Alray extends StatefulWidget {
//   Alray({Key key}) : super(key: key);

//   @override
//   _AlrayState createState() => _AlrayState();
// }

// class _AlrayState extends State<Alray> {
//   ApiService _apiService;

//   @override
//   void initState() {
//     super.initState();
//     _apiService = ApiService();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الرأي'),
//       ),
//       body: opinionBuilder()
//     );
//   }

//   opinionBuilder() {
//     return FutureBuilder(
//       future: _apiService.getOpinon(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           Map content = snapshot.data;
//           return ListView.builder(
//             itemCount: content['data']['posts']['data'].length,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (BuildContext context, int index) {
//               String imgurl = "https://alnahdanews.com/" +
//                   content['data']['posts']['data'][index]['author']['img'];
//               return InkWell(
//                 onTap: (){
//                     Navigator.push(
//                         context,
//                         PageTransition(
//                             type: PageTransitionType.downToUp,
//                           child: AlrayDetail(content['data']['posts']['data'][index]['id'],content['data']['posts']['data'][index]['author']['img'].toString())));
//                   },
//                               child: Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Container(
//                     color: Colors.white,
                   
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundImage: NetworkImage(
//                                   imgurl,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Container(
//                                 width: 280,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       content['data']['posts']['data'][index]
//                                               ['title']
//                                           .toString(),
//                                       style: TextStyle(
//                                           fontFamily: "sst-arabic-bold",
//                                           fontSize: 14,
//                                           height: 1.6),
//                                       textAlign: TextAlign.right,
//                                         maxLines: 2
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Text(
//                                       content['data']['posts']['data'][index]
//                                           ['author']['name'],
//                                       style: TextStyle(
//                                           fontFamily: "sst-roman",
//                                           fontSize: 13,
//                                           color: Colors.grey.shade600,
//                                           height: 1.3),
//                                       textAlign: TextAlign.right,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//            return Container(
//                   height: MediaQuery.of(context).size.height,
//                   child: Center(
//                     child: Image.asset('assets/images/loading.gif',width: 200)
//                   ),
//                 );
//         }
//       },
//     );
//   }
// }
