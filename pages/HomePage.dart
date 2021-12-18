

import '../utils/MyLib.dart';
import 'ChoosePage.dart';

class HomePage extends StatelessWidget {
  final TextEditingController Account = new TextEditingController();
  final TextEditingController Password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>[
          FlutterLogo(),
          TextField(
              controller: Account,
              decoration: InputDecoration(
                hintText: 'please input account:'
              )
          ),
          TextField(
              controller: Password,
              decoration: InputDecoration(
                  hintText: 'please input password:'
              )
          ),
          RaisedButton(
            child: Text('entry'),
            onPressed: () {
              if(BtnEvent(Account, Password)==1)
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context)
                      =>ChoosePage()));
            },
          )
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
