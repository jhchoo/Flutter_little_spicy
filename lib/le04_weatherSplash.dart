import 'package:flutter/material.dart';
import 'le04_network.dart';
import 'le04_location.dart';
import 'le04_weather.dart';

class WeatherSplash extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherSplash> {
  MyLocation mylocation = MyLocation();
  Network network = Network();

  @override
  void initState() {
    super.initState();
    getLocation();
    //fetchData();
  }

  void getLocation() async {
    await mylocation.getMyCurrentLocation();
    print(mylocation.latitude2);
    print(mylocation.longitude2);
    double lat = mylocation.latitude2;
    double lon = mylocation.longitude2;
    String test2 =
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&APPID=$apikey';
    var parsingData = await network.getJsonData(test2);

    // 이동
    var data = WeatherData.getInstance();
    data.parsingData = parsingData;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WeatherMain(),
        ),
        ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
