import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'shareservice.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _launchEmail() async {
    launch(
        "mailto:rakhi@aeologic.com?subject=TestEmail&body=How are you%20plugin");
  }

  _launchURL() async {
    const url = 'https://flutterdevs.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  int selected_tone = 0;
  Color a = Colors.purple;
  Color b = Colors.blue;
  Color c = Colors.purple;
  Color d = Colors.blue;
  Color e = Colors.black;
  Color f = Colors.black;
  double _val = 1;
  double currval = 1;
  double currval2 = 1;
  double _pitch = 1;

  Future getval() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _val = prefs.getDouble('_val') ?? 1;
      _pitch = prefs.getDouble('_pitch') ?? 1;
    });
  }

  Future saveval() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble('_val', _val);
      prefs.setDouble('_pitch', _pitch);
    });
  }

  Future speak(String s) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(_pitch);
    await flutterTts.setSpeechRate(_val);
    await flutterTts.speak(s);
  }

  showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8,
                              0.0), // 10% of the width, so there are ten blinds.
                          colors: <Color>[Colors.blue, Colors.purple]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "OnlySpeech",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'racing',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 45,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    overlayEntry?.remove();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 45,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                _launchURL();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.play_arrow, color: Colors.white),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Watch a Tutorial",
                                      style: TextStyle(
                                        fontFamily: "poppins",
                                        color: Colors.white,
                                        fontSize: 20,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: _launchEmail,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.flag,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Report an Abuse",
                                      style: TextStyle(
                                        fontFamily: "poppins",
                                        color: Colors.white,
                                        fontSize: 20,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Share this app",
                                    style: TextStyle(
                                      fontFamily: "poppins",
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("About",
                                    style: TextStyle(
                                      fontFamily: "poppins",
                                      color: Colors.white,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ));

    overlayState?.insert(overlayEntry);
  }

  String _sharedText = "";

  @override
  void initState() {
    super.initState();
    getval();
    ShareService()
      // Register a callback so that we handle shared data if it arrives while the
      // app is running
      ..onDataReceived = _handleSharedData

      // Check to see if there is any shared data already, meaning that the app
      // was launched via sharing.
      ..getSharedData().then(_handleSharedData);
  }

  void _handleSharedData(String sharedData) {
    setState(() {
      _sharedText = sharedData;
      speak(_sharedText);
      _sharedText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "OnlySpeech",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'racing',
                        fontStyle: FontStyle.italic,
                        fontSize: 45,
                      ),
                    ),
                    GestureDetector(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                          size: 45,
                        ),
                        onTap: () {
                          showOverlay(context);
                        })
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Watch a Tutorial',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.play_arrow,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.arrow_forward_outlined,
          //       color: Colors.black,
          //     ),
          //     Column(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selected_tone = 0;
          //               c = a;
          //               d = b;
          //               e = Colors.black;
          //               f = Colors.black;
          //             });
          //           },
          //           child: Container(
          //               width: 100,
          //               height: 100,
          //               alignment: Alignment.center,
          //               child: Container(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   "A",
          //                   style: TextStyle(
          //                       fontSize: 30, fontWeight: FontWeight.bold),
          //                 ),
          //                 height: 90,
          //                 width: 90,
          //                 decoration: BoxDecoration(
          //                     shape: BoxShape.circle, color: Colors.white),
          //               ),
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 gradient: LinearGradient(
          //                     begin: Alignment.topLeft,
          //                     end: Alignment(0.8,
          //                         0.0), // 10% of the width, so there are ten blinds.
          //                     colors: <Color>[c, d]),
          //               )),
          //         ),
          //       ],
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Column(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             setState(() {
          //               selected_tone = 1;
          //               e = a;
          //               f = b;
          //               c = Colors.black;
          //               d = Colors.black;
          //             });
          //           },
          //           child: Container(
          //               width: 100,
          //               height: 100,
          //               alignment: Alignment.center,
          //               child: Container(
          //                 alignment: Alignment.center,
          //                 child: Text(
          //                   "B",
          //                   style: TextStyle(
          //                       fontSize: 30, fontWeight: FontWeight.bold),
          //                 ),
          //                 height: 90,
          //                 width: 90,
          //                 decoration: BoxDecoration(
          //                     shape: BoxShape.circle, color: Colors.white),
          //               ),
          //               decoration: BoxDecoration(
          //                 shape: BoxShape.circle,
          //                 gradient: LinearGradient(
          //                     begin: Alignment.topLeft,
          //                     end: Alignment(0.8,
          //                         0.0), // 10% of the width, so there are ten blinds.
          //                     colors: <Color>[e, f]),
          //               )),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Speed",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "poppins",
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.replay),
                      onTap: () {
                        setState(() {
                          currval = 1;
                        });
                      },
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.black,
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                ),
                child: Container(
                  child: Slider(
                      value: currval.toDouble(),
                      min: 0.0,
                      max: 3.0,
                      divisions: 10,
                      label: 'Set speed',
                      onChanged: (double newValue) {
                        setState(() {
                          currval = newValue;
                        });
                      },
                      semanticFormatterCallback: (double newValue) {
                        return '${newValue.round()} dollars';
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pitch",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "poppins",
                      ),
                    ),
                    GestureDetector(
                      child: Icon(Icons.replay),
                      onTap: () {
                        setState(() {
                          currval2 = 1;
                          print(currval);
                        });
                      },
                    )
                  ],
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.black,
                  trackShape: RectangularSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                ),
                child: Container(
                  child: Slider(
                      value: currval2.toDouble(),
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      label: 'Set pitch',
                      onChanged: (double newValue) {
                        setState(() {
                          currval2 = newValue;
                        });
                      },
                      semanticFormatterCallback: (double newValue) {
                        return '${newValue.round()} dollars';
                      }),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 30, 60, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.volume_up,
                        size: 40,
                      ),
                      onTap: () {
                        speak(
                            'OnlySpeech Text To Speech is a mobile app that allows people with ADHD, dyslexia, vision problems, concussions, and other reading difficulties to have any text read out to them using a computer generated text to speech voice.');
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _val = currval;
                          _pitch = currval2;
                          print(_pitch);
                          print(_val);
                          saveval();
                        });
                      },
                      child: Text(
                        "Set",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "racing",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          )
        ])));
  }
}
