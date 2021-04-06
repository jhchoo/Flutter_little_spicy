import 'package:flutter/material.dart';

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
      body: _buildButtons(),
    );
  }

  // 언더바가 들어가면 private
  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyButton(
              image: Image.asset('images/glogo.png'),
              text: Text(
                'Login with Google',
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              color: Colors.white,
              radius: 4.0,
              onPressed: () {}),
          SizedBox(
            height: 10.0,
          ),
          MyButton(
              image: Image.asset('images/flogo.png'),
              text: Text(
                'Login with Facebook',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              color: Color(0xFF334D92),
              radius: 4.0,
              onPressed: () {}),
          SizedBox(
            height: 10.0,
          ),
          MyButton(
              image: Icon(
                Icons.mail,
                color: Colors.white,
              ),
              text: Text(
                'Login with Email',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              color: Colors.green,
              radius: 4.0,
              onPressed: () {}),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({this.image, this.text, this.color, this.radius, this.onPressed});

  final Widget image;
  final Widget text;
  final Color color;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50.0,
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            this.image,
            this.text,
            Opacity(
              opacity: 0.0,
              child: this.image,
            ),
          ],
        ),
        color: this.color,
        onPressed: () {},
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(this.radius),
        ),
      ),
    );
  }
}
