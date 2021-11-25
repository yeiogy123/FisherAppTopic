import 'MyLib.dart';
import 'RecordPage.dart';
import 'CheckPage.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose what you want')
      ),
      body: Choose()
    );
  }
}
class Choose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          RaisedButton(
            child: Text('record the attandence'),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(
                builder:(context)
                => RecordPage()))
          ),
          RaisedButton(
            child: Text('check the attandence'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(
                builder:(context)
                => CheckPage()))
          ),
          RaisedButton(
              child: Text('log out'),
              onPressed: ()=> Navigator.pop(context)
          )
        ]
    );
  }
}
