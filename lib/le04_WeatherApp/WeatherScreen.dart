import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import 'Model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({this.parseWeatherData, this.parseAirData});
  // 다이나믹을 생략하고 파이널 변수를 만들 수 있다.
  final parseWeatherData; // final dynamic parseWeatherData

  // 대기질 지수 추가.
  final parseAirData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? cityName;
  int? temp;
  var date = DateTime.now();
  int? condition;
  Model model = Model();
  late Widget icon;
  String? description;

  // 대기질
  late Widget airIcon;
  late Widget airState;
  double? dust1;
  double? dust2;

  @override
  void initState() {
    super.initState();
    // print(this.widget.parseWeatherData);

    updataData(widget.parseWeatherData, widget.parseAirData);
  }

  void updataData(dynamic weatherData, dynamic airData) {
    description = weatherData['weather'][0]
        ['description']; // jsonDecode는 var 다이나믹 키워드에 담아야 한다.
    print(description); //  few clouds

    double tempDouble = weatherData['main']['temp'];
    temp = tempDouble.round();
    cityName = weatherData['name'];

    condition = weatherData['weather'][0]['id'];
    icon = model.getWeatherIcon(condition!);

    // ----- 대기질 지수를 가져오자.
    int? index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);

    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // 머터리얼 디자인의 시각적 구조(뼈대)를 제공한다.  // appBar를 넣을 수도 있고, body 를 넣을 수 있다.
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.location_searching),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),

      // 바디
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: columnInnerInfo(),
            ),
          ),
        ],
      ),
    );
  }

  Column columnInnerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 두개의 사이에 공간을 넓힌다.
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              '$cityName',
              style: GoogleFonts.lato(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // 가로방향 글씨, 일부러 여러개의 데이터 포맷을 사용하여 이것저것 보여준다.
            Row(
              children: [
                TimerBuilder.periodic( // 타이머 빌더로 시간을 계속 찍어보자, 타이머 사용법 알기.
                  Duration(minutes: 1), // 1분마다 무제한... 
                  builder: (context) {
                    print('${getSystemTime()}');
                    return Text(
                      '${getSystemTime()}',
                      style:
                          GoogleFonts.lato(fontSize: 16, color: Colors.white),
                    );
                  },
                ),
                Text(
                  DateFormat(' - EEEE').format(date),
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                ),
                Text(
                  DateFormat(', yyyy-MM-dd').format(date),
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                )
              ],
            ),

            //======================= 라인
            Divider(
              height: 15,
              thickness: 2,
              color: Colors.white30,
            ),
            SizedBox(
              height: 20,
            ),

            //======================= 정보
            Text(
              '$temp\u2103',
              style: GoogleFonts.lato(
                  fontSize: 85,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
            Row(
              children: [
                icon,
                SizedBox(
                  width: 10,
                ),
                Text('$description',
              style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
              ],
            )
          ],
        ),

        //======================= 미세먼지
        Column(
          children: [
            //======================= 라인
            Divider(
              height: 15,
              thickness: 2,
              color: Colors.white30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // MyBottomWidget(
                //   text1: 'AQI(대기질지수)',
                //   imageName: 'good',
                //   text2: '',
                //   textBottom: '매우나쁨',
                // ),
                Column(
                  children: [
                    Text(
                      'AQI(대기질지수)',
                      style: GoogleFonts.lato(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    airIcon,
                    SizedBox(
                      height: 10,
                    ),
                    airState,
                  ],
                ),
                MyBottomWidget(
                  text1: '미세먼지',
                  imageName: 'good',
                  text2: '$dust1',
                  textBottom: '㎍/㎥',
                ),
                MyBottomWidget(
                  text1: '초미세먼지',
                  imageName: 'good',
                  text2: '$dust2',
                  textBottom: '㎍/㎥',
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

// ----- 너무 많으닌까 커스텀 하게 만들어야 한다.
class MyBottomWidget extends StatefulWidget {
  MyBottomWidget({this.text1, this.imageName, this.text2, this.textBottom});

  String? text1;
  String? imageName;
  String? text2;
  String? textBottom;

  @override
  State<MyBottomWidget> createState() => _MyBottomWidgetState();
}

class _MyBottomWidgetState extends State<MyBottomWidget> {

  @override
  void initState() {
    super.initState();

    if (widget.text2!.length == 0) {
      height1 = 40;
      height2 = 0;
    } else {
      height1 = 0;
    }
  }

// 아직 뷰에서 if문을 사용하는걸 잘 몰라서 되는대로 했다.
// 추후 뷰의 선택적 제어를 잘 기억 해야 할듯 하다.
  double height1 = 0;
  double height2 = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.text1}',
          style: GoogleFonts.lato(fontSize: 14, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Image.asset(
          'assets/images/${widget.imageName}.png',
          width: height1,
        ),
        Text(
          '${widget.text2}',
          style: GoogleFonts.lato(fontSize: 30, color: Colors.white, height: height2),
          
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${widget.textBottom}',
          style: GoogleFonts.lato(fontSize: 14, color: Colors.white ,fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
