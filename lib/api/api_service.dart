
import 'package:alnahda/model/home_page_model.dart';
import 'package:http/http.dart' show Client;


class ApiService {
  final String baseUrl = "https://alnahdanews.com/api/v1";
  Client client = Client();


  Future<List<Featured>> getLastFiveNews() async {
    final response = await client.get("$baseUrl/home");
    if (response.statusCode == 200) {
   print(response.body);
      return null;
    } else {
      return null;
    }
  }
}