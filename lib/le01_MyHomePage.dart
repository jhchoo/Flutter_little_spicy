import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  
  // 외부에서 타이틀을 받기 위해서 생성자를 만든다.
  MyHomePage({Key? key, this.title}) : super(key: key);

  String? title;

  // createState 함수는 항상 호출 된다.
  // => 형식 사용 가능
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> { // State<MyHomePage>

  // 이 변수가 state 변수가 되는거다.
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    print('초기화 호출');
  }

  @override
  void dispose() {
    super.dispose();
    print('객체 제거 호출');
  }


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center( // 가운데
        child: Column( // 세로 위젯
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4, // 스타일 적용
            ),
            Row( // 가로 위젯
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton( // 플로팅 버튼
                    onPressed: _incrementCounter, child: Icon(Icons.add)),
                SizedBox(width: 10),
                FloatingActionButton( // 플로팅 버튼
                    onPressed: _decrementCounter, child: Icon(Icons.remove)),
              ],
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
