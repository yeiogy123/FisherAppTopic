

import '../utils/MyLib.dart';
import 'ChoosePage.dart';

class HomePage extends StatelessWidget {
  final TextEditingController Account = TextEditingController();
  final TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          Container(
            width: 350.0,
            height: 80,
            padding: EdgeInsets.fromLTRB(110,20 , 0, 0),
            child: Text(
                'Fisher',
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                ),
            ),
          ),
          Container(
            width: 350,
            height: 35,
            padding: EdgeInsets.fromLTRB(250,0 , 0, 0),
            child: Text(
                'Log In',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, top: 0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: new Border.all(width: 1, color: Colors.grey),
              ),
              padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
              width: 350.0,
              child: TextField(
                  controller: Account,
                  decoration: const InputDecoration(
                      hintText: 'please input Account:'
                  ),
                  style: TextStyle(
                      fontSize: 15.0,
                      height: 1.0,
                      color: Colors.black
                  )
              )

          ),
          Container(
              margin: EdgeInsets.only(left: 20, top: 40),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: new Border.all(width: 1, color: Colors.grey),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              width: 350.0,
              child: TextField(
                  controller: Password,
                  decoration: const InputDecoration(
                      hintText: 'please input Password:'
                  ),
                  style: TextStyle(
                      fontSize: 15.0,
                      height: 1.0,
                      color: Colors.black
                  )
              )
          ),
          Container(
              margin: EdgeInsets.only(left: 280, top: 10),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                border: new Border.all(width: 1, color: Colors.white),
              ),
              width: 350,
              height: 55,
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: RaisedButton(

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(
                    'entry'
                ),

                onPressed: () {
                  if(BtnEvent(Account, Password)==1)
                  Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)
                  =>ChoosePage()));
                },
              )
          ),

        ]
    );
  }
  int BtnEvent(TextEditingController account,
      TextEditingController password){
    if(account.text == 'account' &&
        password.text == 'password'){
      print('login success');
      return 1;
    }else
      print('login fail');
    return 0;
  }
}
