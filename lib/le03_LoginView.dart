import 'package:flutter/material.dart';
import 'le02_LoginDiceapp.dart';
import 'le03_MyButton.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.2,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 플루터는 댑스가 많아서 재사용을 효율적으로 사용 해야 한다.
            // 새로운 Material Button들(TextButton, ElevatedButton, OutlinedButton)의 탄생 목적은 생성자 매개 변수와 테마를 통해 버튼을보다 유연하고 쉽게 구성하는 것이 목표입니다.
            // TextButton, ElevatedButton, OutlinedButton
            ButtonTheme( // 재사용 가능한 버튼으로 만들어야 하는데 귀찮아서... 안했군
              height: 50.0,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/glogo.png'),
                    Text(
                      'Login with Google',
                      style: TextStyle(color: Colors.black87, fontSize: 15.0),
                    ),
                    Opacity( // 투명도 설정
                      opacity: 0.0,
                      child: Image.asset('assets/images/glogo.png'),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              
                ),
                onPressed: () {

                  showToast("로그인 구글 버튼");

                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            MyButton (
              image: Image.asset('assets/images/glogo.png'),
              text: Text('Login with Google', style: TextStyle(color: Colors.black87, fontSize: 15.0)),
              color: Colors.white,
              radous: 4.0,
              onPressed: (){},
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('assets/images/flogo.png'),
                    Text(
                      'Login with Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Image.asset('assets/images/glogo.png'),
                    ),
                  ],
                ),
                color: Color(0xFF334D92),
                onPressed: () {

                  showToast("로그인 페이스북 버튼");

                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      color: Colors.white,
                    ),
                    Text(
                      'Login with Email',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                color: Colors.green,
                onPressed: () {

                  showToast("로그인 이메일 버튼");

                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
