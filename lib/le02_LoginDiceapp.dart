import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class LoginDice extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginDice> {

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( // 모든 뷰는 Scaffold 위에 그려진다.
      // 앱바
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),

      // 바디 내용
      body: GestureDetector( // 제스쳐 감지
        onTap: () {
          FocusScope.of(context).unfocus(); // 포커스 스코프를 사용한 키보드 내리기
        },
        // 사용하고자 하는 위젯의 최상위 Class를 SingleChildScrollView로 감싸주면 됩니다.
        // BuildContext 빌드컨텍스트란? 현재의 위치를 지정한다.
        // 외부 함수로 빼는거랑 같은 의미네...
        // 빌더가 있어야 Scaffold.of(context) 가 제대로 먹힌다.
        // 근데... ScaffoldMessenger 이거쓰면 별 문제가 없는데??
        child: Builder(
          builder:(context) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50)),
                Center(
                  child: Image(
                    image: AssetImage('images/small-chef.png'),
                    width: 190.0,
                    height: 190.0,
                  ),
                ),
                // 폼이란?
                // 
                Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                      ),
                    ),
                    // 컨테이너는 안에 비어있는 내용을 넣을 수 있다.
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Column( // 세로
                        children: [
                          TextField( // 텍스트 필드
                            controller: controller, // 텍스트 필드와 컨트롤러를 연결해서 값을 가져올 수 있다.
                            decoration: InputDecoration(
                              labelText: 'Enter dice',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField( // 텍스트 필드
                            controller: controller2, // 텍스트 필드와 컨트롤러를 연결해서 값을 가져올 수 있다.
                            decoration: InputDecoration(
                              labelText: 'Enter Password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          SizedBox( // 빈공간
                            height: 40,
                          ),
                          // RaisedButton 이건 기본 버튼이다.
                          ElevatedButton( // 이동 버튼 
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent,
                                  minimumSize: Size(100, 64)),
                              child: Icon(Icons.arrow_forward),
                              onPressed: () {
                                // 텍스트 필드의 값을 가져올 수 있다.
                                if (controller.text == 'dice' &&
                                    controller2.text == '1234') {
                                  // 네비게이터를 사용해서  Dice 로 이동이 가능하다.
                                  Navigator.push(context,
                                      // MaterialPageRoute(builder: (BuildContext context) => Dice()));
                                      MaterialPageRoute(builder: (_) => Dice())); // 컨텍스트를 생략 할 수 있다.
                                } else if (controller.text == '' &&
                                    controller2.text == '') {
                                  // 바로 이동 하자.
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => Dice()));

                                } else {
                                  showSnackBar(context);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

// 스넥바는 하단 토스트 메세지 이다.
void showSnackBar(BuildContext context) {
  // ScaffoldMessenger.of(context) 루트뷰를 찾는다고 보면 된다.
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      '아이디 또는 비밀번호를 확인하세요.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.blue,
  ));
}


//=====================================================
// Dice.dart
//=====================================================


class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int leftDice = 1;
  int rightDice = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Dice Game'),
      ),
      body: Center( // 중앙
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 메인엑세스 얼라인
          children: [
            Padding(
              padding: EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 내부 정렬 위치
                children: [
                  Expanded(child: Image.asset('images/dice$leftDice.png')), // Image.asset 이미지 불러오기
                  SizedBox(width: 20),
                  Expanded(child: Image.asset('images/dice$rightDice.png')), // flex 라는 속성도 있다.
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // 값이 변하면 뷰를 변환하게 만들어 주는 함수
                // 함수를 안에 만들었네.
                setState(() {
                  leftDice = Random().nextInt(6) + 1; // 랜덤
                  rightDice = Random().nextInt(6) + 1; // 랜덤
                });
                showToast("좌측 주사위: $leftDice, 우측 주사위: $rightDice");
              },
              child: Icon(Icons.play_arrow, color: Colors.white, size: 50),
              style: ElevatedButton.styleFrom(
                primary: Colors.orangeAccent,
                minimumSize: Size(100, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast( // 이건 플러터 토스트다.
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 20.0);
}
