import 'Mylib.dart';
class NoContentFound extends StatelessWidget {
  final String noContentText;
  final IconData noContentIconData;

  NoContentFound(this.noContentText, this.noContentIconData);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: double.infinity,
      width: double.infinity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(
            noContentIconData,
            color: Colors.blue[400],
            size: 150.0,
          ),
          new Container(
            child: new Text(
              noContentText,
              style: new TextStyle(fontSize: 26.0, color: Colors.blueGrey[400]),
            ),
            margin: EdgeInsets.only(top: 5.0),
          )
        ],
      ),
    );
  }
}