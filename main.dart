
//import material function lib
import 'utils/MyLib.dart';
import 'pages/HomePage.dart';


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