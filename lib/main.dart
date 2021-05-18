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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedTone=0;
  Color a=Colors.purple;
  Color b=Colors.blue;
  Color c=Colors.purple;
  Color d=Colors.blue;
  Color e=Colors.black;
  Color f=Colors.black;
  double _val=0.5;
  double _pitch=1;
  showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          top: 0,
          right:0,
          left: 0,

          child: menu,
        ));


    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 2));

    overlayEntry.remove();
  }
  Widget menu=Material(
    type: MaterialType.transparency,
    child: Container(
        decoration: BoxDecoration(

          gradient:LinearGradient(
              begin: Alignment.topLeft,
              end:
              Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Colors.blue, Colors.purple
              ]),
        ),


        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    SizedBox(height: 20,),
                    Text("OnlySpeech",


                      style: TextStyle(

                        color: Colors.white,
                        fontFamily: 'lobster',
                        fontStyle: FontStyle.italic,
                        fontSize: 45,
                      ),),
                    SizedBox(width: 50,),
                    GestureDetector(
                      onTap: (){


                      },

                      child: Icon(Icons.close ,color: Colors.white,size: 45,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                  children: [
                    Icon(Icons.play_arrow,color: Colors.white),
                    SizedBox(width: 20,),
                    Text("Watch a Tutorial",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                  children: [
                    Icon(Icons.flag,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("Report an Abuse",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                  children: [
                    Icon(Icons.share,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("Share this app",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(

                  children: [
                    Icon(Icons.info,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text("About",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    )),
                  ],
                ),
              )



            ],

          ),
        )
    ),
  );
  Future speak(String s,double pitch,double rate) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.speak(s);
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(


          children: <Widget>[
            SizedBox(height: 40,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("OnlySpeech",

                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'lobster',
                  fontStyle: FontStyle.italic,
                  fontSize: 45,
                ),),
                SizedBox(width: 50,),
                GestureDetector(
                  onTap:() {
                    showOverlay(context);
                  },
                  child: Icon(Icons.more_vert ,color: Colors.black,size: 45,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(

              children: [

                Icon(Icons.arrow_forward_outlined,color: Colors.black,),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTone=0;
                          c=a;
                          d=b;
                          e=Colors.black;
                          f=Colors.black;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("A",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                            ),),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                          ),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient:LinearGradient(
                                begin: Alignment.topLeft,
                                end:
                                Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                colors: <Color>[
                                  c,d
                                  ]),
                          )

                      ),
                    ),
                    Text("Male",style: TextStyle(
                        fontSize: 20)

                    )],
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedTone=1;
                          e=a;
                          f=b;
                          c=Colors.black;
                          d=Colors.black;
                        });
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("B",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                          ),

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient:LinearGradient(
                                begin: Alignment.topLeft,
                                end:
                                Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                colors: <Color>[
                                  e,f
                                ]),
                          )

                      ),
                    ),
                    Text("Female",style: TextStyle(
                      fontSize: 20
                    ),)

                  ],
                ),

          ],
        ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Speed",
                  style: TextStyle(
                    fontSize: 35

                  ),),
                  Icon(Icons.refresh)
                ],

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
                    _val = newValue;
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
                    _pitch = newValue;
                    print(_pitch);
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
            )
     ] ),
     // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
