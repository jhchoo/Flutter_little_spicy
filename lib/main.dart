import 'package:flutter/material.dart';
import 'le01_MyHomePage.dart';
import 'le02_LoginDiceapp.dart';
import 'le03_LoginView.dart';
import 'le04_WeatherApp/Loading.dart';
import 'le05_GlobalkeyLecture.dart';
import 'le05_GlobalkeyScaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 조금 매운맛',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //=============================================
      // 여기에서 개별 페이지 호출을 구현 한다.
      // 실제로 이런 페이지가 있어야 개발 구현이 편하다.

      // 첫번째 예제
      // home: MyHomePage(title: 'Flutter 첫번째 강의'),

      // 두번째 예제
      // home: LoginDice(),

      // 세번째 예제
      // home: LoginView(),

      // 네번째 예제 - 날씨 앱 
      home: Loading(),

      // 2021.07 널포인트 및 key에 대한 없데이트가 있어서
      // 중요 패치사항을 체크 하고 넘어가야 한다.
      // home: GlobalkeyLecture(), // 글로벌 키 사용법
      // home: GlobalkeyScaffold(), // 스케폴드의 최상위 값을 알 수 있다.

      // 다섯번째 예제 - 채팅 앱 


      //=============================================
    );
  }
}
