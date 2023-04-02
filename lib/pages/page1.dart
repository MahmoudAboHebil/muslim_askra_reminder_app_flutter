import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_local_notification1/component.dart';
import 'bodyOfaskary_1_Page1.dart';
import 'bodyOfaskar_2_Page1.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// var box = Hive.box('addAskarPage1');

class Page1 extends StatefulWidget {
  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  int num = 0;
  bool _visible = true;
  bool validate = true;
  String inputTextFiled = '';
  bool pressed = false;
  void setData() async {
    // Map map = box.toMap();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('addAskarPage1');
    values.clear();
    if (list != null) {
      setState(() {
        values = list;
      });
    }
    // for (final mapEntry in list) {
    //   var key = mapEntry.key;
    //   var value = mapEntry.value;
    //   values.add(value);
    // }
  }

  late PageController _pageViewController;
  Duration _kDuration = Duration(milliseconds: 300);
  Curve _kCurve = Curves.ease;
  final _controllerTextFiled = TextEditingController();

  String? get _errorText {
    var text = _controllerTextFiled.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  Future<void> Anew_sumbit() async {
    String text = _controllerTextFiled.text;
    pressed = true;
    if (text.isNotEmpty && text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF76d668),
          content: Text(
            textAlign: TextAlign.end,
            'تم بنجاح ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        // box.add(text);
        values.add(text);
        prefs.setStringList('addAskarPage1', values);
        setData();
        values;
        Navigator.of(context).pop(text);
        _controllerTextFiled.clear();
        pressed = false;
      });
      // print('###########################Add############################');
      // print(box.toMap());
    }
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: Container(
              height: 390,
              width: 400,
              decoration: BoxDecoration(
                color: Color(0xFF76d668),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'إضافه أذكار / أدعيه خاصة',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'النص ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextField(
                              controller: _controllerTextFiled,
                              autofocus: true,
                              textAlign: TextAlign.end,
                              onSubmitted: (_) {
                                // Anew_sumbit();
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                errorText: _errorText,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 4),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  gapPadding: 0.0,
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1),
                                ),
                              ),
                              maxLines: 5,
                              minLines: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkResponse(
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 2,
                                              color: Colors.grey),
                                        ],
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          'رجوع',
                                          15,
                                          Colors.grey,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // pressed = false;
                                      Navigator.of(context).pop();
                                      _controllerTextFiled.clear();
                                      pressed = false;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: TextButton(
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF76d668),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          'حفظ',
                                          15,
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        Anew_sumbit();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        setData();
        values;
      });
    }
    _pageViewController = PageController();
    setData();
  }

  @override
  void dispose() {
    _controllerTextFiled.dispose();
    // brain.localData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffececec),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (num == 1) {
                        _pageViewController.previousPage(
                            duration: _kDuration, curve: _kCurve);
                      }
                      num = 0;
                    });
                  },
                  child: miniCardPage1(
                    'أذكارى ',
                    num == 0 ? Colors.white : Color(0xff9b9b9b),
                    num == 0 ? Color(0xFF76d668) : Color(0xFFdbdbdb),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (num == 0) {
                        _pageViewController.nextPage(
                            duration: _kDuration, curve: _kCurve);
                      }
                      num = 1;
                    });
                  },
                  child: miniCardPage1(
                    'أذكار التطبيق ',
                    num == 1 ? Colors.white : Color(0xff9b9b9b),
                    num == 1 ? Color(0xFF76d668) : Color(0xFFdbdbdb),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageViewController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (page) {
                setState(() {
                  if (page == 1) {
                    num = 1;
                  } else {
                    num = 0;
                  }
                });
              },
              children: <Widget>[
                Column(
                  children: [
                    belowButtonsPage1(
                        ' !بإمكانك اضافه ادعيه خاصه بك لتظهر على الشاشة '),
                    Expanded(
                      child: NotificationListener<UserScrollNotification>(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [BodyOfaskary_1_Page1()],
                          ),
                        ),
                        onNotification: (notification) {
                          ScrollDirection direction = notification.direction;
                          setState(() {
                            if (direction == ScrollDirection.reverse) {
                              _visible = false;
                            } else if (direction == ScrollDirection.forward) {
                              _visible = true;
                            }
                          });
                          return true;
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    belowButtonsPage1('إختر الأذكار التى ستظهر على الشاشة'),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BodyOfaskar_2_Page1(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: num == 0
          ? Visibility(
              visible: _visible,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF76d668),
                onPressed: () async {
                  await openDialog();
                  setState(() {
                    // if (input == null || input.isEmpty) {
                    //   inputTextFiled = 'null';
                    //   print(inputTextFiled);
                    //   return;
                    // } else {
                    //   inputTextFiled = input;
                    //   print(inputTextFiled);
                    // }

                    // pressed = false;
                  });
                  // print(
                  //     '#######################################################');
                  // print(await brain.removeAllDatalLocal());
                  // brain.localData();
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}

class belowButtonsPage1 extends StatelessWidget {
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: Color(0xff9b9b9b),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  belowButtonsPage1(this.text);
}

class AppBar1Page extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
    );
  }
}
