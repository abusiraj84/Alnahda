import 'dart:convert';

import 'package:alnahda/model/contactUs.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://alnahdanews.com/api/v1";
  Client client = Client();

  Future<Map> getFeatured() async {
    String myUrl = 'https://alnahdanews.com/api/v1/home';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getBreakNews() async {
    String myUrl = 'https://alnahdanews.com/api/v1/breaking';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }


  Future<Map> getdetail(int id) async {
    String myUrl = 'https://alnahdanews.com/api/v1/post/$id';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getCats() async {
    String myUrl = 'https://alnahdanews.com/api/v1/nav';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  Future<Map> getPosts(int catId,int page) async {
     String myUrl;
   
      myUrl = 'https://alnahdanews.com/api/v1/category/$catId?page=$page';
    

    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      String pagess ='get data from $page';
      print(pagess);
      return json.decode(response.body);
    } else {
      return null;
    }
  }
  Future<Map> getLatest(int page) async {
     String myUrl =
     
        'https://alnahdanews.com/api/v1/latest?page=$page';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      String pagess ='get data from $page';
      print(pagess);
      return json.decode(response.body);
    } else {
      return null;
    }
  }
  


  Future<Map> getVideos(int pageId) async {
    String myUrl = 'https://alnahdanews.com/api/v1/videos?page=$pageId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
   Future<Map> getOP(int pageId) async {
    String myUrl = 'https://alnahdanews.com/api/v1/category/2?page=$pageId';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
       print(json.decode(response.body));
      return json.decode(response.body);
     
    } else {
      return null;
    }
  }
    Future<bool> contactUs(ContactUs body) async {
    final response = await http.post(
      "https://alnahdanews.com/api/v1/contact",
      headers: {"content-type": "application/json"},
      body: userToJson(body),
          );
          if (response.statusCode == 201 || response.statusCode == 200) {
            return true;
          } else {
            return false;
          }
        }


      String userToJson(ContactUs data) => json.encode(data.toJson());

}

  