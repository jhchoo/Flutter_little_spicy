import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Model {
  Widget getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'assets/svg/Cloud-Lightning.svg',
        color: Colors.white,
      );
    }
    if (condition < 600) {
      return SvgPicture.asset(
        'assets/svg/Cloud-Snow.svg',
        color: Colors.white,
      );
    }

    if (condition == 800) {
      return SvgPicture.asset(
        'assets/svg/Sun.svg',
        color: Colors.white,
      );
    }

    return SvgPicture.asset(
      'assets/svg/Cloud-Sun.svg',
      color: Colors.white,
    );
  }

  // ---- 대기 아이콘
  Widget getAirIcon(int? index) {
    if (index == 1) {
      return Image.asset(
        'assets/images/good.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 2) {
      return Image.asset(
        'assets/images/fair.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 3) {
      return Image.asset(
        'assets/images/moderate.png',
        width: 37.0,
        height: 35.0,
      );
    } else if (index == 4) {
      return Image.asset(
        'assets/images/poor.png',
        width: 37.0,
        height: 35.0,
      );
    }

      return Image.asset(
        'assets/images/bad.png',
        width: 37.0,
        height: 35.0,
      );
    
  }

  Widget getAirCondition(int? index) {
    if (index == 1) {
      return Text(
        '"매우좋음"',
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 2) {
      return Text(
        '"좋음"',
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 3) {
      return Text(
        '"보통"',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (index == 4) {
      return Text(
        '"나쁨"',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      );
    }// else if (index == 5) {
      return Text(
        '"매우나쁨"',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      );
    //}
  }

}
