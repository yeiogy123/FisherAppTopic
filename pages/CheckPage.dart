import '../utils/MyLib.dart';

class CheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('CheckPage')
        ),
        body: Check()
    );
  }
}
class Check extends StatelessWidget {

  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              child: Text('turn back'),
              onPressed: () => Navigator.pop(context)
          )
        ]
    );
  }
}
