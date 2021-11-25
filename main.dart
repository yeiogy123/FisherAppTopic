
//import material function lib
import 'MyLib.dart';
import 'HomePage.dart';


void main(){
  //runApp is the entry for Flutter
  runApp(MyApp())
  ;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          title: const Text('Login Page')
        ),
        body: HomePage()
      ),
    );
  }
}