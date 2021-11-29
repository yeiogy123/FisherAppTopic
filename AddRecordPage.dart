class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //var timeList = [DateTime.now(), DateTime.now()];
    return Scaffold(
        appBar: AppBar(
          title: const Text("Fisher"),
          leading: const Icon(FontAwesomeIcons.fish),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonTheme(
                    minWidth: 300.0,
                    height: 100,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TodayMode()));
                      },
                      child: const Text(
                        "Today",
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                  ButtonTheme(
                    //buttonColor: Colors.deepOrange,
                    minWidth: 300.0,
                    height: 100,
                    child: RaisedButton(
                      onPressed: () {
                        //Scaffold.of(context).removeCurrentSnackBar();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OtherDayMode()));
                      },
                      child: const Text("Other Day",
                          style: TextStyle(fontSize: 20)),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class TodayMode extends StatelessWidget {
  const TodayMode({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //DateTime startTime = DateTime.now();
    //DateTime finishTime = DateTime.now();
    var timeList = [DateTime.now(), DateTime.now()];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(height: 50, width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        "Start time",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (data) {
                        timeList[0] = data;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 50, width: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(
                        "Finish time",
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
                SizedBox(
                    height: 150,
                    width: 150,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (data) {
                        timeList[1] = data;
                      },
                    )),
              ],
            ),
            const SizedBox(height: 50, width: 100),
            ButtonTheme(
                buttonColor: Colors.red,
                height: 50,
                minWidth: 100,
                child: RaisedButton(
                    onPressed: () {
                      print("start :$timeList[0]\n");
                      print("finish :$timeList[1]\n");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ))),
            const SizedBox(height: 50, width: 100),
          ],
        ),
      ),
    );
  }
}

class OtherDayMode extends StatelessWidget {
  const OtherDayMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //DateTime startTime = DateTime.now();
    //DateTime finshTime = DateTime.now();
    var timeList = [DateTime.now(), DateTime.now()];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other Day Mode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(height: 50, width: 100),
            const SizedBox(
                width: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    "Start time",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (data) {
                timeList[0] = data;
              },
            )),
            const SizedBox(height: 50, width: 100),
            const SizedBox(
                width: 100,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    "Finish time",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (data) {
                timeList[1] = data;
              },
            )),
            const SizedBox(height: 50, width: 100),
            ButtonTheme(
                buttonColor: Colors.red,
                height: 50,
                minWidth: 100,
                child: RaisedButton(
                    onPressed: () {
                      print(timeList[0]);
                      print(timeList[1]);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ))),
            const SizedBox(height: 50, width: 100),
          ],
        ),
      ),
    );
  }
}
