import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

var box = Hive.box('tsbeh_custom');
// 'count' key for the counter number
// 'Night' for night mode
// 'Vibrate'
// 'Sound'
// 'CardNumber'

class Tsbeh extends StatefulWidget {
  @override
  State<Tsbeh> createState() => _TsbehState();
}

class _TsbehState extends State<Tsbeh> with TickerProviderStateMixin {
  final player = AudioPlayer();
  void playSound() async {
    player.play(
      AssetSource('ff.wav'),
    );

    await player.seek(Duration(microseconds: 1));
    // Future.delayed(Duration(microseconds: 300), () {
    //   player.stop();
    // });
  }

  int counter = 0;
  int oldTotalNumber = 0;
  int newTotalNumber = 0;
  bool night = false;
  bool sound = true;
  bool vibrate = true;
  int cardNumber = 1;

  List<Color> list = [];
  List<Color> listOfLight = [
    Color(0xfff0f0f0),
    Color(0xFF76d668),
    Colors.black,
    Color(0xFF76d668),
    Colors.white,
    Color(0xFF76d668),
    Color(0xffd6d4d1),
    Colors.black,
    Color(0xFF76d668),
    Colors.green
  ];
  List<Color> listOfNight = [
    Color(0xff141517),
    Color(0xff37225a),
    Color(0xffa4a4a4),
    Colors.white,
    Color(0xff383838),
    Color(0xff37225a),
    Colors.grey.shade600,
    Colors.white,
    Color(0xff37225a),
    Colors.purple,
  ];
  // 0 scaffoled color
  // 1 appbar & resetButton
  // 2 circle text;
  // 3 circle number;
  // 4 circle background;
  // 5  progressColor
  // 6 progressBackgroundColor
  // 7 totalNumber:
  // 8 linarColorOne
  // 9 linarColorTwo
  double num = 0;
  late Animation<double> animation;
  late AnimationController controller;

  void getNightMode() {
    var n = box.get('Night');
    if (n != null) {
      if (n == 0) {
        night = false;
        setState(() {
          list = listOfLight;
        });
      } else {
        night = true;
        setState(() {
          list = listOfNight;
        });
      }
    } else {
      night = false;
      setState(() {
        list = listOfLight;
      });
      box.put('Night', 0);
    }
  }

  void getCardNumber() {
    var n = box.get('CardNumber');
    if (n != null) {
      setState(() {
        cardNumber = n;
      });
    } else {
      cardNumber = 1;
      box.put('CardNumber', 1);
    }
  }

  void getSound() {
    var n = box.get('Sound');
    if (n != null) {
      if (n == 1) {
        setState(() {
          sound = true;
        });
      } else {
        setState(() {
          sound = false;
        });
      }
    } else {
      sound = true;

      box.put('Sound', 1);
    }
  }

  void getVibrate() {
    var n = box.get('Vibrate');
    if (n != null) {
      if (n == 1) {
        setState(() {
          vibrate = true;
        });
      } else {
        setState(() {
          vibrate = false;
        });
      }
    } else {
      vibrate = true;

      box.put('Vibrate', 1);
    }
  }

  void setNightMode() {
    if (night) {
      box.put('Night', 1);
    } else {
      box.put('Night', 0);
    }
  }

  void setCardNumber() {
    box.put('CardNumber', cardNumber);
  }

  void setSound() {
    if (sound) {
      box.put('Sound', 1);
    } else {
      box.put('Sound', 0);
    }
  }

  void setVibrate() {
    if (vibrate) {
      box.put('Vibrate', 1);
    } else {
      box.put('Vibrate', 0);
    }
  }

  void getData() async {
    getNightMode();
    var t = await box.get('count');

    if (t != null) {
      setState(() {
        oldTotalNumber = t;
      });
    } else {
      setState(() {
        oldTotalNumber = 0;
      });

      box.put('count', 0);
    }
    setState(() {
      newTotalNumber = newTotalNumber + oldTotalNumber;
    });

    getCardNumber();
    getSound();
    getVibrate();
  }

  void setData() {
    late int n;
    if (night) {
      n = 1;
    } else {
      n = 0;
    }
    box.put('count', newTotalNumber);
    setNightMode();
    setCardNumber();
    setSound();
    setVibrate();
  }

  Widget getCard(int whichWidget) {
    late Widget w;
    if (whichWidget == 1) {
      w = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Vibration.vibrate(duration: 300);
                  setState(() {
                    counter = 0;
                    num = 0;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: list[1]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 75,
          ),
          CircularPercentIndicator(
            animateFromLastPercent: true,
            animation: true,
            radius: 175,
            lineWidth: 8,
            percent: num,
            center: GestureDetector(
              onTap: () {
                animate();
                sound ? playSound() : null;
                vibrate ? Vibration.vibrate(duration: 200) : null;
                setState(() {
                  newTotalNumber++;
                  counter++;
                  if (num >= 0.95) {
                    num = 0;
                  } else {
                    num = num + 1.0 / 33.0;
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: animation.value,
                width: animation.value,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                    color: list[4]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'التكرار',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: list[2]),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '$counter',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: list[3],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: list[6],
            progressColor: list[5],
          ),
          SizedBox(
            height: 75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$newTotalNumber',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: list[7]),
              ),
              Text(
                '   مجموع التسبيحات',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          )
        ],
      );
    } else {
      w = Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              alignment: Alignment.center,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: list[0],
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Text(
                '$counter',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: list[7],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Vibration.vibrate(duration: 300);
                  setState(() {
                    counter = 0;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: list[1]),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              animate();
              sound ? playSound() : null;
              vibrate ? Vibration.vibrate(duration: 200) : null;
              setState(() {
                newTotalNumber++;
                counter++;
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: animation.value + 80,
                  width: animation.value + 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: <Color>[list[8], list[9]],
                    ),
                  ),
                ),
                Positioned(
                  top: 450,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$newTotalNumber',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: list[7]),
                      ),
                      Text(
                        '   مجموع التسبيحات',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
    return w;
  }

  @override
  void initState() {
    getData();
    controller =
        AnimationController(duration: const Duration(seconds: 0), vsync: this);
    animation = Tween<double>(begin: 300, end: 300).animate(controller);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void animate() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 275, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          animation.value;
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      cardNumber;
      setData();
    });
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: list[0],
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 25.0,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  'تسبيح',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 100,
              ),
              IconButton(
                icon: Icon(
                  vibrate ? Icons.vibration : Icons.videogame_asset_off,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    vibrate = !vibrate;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  sound ? Icons.volume_up_outlined : Icons.volume_off_outlined,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    sound = !sound;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.change_circle_outlined,
                  size: 25.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (cardNumber == 1) {
                      cardNumber = 2;
                    } else {
                      cardNumber = 1;
                    }
                  });
                },
              ),
              IconButton(
                icon: FaIcon(
                  night ? FontAwesomeIcons.solidSun : FontAwesomeIcons.moon,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    night = !night;
                    night ? list = listOfNight : list = listOfLight;
                  });
                },
              ),
            ],
            backgroundColor: list[1],
          ),
          body: getCard(cardNumber),
        ),
      ),
    );
  }
}
