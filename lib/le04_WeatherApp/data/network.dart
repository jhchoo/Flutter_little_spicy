import 'package:flutter_little_spicy/le02_LoginDiceapp.dart';
import 'package:http/http.dart' as http; // 함수가 너무 짧아서 알아볼 수 있도록 별칭을 줘보자.
import 'dart:convert';

class Network {

  Future<dynamic> getJsonData(String url) async {
    // 0.13.3 으로 올라가면서 이제는 Uri를 사용해야 한다.
    http.Response response = await http.get(Uri.parse(url));
    // print(response.body);
    // response.body json 파싱 하자 
    if (response.statusCode == 200) {
      String jsonData = response.body;

      return jsonDecode(jsonData);
    }
  }

}

// 섭씨로 온도 받기 units=metric
// https://openweathermap.org/current