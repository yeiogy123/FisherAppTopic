import 'package:fish/Month_Reocrd/MonthPage.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget>[
          Container(
            margin: EdgeInsets.only(left: 30, top: 50),
            child: Text.rich(
              TextSpan(
                text: 'Welcome(つ´ω`)つ',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 30, top: 80),
              width: 350,
              height: 100,
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text.rich(
                  TextSpan(
                    text: 'Record the attandence',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),

                ),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(
                      builder:(context)
                          => DashBoardPage()))
                ,
              )
          ),
          Container(
              margin: EdgeInsets.only(left: 30, top: 50),
              width: 350,
              height: 100,
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text.rich(
                  TextSpan(
                    text: 'Check the attandence',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),

                ),
                onPressed: ()  => Navigator.push(
                    context, MaterialPageRoute(
                      builder:(context)
                      => Checkapp()))
                )
          ),
          Container(
              margin: EdgeInsets.only(left: 30, top: 50),
              width: 350,
              height: 100,
              padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text.rich(
                  TextSpan(
                    text: 'Log out',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),

                ),
                onPressed: () => Navigator.pop(context),
              )
          ),
        ]
    );
  }
}

