import 'DashBoardPage.dart';
import '../utils/MyLib.dart';
import 'CheckPage.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose what you want')
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
            child: const Text('record the attendance'),
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(
                builder:(context)
                => DashBoardPage()))
          ),
          RaisedButton(
            child: const Text('check the attendance'),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(
                builder:(context)
                => CheckPage()))
          ),
          RaisedButton(
              child: const Text('log out'),
              onPressed: ()=> Navigator.pop(context)
          )
        ]
    );
  }
}
