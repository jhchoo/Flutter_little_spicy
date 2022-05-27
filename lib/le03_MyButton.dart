import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({this.image, this.text, this.color, this.radous, this.onPressed}); // 생성자가 대괄호 안에 있어야 한다.

  final Widget? image;
  final Widget? text;
  final Color? color;
  final double? radous;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme( // 재사용 가능한 버튼으로 만들어야 하는데 귀찮아서... 안했군
              height: 50.0,
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    image!, //Image.asset('assets/images/glogo.png'),
                    text!, // Text('Login with Google', style: TextStyle(color: Colors.black87, fontSize: 15.0)),
                    Opacity( // 투명도 설정
                      opacity: 0.0,
                      child: Image.asset('assets/images/glogo.png'),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: color, //Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              
                ),
                onPressed: onPressed,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radous!),
                ),
              ),
            );
  }
}