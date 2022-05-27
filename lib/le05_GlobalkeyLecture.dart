import 'package:flutter/material.dart';

class GlobalkeyLecture extends StatelessWidget {
  const GlobalkeyLecture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyKey(),
    );
  }
}

class MyKey extends StatelessWidget {
  final counterKey = GlobalKey<_CounterState>(); // 글로벌 키 할당

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global key'),
      ),
      body: Center(
        child: Counter(
          key: counterKey, // 키 선언
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          counterKey.currentState!.increment(); // 글로벌키는 _CounterState 클래스로 이루어져 있음... 내부의 함수 호출... 
          print(counterKey.currentState!.count);
        },
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Count number: $count',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
