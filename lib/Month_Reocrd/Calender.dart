import 'package:flutter/material.dart';

DateTime time = DateTime.now();
int month = time.month;
String month_text = month.toString();
int day = time.day;

class Calender extends StatelessWidget {
  const Calender({Key? key, day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context,day); },
            );
          },
        ),
        title: const Text('Calendar',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child:  Text.rich(
                    TextSpan(
                      text:'Month: ',
                      style: TextStyle(
                          fontSize: 50,
                        color:Colors.blue,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(month_text, style: TextStyle(fontSize: 50)),
                ),
              ],
            ),
            Table(
              columnWidths: {
                0: const FractionColumnWidth(0.14),
                1: const FractionColumnWidth(0.14),
                2: const FractionColumnWidth(0.14),
                3: const FractionColumnWidth(0.14),
                4: const FractionColumnWidth(0.14),
                5: const FractionColumnWidth(0.14),
                6: const FractionColumnWidth(0.14),
                7: const FractionColumnWidth(0.14),
              },//每個佔14%
              //設定表格樣式
              border: TableBorder.all(
                  color: Colors.white60, width: 3.0, style: BorderStyle.solid),
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 1;
                        Navigator.pop(context,day);
                      },
                      child: const Text('1'),
                    ),//1
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 2;
                        Navigator.pop(context,day);
                      },
                      child: const Text('2'),
                    ),//2
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 3;
                        Navigator.pop(context,day);
                      },
                      child: const Text('3'),
                    ),//3
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 4;
                        Navigator.pop(context,day);
                      },
                      child: const Text('4'),
                    ),//4
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 5;
                        Navigator.pop(context,day);
                      },
                      child: const Text('5'),
                    ),//5
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 6;
                        Navigator.pop(context,day);
                      },
                      child: const Text('6'),
                    ),//6
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 7;
                        Navigator.pop(context,day);
                      },
                      child: const Text('7'),
                    ),//7
                  ],
                ),//row1
                TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 8;
                        Navigator.pop(context,day);
                      },
                      child: const Text('8'),
                    ),//8
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 9;
                        Navigator.pop(context,day);
                      },
                      child: const Text('9'),
                    ),//9
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 10;
                        Navigator.pop(context,day);
                      },
                      child: const Text('10'),
                    ),//10
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 11;
                        Navigator.pop(context,day);
                      },
                      child: const Text('11'),
                    ),//11
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 12;
                        Navigator.pop(context,day);
                      },
                      child: const Text('12'),
                    ),//12
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 13;
                        Navigator.pop(context,day);
                      },
                      child: const Text('13'),
                    ),//13
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 14;
                        Navigator.pop(context,day);
                      },
                      child: const Text('14'),
                    ),//14
                  ],
                ),//row2
                TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 15;
                        Navigator.pop(context,day);
                      },
                      child: const Text('15'),
                    ),//15
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 16;
                        Navigator.pop(context,day);
                      },
                      child: const Text('16'),
                    ),//16
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 17;
                        Navigator.pop(context,day);
                      },
                      child: const Text('17'),
                    ),//17
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 18;
                        Navigator.pop(context,day);
                      },
                      child: const Text('18'),
                    ),//18
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 19;
                        Navigator.pop(context,day);
                      },
                      child: const Text('19'),
                    ),//19
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 20;
                        Navigator.pop(context,day);
                      },
                      child: const Text('20'),
                    ),//20
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 21;
                        Navigator.pop(context,day);
                      },
                      child: const Text('21'),
                    ),//21
                  ],
                ),//row3
                TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 22;
                        Navigator.pop(context,day);
                      },
                      child: const Text('22'),
                    ),//22
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 23;
                        Navigator.pop(context,day);
                      },
                      child: const Text('23'),
                    ),//23
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 24;
                        Navigator.pop(context,day);
                      },
                      child: const Text('24'),
                    ),//24
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 25;
                        Navigator.pop(context,day);
                      },
                      child: const Text('25'),
                    ),//25
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 26;
                        Navigator.pop(context,day);
                      },
                      child: const Text('26'),
                    ),//26
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 27;
                        Navigator.pop(context,day);
                      },
                      child: const Text('27'),
                    ),//27
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 28;
                        Navigator.pop(context,day);
                      },
                      child: const Text('28'),
                    ),//28
                  ],
                ),//row4
                if(time.month!=2 || (time.month==2 && (time.year/4) ==0 && ((time.year/100) !=0 || (time.year/400) ==0)))TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 29;
                        Navigator.pop(context,day);
                      },
                      child: const Text('29'),
                    ),//29
                    if(time.month!=2) ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 30;
                        Navigator.pop(context,day);
                      },
                      child: const Text('30'),
                    ),//30
                    if(time.month==2) ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//30,2月沒有30天,NULL button
                    if(time.month==1 || time.month==3 || time.month==5 || time.month==7 || time.month==8 || time.month==10 || time.month==12) ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: (){
                        day = 31;
                        Navigator.pop(context,day);
                      },
                      child: const Text('31'),
                    ),//31
                    if(time.month==2 || time.month==4 || time.month==6 || time.month==9 || time.month==11) ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//31,小月沒有31天,NULL button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//No 32 day,NULL button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//No 33 day,NULL button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//No 34 day,NULL button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey, // background
                        onPrimary: Colors.black54, // foreground
                        shadowColor: Colors.transparent,
                        minimumSize: const Size(200, 50),
                        textStyle:
                        const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                      onPressed: null,
                      child: const Text(''),
                    ),//No 35 day,NULL button
                  ],
                ),//row 5
              ],
            ),
          ]
      ),
    );
  }
}
