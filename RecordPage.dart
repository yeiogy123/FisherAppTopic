import 'MyLib.dart';
class Record{
  String ?Name, Id, PhoneNum;
  Record({this.Name, this.Id, this.PhoneNum});
  factory Record.fromjson(Map<String, dynamic> json){
    return new Record(
      Name: json['Name'],
      Id: json['id'],
      PhoneNum: json['PhoneNum']
    );
  }
}
class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState(){
    return _RecordPageState();
  }
}
class _RecordPageState extends State<RecordPage> {
  /*
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          RaisedButton(
            child: Text('turn back'),
            onPressed: ()=> Navigator.pop(context)
          )
        ]
    );
  }*/
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text('RecordPage')
        )
    );
  }
}
