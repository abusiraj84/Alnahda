
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://alnahdanews.com/api/v1";
  Client client = Client();


  Future<Map> getFeatured() async {
     String myUrl =
        'https://alnahdanews.com/api/v1/home';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
    Future<Map> getBreakNews() async {
     String myUrl =
        'https://alnahdanews.com/api/v1/breaking';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

      Future<Map> getOpinon() async {
     String myUrl =
        'https://alnahdanews.com/api/v1/category/2';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

   Future<Map> getdetail(int id) async {
     String myUrl =
        'https://alnahdanews.com/api/v1/post/$id';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
 Future<Map> getCats() async {
     String myUrl =
        'https://alnahdanews.com/api/v1/nav';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
  Future<Map> getPosts(int id,int page) async {
     String myUrl =
        'https://alnahdanews.com/api/v1/category/$id?page=$page';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      print('get data');
      return json.decode(response.body);
    } else {
      return null;
    }
  }

    Future<Map> getVideos() async {
     String myUrl =
        'https://alnahdanews.com/api/v1/videos';
    http.Response response = await http.get(myUrl);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
  
}

