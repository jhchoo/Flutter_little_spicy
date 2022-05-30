import 'package:flutter/material.dart';
import 'package:flutter_little_spicy/le04_WeatherApp/WeatherScreen.dart';
import 'package:flutter_little_spicy/le04_WeatherApp/data/my_location.dart';

import 'data/network.dart';
 

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  // 로케이션 
  MyLocation myLocation = MyLocation();

  // 네트워크
  Network network = Network();

  @override
  void initState() {
    super.initState();
  
    getLocation();
  }

  void getLocation() {
    // Future 어싱크는 이걸로 받으면 편하다... 추가적인 이해가 필요하다.
    myLocation.getMyCurrentLocation().then((value) {
      // 사용자의 좌표로 가져온다.
      // fetchData();

      // 별다른걸 사용하지 않아도 여러개의 API를 이렇게 호출 할 수 있다.
      fetchDataTwo();

    },onError: (error){
      // 실패할 경우 여기로
      print('실패 메세지를 보여준다.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          getLocation();
        },
        child: Text('Get my Location'),
      )),
    );
  }

  void fetchData() {
    double? lat = myLocation.latitude2;
    double? lon = myLocation.longitude2;
    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherId&units=metric';

    // 한개의 API 를 사용 할 때에는 어싱크는 then 으로 받으면 편하다.
    network.getJsonData(url).then((parsingData) {
        Navigator.push(context, MaterialPageRoute(builder:(context) {
          return WeatherScreen(parseWeatherData: parsingData);
        }));
    },onError: (error){
      // 실패할 경우 여기로
      print('실패 메세지를 보여준다.');
    });
  }

  // API 두개를 받아보자.
  void fetchDataTwo() async {
    double? lat = myLocation.latitude2;
    double? lon = myLocation.longitude2;

    String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$weatherId&units=metric';
    var weatherData = await network.getJsonData(url);
    print(weatherData);

    String url2 = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$weatherId';
    var airData = await network.getJsonData(url2); // 나중에 널체크만 들어가면 될거 같다.
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder:(context) {
      return WeatherScreen(parseWeatherData: weatherData, parseAirData: airData,);
    }));
  }

  // GitGuardian 에서 토큰이 보인다고 나왔다. 일단 중요한건 아니라서...  연습 후 제거 하도록 한다.
  // 외부에서 키를 읽어 가도록 하면 좋을 듯 하다.
  String weatherId = "날씨를 얻기 위한 키 추가 하면 된다.";
}

// https://openweathermap.org/current
// https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&units=metric
// https://api.openweathermap.org/data/2.5/weather?lat=37.402&lon=127.105&appid={API key}
// appid는 딱히 알아도 쓸데가 없을거 같아서 놔둠.

// 공기 대기질 확인
// http://api.openweathermap.org/data/2.5/air_pollution?lat={lat}&lon={lon}&appid={API key}
// http://api.openweathermap.org/data/2.5/air_pollution?lat=37.402&lon=127.105&appid={API key}

// VS-CODE 디버그 콘솔창 단축키
// Ctrl + `

// 