import 'package:flutter/material.dart';
import '../DB/timeDB.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';

DateTime d = DateTime.now();

List<int> form=[
  0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0
];

class Day_24hr extends StatelessWidget {
  String name='';
  int c_day=0;
  Day_24hr({Key? key, this.name='',this.c_day=0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ToDB();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () { Navigator.pop(context); },
            );
          },
        ),
        title: const Text('Working Table',
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
          children: [
            Text('$name\'s working time table', style: const TextStyle(fontSize: 30)),
            Table(
              columnWidths: {
                0: const FractionColumnWidth(0.16),
                1: const FractionColumnWidth(0.16),
                2: const FractionColumnWidth(0.16),
                3: const FractionColumnWidth(0.16),
                4: const FractionColumnWidth(0.16),
                5: const FractionColumnWidth(0.16),
              },//每個佔14%
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //設定表格樣式
              border: TableBorder.all(
                  color: Colors.black87, width: 3.0, style: BorderStyle.solid),
              children: <TableRow>[
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('0:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('1:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('1:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('2:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('2:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('3:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//0~3
                TableRow(
                  children: <Widget>[
                    if(form[0]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[0]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[1]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[1]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[2]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[2]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[3]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[3]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[4]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[4]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[5]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[5]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//0~3 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('3:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('4:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('4:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('5:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('5:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('6:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//3~6
                TableRow(
                  children: <Widget>[
                    if(form[6]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[6]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[7]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[7]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[8]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[8]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[9]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[9]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[10]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[10]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[11]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[11]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//3~6 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('6:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('7:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('7:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('8:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('8:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('9:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//6~9
                TableRow(
                  children: <Widget>[
                    if(form[12]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[12]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[13]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[13]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[14]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[14]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[15]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[15]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[16]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[16]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[17]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[17]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//6~9 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('9:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('10:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('10:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('11:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('11:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('12:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//9~12
                TableRow(
                  children: <Widget>[
                    if(form[18]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[18]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[19]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[19]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[20]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[20]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[21]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[21]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[22]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[22]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[23]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[23]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//9~12 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('12:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('13:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('13:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('14:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('14:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('15:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//12~15
                TableRow(
                  children: <Widget>[
                    if(form[24]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[24]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[25]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[25]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[26]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[26]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[27]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[27]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[28]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[28]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[29]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[29]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//12~15 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('15:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('16:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('16:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('17:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('17:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('18:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//15~18
                TableRow(
                  children: <Widget>[
                    if(form[30]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[30]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[31]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[31]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[32]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[32]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[33]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[33]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[34]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[34]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[35]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[35]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//15~18 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('18:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('19:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('19:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('20:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('20:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('21:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//18~21
                TableRow(
                  children: <Widget>[
                    if(form[36]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[36]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[37]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[37]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[38]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[38]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[39]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[39]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[40]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[40]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[41]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[41]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//18~21 work or not
                const TableRow(
                  children: <Widget>[
                    Center(child: Text('21:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('22:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('22:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('23:00', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('23:30', style: TextStyle(fontSize: 20)),),
                    Center(child: Text('24:00', style: TextStyle(fontSize: 20)),),
                  ],
                ),//21~24
                TableRow(
                  children: <Widget>[
                    if(form[42]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[42]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[43]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[43]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[44]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[44]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[45]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[45]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[46]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[46]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                    if(form[47]==1)Center(child: Text(' V ', style: const TextStyle(fontSize: 20)),),
                    if(form[47]==0)Center(child: Text(' ', style: const TextStyle(fontSize: 20)),),
                  ],
                ),//21~24 work or not
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future ToDB() async {
    split_time_table a = split_time_table.get();
    form = await a.day_work_table(name, d, c_day);
  }
}
