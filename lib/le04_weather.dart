import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'le04_location.dart';
import 'le04_network.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WeatherData {
  static WeatherData _instance;
  static WeatherData getInstance() {
    if (_instance == null) {
      _instance = WeatherData();
    }
    return _instance;
  }

  dynamic parsingData;
}

class WeatherMain extends StatefulWidget {
  @override
  _WeatherMainState createState() => _WeatherMainState();
}

class _WeatherMainState extends State<WeatherMain> with WidgetsBindingObserver {
  var model = WeatherData.getInstance();
  MyLocation mylocation = MyLocation();
  Network network = Network();

  int weatherId;
  String weatherImageName;
  String cityName;
  String contryName;
  int tempInt;

  String dayOfWeek;
  String today;
  String nowTime;

  @override
  void initState() {
    super.initState();
    updateData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 이거는 홈버튼 인식
    print(state);
    print(":::::::");
  }

  void updateData() {
    weatherId = model.parsingData['weather'][0]['id'];
    cityName = model.parsingData['name'];
    contryName = model.parsingData['sys']['country'];
    num strTemp = model.parsingData['main']['temp'] as num;
    tempInt = strTemp.toInt();

    // https://openweathermap.org/weather-conditions
    if (weatherId == 800) {
      weatherImageName = "sun";
    } else if (weatherId == 801) {
      weatherImageName = "cloudy";
    } else if (weatherId >= 802 && weatherId < 900) {
      // Clouds 구름
      weatherImageName = "cloud";
    } else if (weatherId >= 200 && weatherId < 300) {
      // Thunderstorm 낙뢰
      weatherImageName = "energy";
    } else if (weatherId >= 300 && weatherId < 400) {
      // Drizzle 눈비
      weatherImageName = "rain";
    } else if (weatherId >= 500 && weatherId < 500) {
      // Rain 비
      weatherImageName = "rain";
    } else if (weatherId >= 600 && weatherId < 700) {
      // Snow 눈
      weatherImageName = "frost";
    } else if (weatherId >= 200 && weatherId < 300) {
      // Atmosphere 안개
      weatherImageName = "fog";
    } else {
      weatherImageName = "fog";
    }

    // 현재의 시간과 날짜를 포맷에 맞게 저장한다.
    var now = DateTime.now();
    var formatter1 = DateFormat(DateFormat.WEEKDAY).format(now);
    var formatter2 = DateFormat('yyyy-MM-dd');
    var formatter3 = DateFormat('a h:mm:ss');
    dayOfWeek = formatter1;
    today = formatter2.format(now);
    nowTime = formatter3.format(now);
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

    var data = WeatherData.getInstance();
    data.parsingData = parsingData;
    setState(() {
      updateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('현재날씨'),
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.location_on_rounded),
            onPressed: () {
              getLocation();
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                // 지역 검색으로 이동
                final result = await Navigator.pushNamed(context, '/search');
                if (result) {
                  setState(() {
                    updateData();
                  });
                }
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$cityName, $contryName',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/$weatherImageName.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                ' $tempInt°',
                style: TextStyle(fontSize: 60, color: Colors.white),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                '$dayOfWeek',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Text(
                '$today',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$nowTime',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//
//
//
//
//
//
// 지역 검색

class WeatherSrarch extends StatefulWidget {
  @override
  _WeatherSrarchState createState() => _WeatherSrarchState();
}

class _WeatherSrarchState extends State<WeatherSrarch> {
  TextEditingController controller = TextEditingController();
  Network network = Network();

  void getCityName() async {
    String qCity = controller.text;
    String test2 =
        'http://api.openweathermap.org/data/2.5/weather?q=$qCity&units=metric&APPID=$apikey';
    var parsingData = await network.getJsonData(test2);
    if (parsingData == null) {
      showToast("날씨 정보 획득 실패");
      return;
    }

    var data = WeatherData.getInstance();

    data.parsingData = parsingData;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.yellow[800],
              Colors.yellow[700],
              Colors.yellow[600],
              Colors.yellow[400],
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              '지역 검색',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.backspace),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context, false);
                }),
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    child: IconButton(
                        icon: Icon(Icons.location_searching),
                        color: Colors.white,
                        onPressed: () {}),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter locationName',
                        fillColor: Colors.white,
                        hoverColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigator.pop(context, true);
                  getCityName();
                },
                child: Text(
                  'Get Wheather',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 20.0);
}
