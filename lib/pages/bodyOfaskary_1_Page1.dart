import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_local_notification1/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> values = [];
// var box = Hive.box('addAskarPage1');

class BodyOfaskary_1_Page1 extends StatefulWidget {
  @override
  State<BodyOfaskary_1_Page1> createState() => _BodyOfaskary_1_Page1State();
}

class _BodyOfaskary_1_Page1State extends State<BodyOfaskary_1_Page1> {
  bool dootCheck = false;
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

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        setData();
        values;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        height: 650,
        child: StatefulBuilder(
          builder: (context, setState) {
            setState(() {
              values;
            });
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RecatangleBodyOfAskary_1_Page1(values[index], () {
                  setState(() {
                    values;
                  });
                });
              },
              itemCount: values.length,
            );
          },
        ),
      ),
    );
  }
}

class RecatangleBodyOfAskary_1_Page1 extends StatefulWidget {
  final String title;
  final Function f;

  const RecatangleBodyOfAskary_1_Page1(this.title, this.f);
  @override
  State<RecatangleBodyOfAskary_1_Page1> createState() =>
      _RecatangleBodyOfAskary_1_Page1State();
}

class _RecatangleBodyOfAskary_1_Page1State
    extends State<RecatangleBodyOfAskary_1_Page1> {
  late var _controllerTextFiled2;
  bool dootCheck = false;
  bool pressed2 = false;
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

  String? get _errorText2 {
    final text = _controllerTextFiled2.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed2) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  @override
  void initState() {
    _controllerTextFiled2 = TextEditingController(text: widget.title);

    super.initState();
  }

  Future<bool> Aedit_sumbit(String value) async {
    String text = _controllerTextFiled2.text;
    pressed2 = true;
    bool flag = false;
    if (text.isNotEmpty && text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
      var index = values.indexOf(value);
      values[index] = text;
      await prefs.setStringList('addAskarPage1', values);

      setState(() {
        values[index] = text;
        setData();
        widget.f();
        Navigator.of(context).pop(text);
        _controllerTextFiled2.clear();
        pressed2 = false;
      });

      // var key = box
      //     .toMap()
      //     .keys
      //     .firstWhere((k) => box.toMap()[k] == value, orElse: () => 'null');
      // if (key == 'null') {
      //   print('there isnt key in update func');
      // } else {
      //   setState(() {
      //     box.put(key, text);
      //     setData();
      //     widget.f();
      //     Navigator.of(context).pop(text);
      //     _controllerTextFiled2.clear();
      //     pressed2 = false;
      //   });
      // }
      // print('########################### update ############################');
      // print(box.toMap());
    }
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFFc1c1c1),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints:
                BoxConstraints(minHeight: 80, minWidth: double.infinity),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          right: (widget.title.length <= 100) ? 0 : 15,
                          left: 10,
                          bottom: 10),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Color(0xFF76d668),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (dootCheck == true) {
                          dootCheck = false;
                        } else {
                          dootCheck = true;
                        }
                      });
                      // title;
                      //
                      //  print(title.length);
                    },
                  ),
                ),
                widget.title.length > 100
                    ? Container()
                    : Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            size: 25.0,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (dootCheck == true) {
                                dootCheck = false;
                              } else {
                                dootCheck = true;
                              }
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
          dootCheck
              ? Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                  alignment: Alignment.bottomCenter,
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFc1c1c1),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      miniRow('مشاركه', 'images/icons8-connect-96.png'),
                      GestureDetector(
                        child: miniRow('حذف', 'images/icons8-delete-96.png'),
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (context) => AlertDialog(
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
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'حذف ذكر / دعاء',
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20),
                                                child: Center(
                                                  child: Text(
                                                    'هل ترغب فى حذف هذا الذكر أو الدعاء؟ ',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey[800],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TextField(
                                                controller:
                                                    TextEditingController()
                                                      ..text = widget.title,
                                                autofocus: false,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                                enableInteractiveSelection:
                                                    false,
                                                enabled: false,
                                                textAlign: TextAlign.end,
                                                onSubmitted: (_) {
                                                  setState(() {});
                                                },
                                                onChanged: (text) {
                                                  setState(() {});
                                                },
                                                decoration: InputDecoration(
                                                  // errorText: _errorText2,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 4,
                                                          horizontal: 4),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    gapPadding: 0.0,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1),
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
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        margin: EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                10.0),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 2,
                                                                color: Colors
                                                                    .grey),
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
                                                        Navigator.of(context)
                                                            .pop();
                                                        _controllerTextFiled2
                                                            .clear();
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  Expanded(
                                                    child: TextButton(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        margin: EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF76d668),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                10.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: CustomText(
                                                            'حذف',
                                                            15,
                                                            Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF76d668),
                                                            content: Text(
                                                              'تم بنجاح',
                                                              textAlign:
                                                                  TextAlign.end,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        );

                                                        final SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        var index =
                                                            values.indexOf(
                                                                widget.title);
                                                        values.removeAt(index);
                                                        await prefs
                                                            .setStringList(
                                                                'addAskarPage1',
                                                                values);
                                                        setState(() {
                                                          setData();
                                                          widget.f();
                                                          Navigator.of(context)
                                                              .pop();
                                                          _controllerTextFiled2
                                                              .clear();
                                                        });
                                                        // var key = box
                                                        //     .toMap()
                                                        //     .keys
                                                        //     .firstWhere(
                                                        //         (k) =>
                                                        //             box.toMap()[
                                                        //                 k] ==
                                                        //             widget
                                                        //                 .title,
                                                        //         orElse: () =>
                                                        //             'null');
                                                        // if (key == 'null') {
                                                        //   print(
                                                        //       'there isnt key in update func');
                                                        // } else {
                                                        //   setState(() {
                                                        //     box.delete(key);
                                                        //     setData();
                                                        //     widget.f();
                                                        //     Navigator.of(
                                                        //             context)
                                                        //         .pop();
                                                        //     _controllerTextFiled2
                                                        //         .clear();
                                                        //   });
                                                        // }

                                                        // print(
                                                        //     '########################### delete ############################');
                                                        // print(box.toMap());

                                                        // Aedit_sumbit();
                                                        // brain.localData();
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
                          );
                        },
                      ),
                      GestureDetector(
                        child: miniRow(
                            'تعديل',
                            'images/ic'
                                'ons8-map-editing-90.png'),
                        onTap: () {
                          _controllerTextFiled2 =
                              TextEditingController(text: widget.title);
                          showDialog<String>(
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
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'تعديل ذكر / دعاء',
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
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 20),
                                                  child: Text(
                                                    'النص ',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey[800],
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                TextField(
                                                  controller:
                                                      _controllerTextFiled2,
                                                  autofocus: true,
                                                  textAlign: TextAlign.end,
                                                  onSubmitted: (_) {},
                                                  onChanged: (text) {
                                                    setState(() {});
                                                  },
                                                  decoration: InputDecoration(
                                                    errorText: _errorText2,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 4,
                                                            horizontal: 4),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      gapPadding: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 1),
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
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  bottom: 20),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10.0),
                                                            ),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  blurRadius: 2,
                                                                  color: Colors
                                                                      .grey),
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          _controllerTextFiled2
                                                              .clear();
                                                          pressed2 = false;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 30,
                                                    ),
                                                    Expanded(
                                                      child: TextButton(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  bottom: 20),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF76d668),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10.0),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: CustomText(
                                                              'تعديل',
                                                              15,
                                                              Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            Aedit_sumbit(
                                                                widget.title);
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
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
