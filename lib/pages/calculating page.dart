import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

var box = Hive.box('total_number_uget');
var box_mode = Hive.box('askar_custom');

class calcPage extends StatefulWidget {
  int added_number;
  String askarType;

  calcPage(this.added_number, this.askarType);

  @override
  State<calcPage> createState() => _calcPageState();
}

class _calcPageState extends State<calcPage> with TickerProviderStateMixin {
  List<Color> list = [
    Color(0xffececec),
    Color(0xff8baccd),
    Colors.yellow,
    Color(0xffd8d8d8),
    Colors.white,
    Color(0xffd8d8d8),
    Colors.blue.shade800,
    Colors.white,
    Color(0xff8baccd),
    Colors.white
  ];
  //[0] backgroundScaffoledColor
  //[1] backgroundStackContainer
  //[2] stackContainerText(حاسبه الاذكار)
  //[3] cardBgContainerColor
  //[4] cardNumberColor
  //[5] cardNumberBGColor
  //[6] cardTitleColor
  //[7] cardTitleBGColor
  //[8] arrowBgColor
  //[9] arrowColor

  late Animation<int> animation;
  late AnimationController controller;
  int addedNumber = 0;
  int oldTotalNumber = 0;
  int newTotalNumber = 0;
  double opacity = 0.0;
  double buttonOpacity = 1.0;
  late IconData icon;
  void setTotalNumberData() async {
    setState(() {
      addedNumber = widget.added_number;
    });
    var n = await box.get('num');
    if (n != null) {
      setState(() {
        oldTotalNumber = n;
      });
    } else {
      setState(() {
        oldTotalNumber = 0;
      });
    }
    int t = addedNumber + oldTotalNumber;
    setState(() {
      newTotalNumber = t;
    });
    await box.put('num', t);
  }

  void changeOpacity() {
    setState(() {
      if (buttonOpacity == 0.0) {
        buttonOpacity = 1.0;
      } else {
        buttonOpacity = 0.0;
      }
      Future.delayed(Duration(milliseconds: 900), () {
        setState(() {
          buttonOpacity = 1.0;
        });
      });
    });
  }

  void setColors() async {
    String mode = await box_mode.get('mode') ?? '01';

    if (mode == '01' || mode == '02') {
      setState(() {
        list = [
          Color(0xffececec),
          Color(0xff8baccd),
          Colors.yellow,
          Color(0xffd8d8d8),
          Colors.white,
          Color(0xffd8d8d8),
          Colors.blue.shade800,
          Colors.white,
          Color(0xff8baccd),
          Colors.white
        ];
      });
    } else if (mode == '03' || mode == '04') {
      setState(() {
        list = [
          Color(0xffececec),
          Color(0xfffebd3d),
          Colors.yellow,
          Color(0xffd8d8d8),
          Colors.white,
          Color(0xffd8d8d8),
          Color(0xFF76d668),
          Colors.white,
          Color(0xFF76d668),
          Colors.white,
        ];
      });
      //[0] backgroundScaffoledColor
      //[1] backgroundStackContainer
      //[2] stackContainerText(حاسبه الاذكار)
      //[3] cardBgContainerColor
      //[4] cardNumberColor
      //[5] cardNumberBGColor
      //[6] cardTitleColor
      //[7] cardTitleBGColor
      //[8] arrowBgColor
      //[9] arrowColor
    } else if (mode == 'N') {
      setState(() {
        list = [
          Color(0xff010101),
          Color(0xff503385),
          Colors.white,
          Color(0xff212121),
          Colors.white,
          Color(0xff212121),
          Color(0xffececec),
          Color(0xff141517),
          Color(0xff503385),
          Colors.white,
        ];
      });
    }
  }

  @override
  void initState() {
    if (widget.askarType == 'أذكارالصباح ') {
      icon = FontAwesomeIcons.cloudSunRain;
    } else if (widget.askarType == 'أذكارالمساء ') {
      icon = FontAwesomeIcons.cloudMoonRain;
    } else if (widget.askarType == 'أذكارالمسجد ') {
      icon = FontAwesomeIcons.mosque;
    } else if (widget.askarType == 'أذكارالإستيقاظ ') {
      icon = FontAwesomeIcons.sun;
    } else if (widget.askarType == 'أذكارالنوم ') {
      icon = FontAwesomeIcons.bed;
    } else {
      icon = FontAwesomeIcons.personPraying;
    }
    setColors();
    setTotalNumberData();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });

    controller =
        AnimationController(duration: const Duration(seconds: 0), vsync: this);
    animation = IntTween(begin: 0, end: 0).animate(controller);
    Future.delayed(Duration(milliseconds: 300), () {
      controller = AnimationController(
          duration: const Duration(seconds: 2), vsync: this);
      animation = IntTween(begin: oldTotalNumber, end: newTotalNumber)
          .animate(controller)
        ..addListener(() {
          setState(() {
            animation.value;
            oldTotalNumber;
            newTotalNumber;
          });
        });
      controller.forward();
    });

    // print('####################################');
    // print(newTotalNumber);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        changeOpacity();
        return false;
      },
      child: Container(
        color: Colors.grey,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: list[0],
            body: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 275,
                  color: list[1],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget.askarType,
                              style: TextStyle(
                                  fontSize: 17, color: Color(0xffececec)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: FaIcon(
                                icon,
                                size: 20,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'حاسبة الأذكار',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: list[2],
                            ),
                          ),
                          Text(
                            'حاسبة الأذكار',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color(0xffececec),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: opacity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 240,
                      ),
                      CalcCard(
                          addedNumber,
                          '${addedNumber} +',
                          list[3],
                          list[4],
                          list[5],
                          'الأذكار المضافة',
                          list[6],
                          list[7]),
                      SizedBox(
                        height: 40,
                      ),
                      CalcCard(
                          animation.value,
                          '${animation.value} ',
                          list[3],
                          list[4],
                          list[5],
                          '  مجموع الأذكار التى قرأتها',
                          list[6],
                          list[7]),
                      SizedBox(
                        height: 150,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: AbsorbPointer(
                          child: AnimatedOpacity(
                            duration: Duration(seconds: 1),
                            opacity: buttonOpacity,
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: list[8],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  )),
                              child: Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 40,
                                  color: list[9],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalcCard extends StatefulWidget {
  int number;
  String numberInString;
  Color bgContainerColor;
  Color numberColor;
  Color numberBGColor;
  String title;
  Color titleColor;
  Color titleBGColor;
  CalcCard(
      this.number,
      this.numberInString,
      this.bgContainerColor,
      this.numberColor,
      this.numberBGColor,
      this.title,
      this.titleColor,
      this.titleBGColor);

  @override
  State<CalcCard> createState() => _CalcCardState();
}

class _CalcCardState extends State<CalcCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 325,
      decoration: BoxDecoration(
          color: widget.bgContainerColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: widget.bgContainerColor == Color(0xff212121)
              ? []
              : [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2, spreadRadius: 0.1)
                ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 150,
            decoration: BoxDecoration(
              color: widget.numberBGColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              widget.numberInString,
              style: TextStyle(
                color: widget.numberColor,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.titleBGColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 1, spreadRadius: 0.1)
                  ]),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 17,
                  color: widget.titleColor,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
