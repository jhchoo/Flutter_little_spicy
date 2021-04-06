import 'package:flutter/material.dart';
import 'le01_MyHomePage.dart';
import 'le02_LoginDiceapp.dart';
import 'le03_LoginView.dart';
import 'le04_weather.dart';
import 'le04_weatherSplash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      // home: LoginDice()
      // home: LoginView(),
      // home: WeatherMain(),

      initialRoute: '/', // home을 빼고 route를 사용한다. ScreenA
      routes: {
        '/': (_) => WeatherSplash(),
        '/search': (_) => WeatherSrarch(),
      },
    );
  }
}
