import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
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
            Form(
              child: Theme(
                data: ThemeData(
                  primaryColor: Colors.teal,
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter dice',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Password',
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ButtonTheme(
                        minWidth: 300,
                        height: 80,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent,
                            ),
                            child: Icon(Icons.arrow_forward),
                            onPressed: () {}),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
