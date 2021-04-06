import 'package:http/http.dart' as http;
import 'dart:convert';


const apikey = 'b2f594e15b8e76ed63e328e7dbfa905b';


class Network {
  Future<dynamic> getJsonData(String url) async {
    Uri url2 = Uri.parse(url);
    http.Response res = await http.get(url2);

    if (res.statusCode == 200) {
      String jsonData = res.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    } else {
      return null;
    }
  }
}
