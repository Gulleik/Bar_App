import 'package:flutter/material.dart';
import 'package:winwheel/winwheel.dart';
import 'dart:math' as math;


void main() => runApp(BarApp());

class BarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: MyHomePage(title: 'Where to get drunk?'),
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

  static WinwheelController ctrl;
  bool isPlaying = false;
  List colors = [
    Colors.pink,
    Colors.purple,
    Colors.amber,
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.deepPurple,
    Colors.indigo,
    Colors.lightBlue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            //TODO ligg på et bilde av en pil eller noe som viser hvilket segment som har vunnet
              child: Container(
                child: Center(
                  child: Winwheel(
                    handleCallback: ((handler) {
                      ctrl = handler;
                    }),
                    controller: ctrl,
                    outerRadius: 150,
                    innerRadius: 15,
                    strokeStyle: Colors.white,
                    textFontSize: 16,
                    textFillStyle: Colors.red,
                    textFontWeight: FontWeight.bold,
                    textAlignment: WinwheelTextAlignment.center,
                    textOrientation: WinwheelTextOrientation.horizontal,
                    wheelImage: 'assets/planes.png',
                    drawMode: WinwheelDrawMode.code,
                    drawText: true,
                    imageOverlay: false,
                    textMargin: 0,
                    pointerAngle: 0,
                    pointerGuide: PointerGuide(
                      display: true,
                    ),
                    segments: <Segment>[
                      //TODO definer en dynamisk liste som vi kan appende til når vi ligger til nye barer
                      Segment(
                        fillStyle: Colors.red,
                        textFillStyle: Colors.white,
                        text: 'Text'
                      ),
                      Segment(
                        fillStyle: Colors.blue,
                        textFillStyle: Colors.white,
                        text: 'More text'
                      ),
                    ],
                    animation: WinwheelAnimation(
                      type: WinwheelAnimationType.spinToStop,
                      spins: 4,
                      duration: const Duration(
                        seconds: 10,
                      ),
                     callbackFinished: (int segment) {
                        setState(() {
                          isPlaying = false;
                        });
                        print('Animation finished');
                        print(segment);
                        //TODO Vis frem vinneren på en fin måte. Oppgi link til info på google??
                     },
                     callbackBefore: (){
                        setState(() {
                          isPlaying = true;
                        });
                     },

                    ),
                  ),
                ),
              )
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: <Widget>[
                  IconButton(
                    iconSize: 62,
                    color: Colors.lightBlueAccent,
                    icon: Icon(
                      isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline
                    ),
                    onPressed: (){
                      if (isPlaying){
                        ctrl.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      }
                      else{
                        ctrl.play();
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        //TODO Bytt flatbutton med en input text boks sånn at vi kan ligge til uteplasser selv
                          onPressed: (){
                            math.Random random = new math.Random();
                            ctrl.addSegment(Segment(fillStyle: colors[random.nextInt(colors.length)]));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.add),
                              SizedBox(
                                width: 4,
                              ),
                              Text('Add bar')
                            ],
                          ),
                      ),
                      FlatButton(
                        onPressed: (){
                          //TODO kunne bestemme hvilket segment som skal fjernes
                          ctrl.deleteSegment();
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Remove bar')
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
