import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

Box box = Hive.box('askar_custom');
Box box1 = Hive.box('addAskarPage1');
Box box2 = Hive.box('askarPage1');

class MyData extends ChangeNotifier {
  List<String> allAskar = [];
  void setAllAskar() {
    allAskar.clear();
    Map map1 = box1.toMap();
    for (final map1Entry in map1.entries) {
      var value = map1Entry.value;
      allAskar.add(value);
    }
    Map map2 = box2.toMap();
    for (final map2Entry in map2.entries) {
      var key = map2Entry.key;
      allAskar.add(key);
    }
    notifyListeners();
  }

  double sizeOfText = 20;
  var mode = box.get('mode') ?? '01';
  var nConst = box.get('nConst') ?? '01';
  int addedNumber = 0;
  void AddedNumber() {
    addedNumber++;
    notifyListeners();
  }

  void clearAddedNumber() {
    addedNumber = 0;
    notifyListeners();
  }

  // void setAskarAndKeys() async {
  //   ListOfAskar = await box.get('morningAskar12');
  //   ListOfKeys = await box.get('repeting12');
  //   notifyListeners();
  //   print('################################################');
  //
  //   print(ListOfKeys);
  //   print(ListOfAskar);
  // }

  // Future<void> addToIndexDataBase(int index, String text, int repet) async {
  //   ListOfAskar[index] = text;
  //   ListOfKeys[index] = repet;
  //   await box.put('morningAskar', ListOfAskar);
  //   await box.put('repeting', ListOfKeys);
  //   await setDataBaseMorning();
  //   notifyListeners();
  // }
  //
  // Future<void> addToEndDataBase(String text, int repet) async {
  //   ListOfAskar.add(text);
  //   ListOfKeys.add(repet);
  //   notifyListeners();
  //   await box.put('morningAskar', ListOfAskar);
  //   await box.put('repeting', ListOfKeys);
  //   await setDataBaseMorning();
  //   notifyListeners();
  // }
  bool edite = false;
  bool dlete = false;
  bool red = false;

  void changeRed(bool x) {
    red = x;
    notifyListeners();
  }

  void end() {
    mDleteF();
    changeRed(false);
    mEditeF();
    notifyListeners();
  }

  Color scaffoledColor = Color(0xffFFFFF4);
  Color appBarColor = Color(0xff7aa7d8);
  Color bellowAppBarColor = Color(0xffececec);
  Color bellowAppBarIconColor = Colors.grey;
  Color bellowAppBar_NightIcon_Color = Colors.grey;

  Color horizontalLineColor = Colors.black12;
  Color menuItemBackground = Colors.white;

  Color _NscaffoledColor = Color(0xff010101);
  Color _NappBarColor = Color(0xff503385);
  Color _NbellowAppBarColor = Color(0xff010101);
  Color _NbellowAppBarIconColor = Color(0xffc1c1c1);
  Color _NbellowAppBar_NightIcon_Color = Color(0xffdbd8af);

  //####################### Style one ##################################
  List<Color> colorsN = [
    Color(0xff503385),
    Color(0xff010101),
    Color(0xffc1c1c1),
    Color(0xffdbd8af),
    Colors.white,
    Color(0xff141517),
    Color(0xff212121),
    Color(0xffc1c1c1),
    Colors.white,
    Color(0xffc1c1c1)
  ];
  List<Color> colors01 = [
    Color(0xff7aa7d8),
    Color(0xffececec),
    Colors.grey,
    Colors.grey,
    Colors.black,
    Colors.white,
    Color(0xff7aa7d8),
    Colors.yellow,
    Colors.white70,
    Colors.white
  ];
  List<Color> colors03 = [
    Color(0xff7aa7d8),
    Color(0xffececec),
    Colors.grey,
    Colors.grey,
    Colors.black,
    Colors.white,
    Color(0xFF76d668),
    Colors.white,
    Colors.white,
    Colors.white
  ];
// c0=appBarColor
// c1=bellowAppBarColor
// c2=bellowAppBarIconColor
// c3=bellowAppBar_NightIcon_Color
// c4=cardTextColor
// c5=cardContainerColor
// c6=cardPositionColor
// c7=cardPositionIcon
// c8=cardPositionLine
// c9=cardPositionTextColor
//######################## Style two #################################

  List<Color> colors02 = [
    Color(0xFF8baccd),
    Color(0xfffef7e5),
    Colors.brown,
    Colors.black54,
    Colors.white,
    Colors.white
  ];
  List<Color> colors04 = [
    Color(0xFF76d668),
    Colors.white,
    Colors.black45,
    Colors.black54,
    Colors.white,
    Colors.white
  ];
// c0  bigContainer and bottonContainer and iconColor
// c1   container of text fill
// c2 shadow of textContainer
// c3 text of container
// c4 Icon Cirecl fill color
// c5  text in icons container
//#########################################################
//   Future<void> getMode() async {
//     var m = await box.get('mode');
//     var n = await box.get('nConst');
//     if (m == null || n == null) {
//       await box.put('mode', '01');
//       await box.put('nConst', '01');
//       mode = '01';
//       nConst = '01';
//       notifyListeners();
//     } else {
//       mode = m;
//       nConst = n;
//       notifyListeners();
//     }
//   }

  // Future<void> setMode() async {
  //   await box.put('mode', mode);
  //   await box.put('nConst', nConst);
  // }

  void mEditeT() {
    edite = true;
    notifyListeners();
  }

  void mEditeF() {
    edite = false;
    notifyListeners();
  }

  void mDleteT() {
    dlete = true;
    notifyListeners();
  }

  void mDleteF() {
    dlete = false;
    notifyListeners();
  }

  void setBackground() async {
    if (mode == '01' || mode == '02') {
      scaffoledColor = Color(0xffFFFFF4);
      appBarColor = Color(0xff7aa7d8);
      bellowAppBarColor = Color(0xffececec);
      bellowAppBarIconColor = Colors.grey;
      bellowAppBar_NightIcon_Color = Colors.grey;

      horizontalLineColor = Colors.black12;
      menuItemBackground = Colors.white;
    } else if (mode == '03' || mode == '04') {
      scaffoledColor = Color(0xffFFFFF4);
      appBarColor = Color(0xfffebd3d);
      bellowAppBarColor = Color(0xffececec);
      bellowAppBarIconColor = Colors.grey;
      bellowAppBar_NightIcon_Color = Colors.grey;

      horizontalLineColor = Colors.black12;
      menuItemBackground = Colors.white;
    } else if (mode == 'N') {
      scaffoledColor = _NscaffoledColor;
      appBarColor = _NappBarColor;
      bellowAppBarColor = _NbellowAppBarColor;
      bellowAppBarIconColor = _NbellowAppBarIconColor;
      bellowAppBar_NightIcon_Color = _NbellowAppBar_NightIcon_Color;

      horizontalLineColor = Colors.grey;
      menuItemBackground = Color(0xff141517);
    }
  }

  void changeNight() async {
    if (mode != 'N') {
      nConst = mode;
      mode = 'N';
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    } else {
      mode = nConst;
      notifyListeners();
      box.put('mode', mode);
    }

    setBackground();
    notifyListeners();
  }

  void changeMode() async {
    if (mode == '01') {
      mode = '02';
      nConst = mode;
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    } else if (mode == '02') {
      mode = '03';
      nConst = mode;
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    } else if (mode == '03') {
      mode = '04';
      nConst = mode;
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    } else if (mode == '04') {
      mode = '01';
      nConst = mode;
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    } else if (mode == 'N') {
      mode = nConst;
      nConst = mode;
      notifyListeners();
      box.put('nConst', nConst);
      box.put('mode', mode);
    }

    setBackground();
    notifyListeners();
  }

  void setSizeOfText() async {
    var x = box.get('size');
    if (x != null) {
      sizeOfText = double.parse(await box.get('size'));
      notifyListeners();
    } else {
      box.put('size', '20');
      sizeOfText = double.parse(await box.get('size'));
      notifyListeners();
    }
  }

  void increaseSize() async {
    double size = double.parse(await box.get('size'));
    size = size + 1;
    if (size >= 15 && size <= 40) {
      box.put('size', size.toString());
      sizeOfText = size;
      notifyListeners();
    }
  }

  void decreaseSize() async {
    double size = double.parse(await box.get('size'));

    size = size - 1;
    if (size >= 15 && size <= 40) {
      box.put('size', size.toString());
      sizeOfText = size;
      notifyListeners();
    }
  }
}
