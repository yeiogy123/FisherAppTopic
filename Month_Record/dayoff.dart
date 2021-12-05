import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Day Off'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController myController = new TextEditingController();
  final TextEditingController myController1 = new TextEditingController();
  final TextEditingController myController2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Date(Start)',
          style: TextStyle(fontSize: 20)),
        TextField(
          controller: myController,
          decoration: InputDecoration(hintText: 'Date format:YYYY/MM/DD'),
          maxLines: 1,
        ),
        Text('Date(End)',
            style: TextStyle(fontSize: 20)),

        TextField(
          controller: myController1,
          decoration: InputDecoration(hintText: 'Date format:YYYY/MM/DD'),
          maxLines: 1,
        ),
        Text('Reason',
            style: TextStyle(fontSize: 20)),
        TextField(
          controller: myController2,
          decoration: InputDecoration(hintText: 'Enter your reason'),
          maxLines: 3,
        ),
        ElevatedButton(
          child: Text('送出'),
          onPressed: btnEvent,
        )
      ],
    );
  }

  void btnEvent() {
    print(myController.text);
    print(myController1.text);
    print(myController2.text);
  }
}

