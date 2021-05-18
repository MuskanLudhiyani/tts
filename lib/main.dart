import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'only speech',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected_tone=0;
  Color a=Colors.purple;
  Color b=Colors.blue;
  Color c=Colors.black;
  Color d=Colors.black;Color e=Colors.black;
  Color f=Colors.black;
  double _val=0.5;
  double _pitch=1;
  Future speak(String s,double pitch,double rate) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.speak(s);
  }

  @override
  void initState() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OnlySpeech",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'lobster',
                  fontStyle: FontStyle.italic,
                  fontSize: 45,
                ),
              ),
              PopupMenuButton<String>(
                child: Icon(
                  Icons.more_vert,
                  size: 45,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Value1',
                    child: Text('Choose value 1'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Value2',
                    child: Text('Choose value 2'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Value3',
                    child: Text('Choose value 3'),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(
              Icons.arrow_forward_outlined,
              color: Colors.black,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected_tone = 0;
                      c = a;
                      d = b;
                      e = Colors.black;
                      f = Colors.black;
                    });
                  },
                  child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "A",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: <Color>[c, d]),
                      )),
                ),
                Text("Male", style: TextStyle(fontSize: 20))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected_tone = 1;
                      e = a;
                      f = b;
                      c = Colors.black;
                      d = Colors.black;
                    });
                  },
                  child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "B",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: <Color>[e, f]),
                      )),
                ),
                Text(
                  "Female",
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Speed",
                style: TextStyle(fontSize: 35),
              ),
            ),
            Slider(
                value: _val,
                min: 0.0,
                max: 1.0,
                divisions: 10,
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                label: 'Set speed',
                onChanged: (double newValue) {
                  setState(() {
                    _val = newValue.round().toDouble();
                  });
                },
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()} dollars';
                }
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Pitch",
                    style: TextStyle(
                        fontSize: 35

                    ),),
                  Icon(Icons.refresh)
                ],

              ),
            ),
            Slider(
                value: _pitch.toDouble(),
                min: 0.5,
                max: 2.0,
                divisions: 15,
                activeColor: Colors.black,
                inactiveColor: Colors.black,
                label: 'Set pitch',
                onChanged: (double newValue) {
                  setState(() {
                    _pitch = newValue.round().toDouble();
                  });
                },
                semanticFormatterCallback: (double newValue) {
                  return '${newValue.round()} dollars';
                }
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.volume_up,
                    size: 40,
                  ),
                  Text("Set",
                  style: TextStyle(fontSize: 30),)
                ],
              ),
              Text(
                "Set",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        )
      ]),
    ));
  }
}
