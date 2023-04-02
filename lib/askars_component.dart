import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'providerAskarBrain.dart';
import 'pages/calculating page.dart';

class CardStyleOne1 extends StatefulWidget {
  Box boxtText;
  Box boxRepet;
  List<String> ListOfAskar;
  List<int> ListOfKeys;
  GlobalKey<AnimatedListState> _key;

  int repet;
  String text;
  Function f;
  Animation<double> animation;
  List<Color> C;

  CardStyleOne1(this.boxtText, this.boxRepet, this.ListOfAskar, this.ListOfKeys,
      this._key, this.repet, this.text, this.animation, this.f, this.C);

  @override
  State<CardStyleOne1> createState() => _CardStyleOne1State();
}

class _CardStyleOne1State extends State<CardStyleOne1> {
  late List<Color> c;
  int index = 0;
  String error = '';

  final _controllerTextFiled = TextEditingController();
  final _controllerTextFiled2 = TextEditingController();
  @override
  void initState() {
    _controllerTextFiled.text = widget.text;
    _controllerTextFiled2.text = widget.repet.toString();
    setState(() {
      index = widget.ListOfAskar.indexOf(widget.text);
    });
    Provider.of<MyData>(context, listen: false).setSizeOfText();
    c = widget.C;

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

    super.initState();
  }

  bool pressed = false;
  String? get _errorText {
    var text = _controllerTextFiled.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  String? get _errorText2 {
    var text = _controllerTextFiled2.text;
    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      error = 'برجاء أدخال رقم التكرار ';
      return '';
      // } else if ((text.isEmpty || text.trim().isEmpty)) {
      //   error = 'برجاء أدخال رقم التكرار ';
    } else if ((text == '0' ||
            text == '00' ||
            text == '000' ||
            text == '0000' ||
            text == '00000' ||
            text == '000000') &&
        pressed) {
      error = 'يجب ان لا يقل عدد التكرار عن واحد ';
      return '';
    }
    error = '';

    // return null if the text is valid
    return null;
  }

  void DleteAskar(String text, int repet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == text,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == repet,
        orElse: () => 'null');

    widget.boxtText.delete(keytext);
    widget.boxRepet.delete(keyRepet);
  }

  void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == oldtext,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == oldRepet,
        orElse: () => 'null');

    widget.boxtText.put(keytext, newText);
    widget.boxRepet.put(keyRepet, newRepet);
  }

  Future<void> Aedite_sumbit(int index) async {
    String text = _controllerTextFiled.text;
    String text2 = _controllerTextFiled2.text;
    pressed = true;
    var validate1 = _errorText;
    var validate2 = _errorText2;
    if (validate1 == null && validate2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color(0xFF76d668),
          content: Text(
            textAlign: TextAlign.end,
            'تم بنجاح ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
      setState(() {
        //############add in list3##############
        editAskar(widget.text, widget.repet, text, int.parse(text2));
        widget.ListOfKeys[index] = int.parse(text2);
        widget.ListOfAskar[index] = text;
        Navigator.of(context).pop(text);
        pressed = false;
      });
      widget.f();
      // print('###########################Add############################');
      // print(box.toMap());
    }
  }

  Future<String?> openDialogEdite(int index, String text, int key) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 470,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تعديل ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'النص ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    child: TextField(
                                      controller: _controllerTextFiled,
                                      autofocus: false,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color:
                                            Provider.of<MyData>(context).mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black,
                                      ),
                                      onSubmitted: (_) {},
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        errorText: _errorText,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 4),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                      ),
                                      maxLines: 5,
                                      minLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        error,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red[900]),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 75,
                                        height: 75,
                                        child: TextField(
                                          controller: _controllerTextFiled2,
                                          maxLength: 6,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Provider.of<MyData>(context)
                                                        .mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black54,
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          onSubmitted: (_) {},
                                          keyboardType: TextInputType.number,
                                          onChanged: (text) {
                                            setState(() {
                                              _errorText2;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            // labelText: 'التكرار',
                                            hintText: 'العدد',
                                            errorText: _errorText2,

                                            contentPadding: EdgeInsets.only(
                                                right: 3,
                                                left: 3,
                                                top: 10,
                                                bottom: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              gapPadding: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                          ),
                                          maxLines: 1,
                                          minLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 21,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          'التكرار ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[300]
                                                      : Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // pressed = false;
                                        Navigator.of(context).pop();
                                        pressed = false;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'تعديل ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Aedite_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  Future<void> Dlete_sumbit(int index) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color(0xFF76d668),
        content: Text(
          textAlign: TextAlign.end,
          'تم بنجاح ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
    setState(() {
      String text = widget.ListOfAskar.removeAt(index);
      int key = widget.ListOfKeys.removeAt(index);
      DleteAskar(widget.text, widget.repet);
      widget._key.currentState!.removeItem(index, (context, animation) {
        return SizeTransition(
          key: ValueKey(widget.text),
          sizeFactor: animation,
          child: CardStyleOne1(
              widget.boxtText,
              widget.boxRepet,
              widget.ListOfAskar,
              widget.ListOfKeys,
              widget._key,
              key,
              text,
              animation, () {
            setState(() {
              widget.ListOfAskar;
              widget.ListOfKeys;
            });
          }, widget.C),
        );
      }, duration: Duration(milliseconds: 450));

      widget.f();

      Navigator.of(context).pop(text);
      pressed = false;
    });
    widget.f();
    // print('###########################Add############################');
    // print(box.toMap());
  }

  Future<String?> openDialogDlete(int index, String text, int repet) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 225,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'حذف ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.trashCan,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      ' !سيتم حذف الذكر ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'حذف ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Dlete_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  void removeItem() {
    setState(() {
      Provider.of<MyData>(context, listen: false).AddedNumber();
      if (widget.repet == 0) {
        String text = widget.ListOfAskar.removeAt(index);

        int key = widget.ListOfKeys.removeAt(index);
        widget._key.currentState!.removeItem(index, (context, animation) {
          return SlideTransition(
            key: ValueKey(widget.text),
            position: animation.drive(Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset(0, 0),
            )),
            child: CardStyleOne1(
                widget.boxtText,
                widget.boxRepet,
                widget.ListOfAskar,
                widget.ListOfKeys,
                widget._key,
                key,
                text,
                animation, () {
              setState(() {
                widget.ListOfAskar;
                widget.ListOfKeys;
              });
            }, widget.C),
          );
        }, duration: Duration(milliseconds: 450));

        widget.f();
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   setTheSizeOfText();
    //   size;
    // });

    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              int value = 0;
              setState(() {
                if (!Provider.of<MyData>(context, listen: false).edite &&
                    !Provider.of<MyData>(context, listen: false).dlete) {
                  value = widget.repet--;
                  widget.ListOfKeys[index] = value - 1;
                  removeItem();
                } else if (Provider.of<MyData>(context, listen: false).edite) {
                  //###############edite Card ###################
                  openDialogEdite(index, widget.text, widget.repet);
                  Provider.of<MyData>(context, listen: false).mEditeF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                } else {
                  //############### dlete Card ###################
                  openDialogDlete(index, widget.text, widget.repet);

                  Provider.of<MyData>(context, listen: false).mDleteF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                }
              });
            },
            child: AbsorbPointer(
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 100, minWidth: double.infinity),
                margin: EdgeInsets.only(bottom: 60),
                decoration: BoxDecoration(
                  color: c[5],
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    color: Provider.of<MyData>(context).red
                        ? Colors.red
                        : Color(0xffFFFFF4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Provider.of<MyData>(context).red
                          ? Color(0xffFFFFF4)
                          : Colors.black87,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Provider.of<MyData>(context).sizeOfText,
                      color: c[4],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            width: 340,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: c[6],
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!Provider.of<MyData>(context, listen: false)
                                .edite &&
                            !Provider.of<MyData>(context, listen: false)
                                .dlete) {
                          // shared linkes  here
                        } else if (Provider.of<MyData>(context, listen: false)
                            .edite) {
                          //###############edite Card ###################
                          openDialogEdite(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mEditeF();
                        } else {
                          //############### dlete Card ###################
                          openDialogDlete(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mDleteF();
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 2, color: c[7])),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: c[7],
                                ),
                              ),
                            ),
                            Text(
                              'مشاركه ',
                              style: TextStyle(color: c[9], fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    endIndent: 10,
                    color: c[8],
                    indent: 10,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      int value = 0;
                      setState(() {
                        if (!Provider.of<MyData>(context, listen: false)
                                .edite &&
                            !Provider.of<MyData>(context, listen: false)
                                .dlete) {
                          value = widget.repet--;
                          widget.ListOfKeys[index] = value - 1;
                          removeItem();
                        } else if (Provider.of<MyData>(context, listen: false)
                            .edite) {
                          //###############edite Card ###################
                          openDialogEdite(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mEditeF();
                        } else {
                          //############### dlete Card ###################
                          openDialogDlete(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mDleteF();
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: Container(
                        margin: EdgeInsets.only(right: 30, left: 30),
                        child: Row(
                          children: [
                            Container(
                              width: 33.0,
                              height: 33.0,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: c[7],
                                      width: 2,
                                      style: BorderStyle.solid)),
                              child: new RawMaterialButton(
                                shape: new CircleBorder(),
                                elevation: 0.0,
                                child: Text(
                                  '${widget.repet}',
                                  style: TextStyle(fontSize: 15, color: c[7]),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              'التكرار ',
                              style: TextStyle(color: c[9], fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardStyleN1 extends StatefulWidget {
  Box boxtText;
  Box boxRepet;
  List<String> ListOfAskar;
  List<int> ListOfKeys;
  GlobalKey<AnimatedListState> _key;

  int repet;
  String text;
  Function f;
  Animation<double> animation;
  List<Color> C;

  CardStyleN1(this.boxtText, this.boxRepet, this.ListOfAskar, this.ListOfKeys,
      this._key, this.repet, this.text, this.animation, this.f, this.C);

  @override
  State<CardStyleN1> createState() => _CardStyleN1State();
}

class _CardStyleN1State extends State<CardStyleN1> {
  late List<Color> c;
  int index = 0;
  String error = '';

  final _controllerTextFiled = TextEditingController();
  final _controllerTextFiled2 = TextEditingController();
  @override
  void initState() {
    _controllerTextFiled.text = widget.text;
    _controllerTextFiled2.text = widget.repet.toString();
    setState(() {
      index = widget.ListOfAskar.indexOf(widget.text);
    });
    Provider.of<MyData>(context, listen: false).setSizeOfText();
    c = widget.C;

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

    super.initState();
  }

  bool pressed = false;
  String? get _errorText {
    var text = _controllerTextFiled.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  String? get _errorText2 {
    var text = _controllerTextFiled2.text;
    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      error = 'برجاء أدخال رقم التكرار ';
      return '';
      // } else if ((text.isEmpty || text.trim().isEmpty)) {
      //   error = 'برجاء أدخال رقم التكرار ';
    } else if ((text == '0' ||
            text == '00' ||
            text == '000' ||
            text == '0000' ||
            text == '00000' ||
            text == '000000') &&
        pressed) {
      error = 'يجب ان لا يقل عدد التكرار عن واحد ';
      return '';
    }
    error = '';

    // return null if the text is valid
    return null;
  }

  void DleteAskar(String text, int repet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == text,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == repet,
        orElse: () => 'null');

    widget.boxtText.delete(keytext);
    widget.boxRepet.delete(keyRepet);
  }

  void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == oldtext,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == oldRepet,
        orElse: () => 'null');

    widget.boxtText.put(keytext, newText);
    widget.boxRepet.put(keyRepet, newRepet);
  }

  Future<void> Aedite_sumbit(int index) async {
    String text = _controllerTextFiled.text;
    String text2 = _controllerTextFiled2.text;
    pressed = true;
    var validate1 = _errorText;
    var validate2 = _errorText2;
    if (validate1 == null && validate2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color(0xFF76d668),
          content: Text(
            textAlign: TextAlign.end,
            'تم بنجاح ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
      setState(() {
        //############add in list3##############
        editAskar(widget.text, widget.repet, text, int.parse(text2));
        widget.ListOfKeys[index] = int.parse(text2);
        widget.ListOfAskar[index] = text;
        Navigator.of(context).pop(text);
        pressed = false;
      });
      widget.f();
      // print('###########################Add############################');
      // print(box.toMap());
    }
  }

  Future<String?> openDialogEdite(int index, String text, int key) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 470,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تعديل ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'النص ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    child: TextField(
                                      controller: _controllerTextFiled,
                                      autofocus: false,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color:
                                            Provider.of<MyData>(context).mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black,
                                      ),
                                      onSubmitted: (_) {},
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        errorText: _errorText,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 4),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                      ),
                                      maxLines: 5,
                                      minLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        error,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red[900]),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 75,
                                        height: 75,
                                        child: TextField(
                                          controller: _controllerTextFiled2,
                                          maxLength: 6,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Provider.of<MyData>(context)
                                                        .mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black54,
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          onSubmitted: (_) {},
                                          keyboardType: TextInputType.number,
                                          onChanged: (text) {
                                            setState(() {
                                              _errorText2;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            // labelText: 'التكرار',
                                            hintText: 'العدد',
                                            errorText: _errorText2,

                                            contentPadding: EdgeInsets.only(
                                                right: 3,
                                                left: 3,
                                                top: 10,
                                                bottom: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              gapPadding: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                          ),
                                          maxLines: 1,
                                          minLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 21,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          'التكرار ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[300]
                                                      : Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // pressed = false;
                                        Navigator.of(context).pop();
                                        pressed = false;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'تعديل ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Aedite_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  Future<void> Dlete_sumbit(int index) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color(0xFF76d668),
        content: Text(
          textAlign: TextAlign.end,
          'تم بنجاح ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
    setState(() {
      String text = widget.ListOfAskar.removeAt(index);
      int key = widget.ListOfKeys.removeAt(index);
      DleteAskar(widget.text, widget.repet);
      widget._key.currentState!.removeItem(index, (context, animation) {
        return SizeTransition(
          key: ValueKey(widget.text),
          sizeFactor: animation,
          child: CardStyleOne1(
              widget.boxtText,
              widget.boxRepet,
              widget.ListOfAskar,
              widget.ListOfKeys,
              widget._key,
              key,
              text,
              animation, () {
            setState(() {
              widget.ListOfAskar;
              widget.ListOfKeys;
            });
          }, widget.C),
        );
      }, duration: Duration(milliseconds: 450));

      widget.f();

      Navigator.of(context).pop(text);
      pressed = false;
    });
    widget.f();
    // print('###########################Add############################');
    // print(box.toMap());
  }

  Future<String?> openDialogDlete(int index, String text, int repet) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 225,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'حذف ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.trashCan,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      ' !سيتم حذف الذكر ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'حذف ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Dlete_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  void removeItem() {
    setState(() {
      Provider.of<MyData>(context, listen: false).AddedNumber();
      if (widget.repet == 0) {
        String text = widget.ListOfAskar.removeAt(index);

        int key = widget.ListOfKeys.removeAt(index);
        widget._key.currentState!.removeItem(index, (context, animation) {
          return SlideTransition(
            key: ValueKey(widget.text),
            position: animation.drive(Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset(0, 0),
            )),
            child: CardStyleOne1(
                widget.boxtText,
                widget.boxRepet,
                widget.ListOfAskar,
                widget.ListOfKeys,
                widget._key,
                key,
                text,
                animation, () {
              setState(() {
                widget.ListOfAskar;
                widget.ListOfKeys;
              });
            }, widget.C),
          );
        }, duration: Duration(milliseconds: 450));

        widget.f();
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   setTheSizeOfText();
    //   size;
    // });

    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () {
              int value = 0;
              setState(() {
                if (!Provider.of<MyData>(context, listen: false).edite &&
                    !Provider.of<MyData>(context, listen: false).dlete) {
                  value = widget.repet--;
                  widget.ListOfKeys[index] = value - 1;
                  removeItem();
                } else if (Provider.of<MyData>(context, listen: false).edite) {
                  //###############edite Card ###################
                  openDialogEdite(index, widget.text, widget.repet);
                  Provider.of<MyData>(context, listen: false).mEditeF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                } else {
                  //############### dlete Card ###################
                  openDialogDlete(index, widget.text, widget.repet);

                  Provider.of<MyData>(context, listen: false).mDleteF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                }
              });
            },
            child: AbsorbPointer(
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 100, minWidth: double.infinity),
                margin: EdgeInsets.only(bottom: 60),
                decoration: BoxDecoration(
                  color: c[5],
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  border: Border.all(
                    color: Provider.of<MyData>(context).red
                        ? Colors.red
                        : Color(0xffFFFFF4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Provider.of<MyData>(context).red
                          ? Color(0xffFFFFF4)
                          : Colors.black87,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
                  child: Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Provider.of<MyData>(context).sizeOfText,
                      color: c[4],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 15,
            width: 340,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: c[6],
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!Provider.of<MyData>(context, listen: false)
                                .edite &&
                            !Provider.of<MyData>(context, listen: false)
                                .dlete) {
                          // shared linkes  here
                        } else if (Provider.of<MyData>(context, listen: false)
                            .edite) {
                          //###############edite Card ###################
                          openDialogEdite(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mEditeF();
                        } else {
                          //############### dlete Card ###################
                          openDialogDlete(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mDleteF();
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 2, color: c[7])),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: c[7],
                                ),
                              ),
                            ),
                            Text(
                              'مشاركه ',
                              style: TextStyle(color: c[9], fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    endIndent: 10,
                    color: c[8],
                    indent: 10,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      int value = 0;
                      setState(() {
                        if (!Provider.of<MyData>(context, listen: false)
                                .edite &&
                            !Provider.of<MyData>(context, listen: false)
                                .dlete) {
                          value = widget.repet--;
                          widget.ListOfKeys[index] = value - 1;
                          removeItem();
                        } else if (Provider.of<MyData>(context, listen: false)
                            .edite) {
                          //###############edite Card ###################
                          openDialogEdite(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mEditeF();
                        } else {
                          //############### dlete Card ###################
                          openDialogDlete(index, widget.text, widget.repet);
                          Provider.of<MyData>(context, listen: false).mDleteF();
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: Container(
                        margin: EdgeInsets.only(right: 30, left: 30),
                        child: Row(
                          children: [
                            Container(
                              width: 33.0,
                              height: 33.0,
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: c[7],
                                      width: 2,
                                      style: BorderStyle.solid)),
                              child: new RawMaterialButton(
                                shape: new CircleBorder(),
                                elevation: 0.0,
                                child: Text(
                                  '${widget.repet}',
                                  style: TextStyle(fontSize: 15, color: c[7]),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              'التكرار ',
                              style: TextStyle(color: c[9], fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardStyleTwo1 extends StatefulWidget {
  Box boxtText;
  Box boxRepet;
  List<String> ListOfAskar;
  List<int> ListOfKeys;
  GlobalKey<AnimatedListState> _key;

  int repet;
  String text;
  Function f;
  Animation<double> animation;
  List<Color> C;

  CardStyleTwo1(this.boxtText, this.boxRepet, this.ListOfAskar, this.ListOfKeys,
      this._key, this.repet, this.text, this.animation, this.f, this.C);

  @override
  State<CardStyleTwo1> createState() => _CardStyleTwo1State();
}

class _CardStyleTwo1State extends State<CardStyleTwo1> {
  late List<Color> c;
  int index = 0;
  String error = '';

  final _controllerTextFiled = TextEditingController();
  final _controllerTextFiled2 = TextEditingController();

  bool pressed = false;
  String? get _errorText {
    var text = _controllerTextFiled.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  String? get _errorText2 {
    var text = _controllerTextFiled2.text;
    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      error = 'برجاء أدخال رقم التكرار ';
      return '';
      // } else if ((text.isEmpty || text.trim().isEmpty)) {
      //   error = 'برجاء أدخال رقم التكرار ';
    } else if ((text == '0' ||
            text == '00' ||
            text == '000' ||
            text == '0000' ||
            text == '00000' ||
            text == '000000') &&
        pressed) {
      error = 'يجب ان لا يقل عدد التكرار عن واحد ';
      return '';
    }
    error = '';

    // return null if the text is valid
    return null;
  }

  void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == oldtext,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == oldRepet,
        orElse: () => 'null');

    widget.boxtText.put(keytext, newText);
    widget.boxRepet.put(keyRepet, newRepet);
  }

  Future<void> Aedite_sumbit(int index) async {
    String text = _controllerTextFiled.text;
    String text2 = _controllerTextFiled2.text;
    pressed = true;
    var validate1 = _errorText;
    var validate2 = _errorText2;
    if (validate1 == null && validate2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color(0xFF76d668),
          content: Text(
            textAlign: TextAlign.end,
            'تم بنجاح ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
      setState(() {
        //############add in list3##############
        editAskar(widget.text, widget.repet, text, int.parse(text2));
        widget.ListOfKeys[index] = int.parse(text2);
        widget.ListOfAskar[index] = text;
        Navigator.of(context).pop(text);
        pressed = false;
      });
      widget.f();
      // print('###########################Add############################');
      // print(box.toMap());
    }
  }

  Future<String?> openDialogEdite(int index, String text, int key) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 470,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تعديل ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'النص ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    child: TextField(
                                      controller: _controllerTextFiled,
                                      autofocus: false,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color:
                                            Provider.of<MyData>(context).mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black,
                                      ),
                                      onSubmitted: (_) {},
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        errorText: _errorText,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 4),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                      ),
                                      maxLines: 5,
                                      minLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        error,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red[900]),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 75,
                                        height: 75,
                                        child: TextField(
                                          controller: _controllerTextFiled2,
                                          maxLength: 6,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Provider.of<MyData>(context)
                                                        .mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black54,
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          onSubmitted: (_) {},
                                          keyboardType: TextInputType.number,
                                          onChanged: (text) {
                                            setState(() {
                                              _errorText2;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            // labelText: 'التكرار',
                                            hintText: 'العدد',
                                            errorText: _errorText2,

                                            contentPadding: EdgeInsets.only(
                                                right: 3,
                                                left: 3,
                                                top: 10,
                                                bottom: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              gapPadding: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                          ),
                                          maxLines: 1,
                                          minLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 21,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          'التكرار ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[300]
                                                      : Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // pressed = false;
                                        Navigator.of(context).pop();
                                        pressed = false;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'تعديل ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Aedite_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  void DleteAskar(String text, int repet) {
    var keytext = widget.boxtText.toMap().keys.firstWhere(
        (k) => widget.boxtText.toMap()[k] == text,
        orElse: () => 'null');
    var keyRepet = widget.boxRepet.toMap().keys.firstWhere(
        (k) => widget.boxRepet.toMap()[k] == repet,
        orElse: () => 'null');

    widget.boxtText.delete(keytext);
    widget.boxRepet.delete(keyRepet);
  }

  Future<void> Dlete_sumbit(int index) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color(0xFF76d668),
        content: Text(
          textAlign: TextAlign.end,
          'تم بنجاح ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
    setState(() {
      String text = widget.ListOfAskar.removeAt(index);
      int key = widget.ListOfKeys.removeAt(index);
      DleteAskar(widget.text, widget.repet);
      widget._key.currentState!.removeItem(index, (context, animation) {
        return SizeTransition(
          key: ValueKey(widget.text),
          sizeFactor: animation,
          child: CardStyleTwo1(
              widget.boxtText,
              widget.boxRepet,
              widget.ListOfAskar,
              widget.ListOfKeys,
              widget._key,
              key,
              text,
              animation, () {
            setState(() {
              widget.ListOfAskar;
              widget.ListOfKeys;
            });
          }, widget.C),
        );
      }, duration: Duration(milliseconds: 450));

      widget.f();

      Navigator.of(context).pop(text);
      pressed = false;
    });
    widget.f();
    // print('###########################Add############################');
    // print(box.toMap());
  }

  Future<String?> openDialogDlete(int index, String text, int repet) =>
      showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 225,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'حذف ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.trashCan,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      ' !سيتم حذف الذكر ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'حذف ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Dlete_sumbit(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
  @override
  void initState() {
    _controllerTextFiled.text = widget.text;
    _controllerTextFiled2.text = widget.repet.toString();
    setState(() {
      index = widget.ListOfAskar.indexOf(widget.text);
    });
    Provider.of<MyData>(context, listen: false).setSizeOfText();

    c = widget.C;

    super.initState();
  }

  void removeItem() {
    setState(() {
      Provider.of<MyData>(context, listen: false).AddedNumber();
      if (widget.repet == 0) {
        String text = widget.ListOfAskar.removeAt(index);

        int key = widget.ListOfKeys.removeAt(index);
        widget._key.currentState!.removeItem(index, (context, animation) {
          return SlideTransition(
            key: ValueKey(widget.text),
            position: animation.drive(Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset(0, 0),
            )),
            child: CardStyleTwo1(
                widget.boxtText,
                widget.boxRepet,
                widget.ListOfAskar,
                widget.ListOfKeys,
                widget._key,
                key,
                text,
                animation, () {
              setState(() {
                widget.ListOfAskar;
                widget.ListOfKeys;
              });
            }, widget.C),
          );
        }, duration: Duration(milliseconds: 450));

        widget.f();
      }
    });
  }

  // c0  bigContainer and bottonContainer and iconColor
// c1   container of text fill
// c2 shadow of textContainer
// c3 text of container
// c4 Icon Cirecl fill color
// c5  text in icons container

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 35),
      decoration: BoxDecoration(
        color: c[0],
        // border: Border.all(
        //   color: Provider.of<MyData>(context).red ? Colors.red : c[0],
        // ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Provider.of<MyData>(context).red ? Colors.red : c[0],
        //     blurRadius: 1,
        //   )
        // ],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              int value = 0;
              setState(() {
                if (!Provider.of<MyData>(context, listen: false).edite &&
                    !Provider.of<MyData>(context, listen: false).dlete) {
                  value = widget.repet--;
                  widget.ListOfKeys[index] = value - 1;
                  removeItem();
                } else if (Provider.of<MyData>(context, listen: false).edite) {
                  //###############edite Card ###################
                  openDialogEdite(index, widget.text, widget.repet);
                  Provider.of<MyData>(context, listen: false).mEditeF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                } else {
                  //############### dlete Card ###################
                  openDialogDlete(index, widget.text, widget.repet);

                  Provider.of<MyData>(context, listen: false).mDleteF();
                  Provider.of<MyData>(context, listen: false).changeRed(false);
                }
              });
            },
            child: AbsorbPointer(
              child: Container(
                  constraints:
                      BoxConstraints(minHeight: 100, minWidth: double.infinity),
                  decoration: BoxDecoration(
                    color: c[1],
                    boxShadow: [
                      BoxShadow(
                        color: Provider.of<MyData>(context).red
                            ? Colors.red
                            : c[2],
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Provider.of<MyData>(context).sizeOfText,
                        color: c[3],
                      ),
                    ),
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            alignment: Alignment.bottomCenter,
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: c[0],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (!Provider.of<MyData>(context, listen: false).edite &&
                          !Provider.of<MyData>(context, listen: false).dlete) {
                        // shared linkes  here
                      } else if (Provider.of<MyData>(context, listen: false)
                          .edite) {
                        //###############edite Card ###################
                        openDialogEdite(index, widget.text, widget.repet);
                        Provider.of<MyData>(context, listen: false).mEditeF();
                      } else {
                        //############### dlete Card ###################
                        openDialogDlete(index, widget.text, widget.repet);
                        Provider.of<MyData>(context, listen: false).mDleteF();
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: Container(
                      margin: EdgeInsets.only(left: 40, right: 40),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: c[4],
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 1,
                                color: c[0],
                              ),
                            ),
                            child: GestureDetector(
                              child: Icon(
                                Icons.share,
                                size: 18,
                                color: c[0],
                              ),
                            ),
                          ),
                          Text(
                            'مشاركه ',
                            style: TextStyle(color: c[5], fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    int value = 0;
                    setState(() {
                      if (!Provider.of<MyData>(context, listen: false).edite &&
                          !Provider.of<MyData>(context, listen: false).dlete) {
                        value = widget.repet--;
                        widget.ListOfKeys[index] = value - 1;
                        removeItem();
                      } else if (Provider.of<MyData>(context, listen: false)
                          .edite) {
                        //###############edite Card ###################
                        openDialogEdite(index, widget.text, widget.repet);
                        Provider.of<MyData>(context, listen: false).mEditeF();
                        Provider.of<MyData>(context, listen: false)
                            .changeRed(false);
                      } else {
                        //############### dlete Card ###################
                        openDialogDlete(index, widget.text, widget.repet);

                        Provider.of<MyData>(context, listen: false).mDleteF();
                        Provider.of<MyData>(context, listen: false)
                            .changeRed(false);
                      }
                    });
                  },
                  child: AbsorbPointer(
                    child: Container(
                      margin: EdgeInsets.only(right: 40, left: 40),
                      child: Row(
                        children: [
                          Container(
                            width: 31.0,
                            height: 31.0,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: c[4],
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: c[0],
                                    width: 1,
                                    style: BorderStyle.solid)),
                            child: new RawMaterialButton(
                              shape: new CircleBorder(),
                              elevation: 0.0,
                              child: Text(
                                '${widget.repet}',
                                style: TextStyle(fontSize: 15, color: c[0]),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Text(
                            'التكرار ',
                            style: TextStyle(color: c[5], fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GetStickyWidget extends StatefulWidget {
  String askarType;
  Box boxtText;
  Box boxRepet;
  List<String> ListOfAskar;
  List<int> ListOfKeys;
  GlobalKey<AnimatedListState> _key;
  bool arrowApper;

  GetStickyWidget(this.askarType, this.boxtText, this.boxRepet,
      this.ListOfAskar, this.ListOfKeys, this._key, this.arrowApper);

  @override
  State<GetStickyWidget> createState() => _GetStickyWidgetState();
}

class _GetStickyWidgetState extends State<GetStickyWidget> {
  final _controllerTextFiled = TextEditingController();
  final _controllerTextFiled2 = TextEditingController();
  String error = '';
  @override
  void initState() {
    _controllerTextFiled2.text = '1';
    super.initState();
  }

  bool pressed = false;
  String? get _errorText {
    var text = _controllerTextFiled.text;

    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      return 'برجاء أضافه دعاء او ذكر';
    }

    // return null if the text is valid
    return null;
  }

  String? get _errorText2 {
    var text = _controllerTextFiled2.text;
    if ((text.isEmpty || text.trim().isEmpty) && pressed) {
      error = 'برجاء أدخال رقم التكرار ';
      return '';
      // } else if ((text.isEmpty || text.trim().isEmpty)) {
      //   error = 'برجاء أدخال رقم التكرار ';
    } else if ((text == '0' ||
            text == '00' ||
            text == '000' ||
            text == '0000' ||
            text == '00000' ||
            text == '000000') &&
        pressed) {
      error = 'يجب ان لا يقل عدد التكرار عن واحد ';
      return '';
    }
    error = '';

    // return null if the text is valid
    return null;
  }

  void addAskar(String text, int repet) async {
    widget.boxtText.add(text);
    widget.boxRepet.add(repet);
  }

  Future<void> Anew_sumbit() async {
    String text = _controllerTextFiled.text;
    String text2 = _controllerTextFiled2.text;
    pressed = true;
    var validate1 = _errorText;
    var validate2 = _errorText2;
    if (validate1 == null && validate2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 500),
          backgroundColor: Color(0xFF76d668),
          content: Text(
            textAlign: TextAlign.end,
            'تم بنجاح ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
      setState(() {
        //############add in list3##############
        addAskar(text, int.parse(text2));
        widget.ListOfAskar.add(text);
        widget.ListOfKeys.add(int.parse(text2));

        widget._key.currentState!.insertItem(widget.ListOfAskar.length - 1);
        Navigator.of(context).pop(text);

        _controllerTextFiled.clear();
        pressed = false;
      });
      // print('###########################Add############################');
      // print(box.toMap());
    }
  }

  Future<String?> openDialogInsert() => showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => WillPopScope(
            onWillPop: () async {
              setState(() {
                pressed = false;
              });
              return true;
            },
            child: AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 470,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'إضافه ذكر / دعاء',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'النص ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Colors.grey[300]
                                              : Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    child: TextField(
                                      controller: _controllerTextFiled,
                                      autofocus: false,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color:
                                            Provider.of<MyData>(context).mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black,
                                      ),
                                      onSubmitted: (_) {},
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        errorText: _errorText,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 4),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          gapPadding: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              width: 1),
                                        ),
                                      ),
                                      maxLines: 5,
                                      minLines: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        error,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red[900]),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 75,
                                        height: 75,
                                        child: TextField(
                                          controller: _controllerTextFiled2,
                                          maxLength: 6,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Provider.of<MyData>(context)
                                                        .mode ==
                                                    'N'
                                                ? Colors.grey[300]
                                                : Colors.black54,
                                          ),
                                          textAlign: TextAlign.center,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          onSubmitted: (_) {},
                                          keyboardType: TextInputType.number,
                                          onChanged: (text) {
                                            setState(() {
                                              _errorText2;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            // labelText: 'التكرار',
                                            hintText: 'العدد',
                                            errorText: _errorText2,

                                            contentPadding: EdgeInsets.only(
                                                right: 3,
                                                left: 3,
                                                top: 10,
                                                bottom: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              gapPadding: 0.0,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Provider.of<MyData>(
                                                                  context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  width: 1),
                                            ),
                                          ),
                                          maxLines: 1,
                                          minLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 21,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          'التكرار ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[300]
                                                      : Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
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
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'إضافة ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
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
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Future<void> reset_sumbit() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Color(0xFF76d668),
        content: Text(
          textAlign: TextAlign.end,
          'تم بنجاح ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
    setState(() {
      widget.boxtText.clear();
      widget.boxRepet.clear();
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  Future<String?> openDialogReset() => showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              content: Container(
                height: 275,
                width: 400,
                decoration: BoxDecoration(
                  color: Provider.of<MyData>(context).mode == 'N'
                      ? Color(0xff503385)
                      : Color(0xFF76d668),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'اعادة الاذكار الافتراضيه',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Colors.grey[300]
                                    : Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.trashCan,
                                size: 15,
                                color: Provider.of<MyData>(context).mode == 'N'
                                    ? Color(0xff503385)
                                    : Color(0xFF76d668),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              Provider.of<MyData>(context).menuItemBackground,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'سيتم مسح كل الاذكار! '
                                      'واضافه الاذكار الافتراضيه ',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 5, right: 5, top: 8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkResponse(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                              .menuItemBackground,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                          border: Border.all(
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'رجوع ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.white
                                                      : Colors.grey,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 9),
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        decoration: BoxDecoration(
                                          color: Provider.of<MyData>(context)
                                                      .mode ==
                                                  'N'
                                              ? Color(0xff880ED4)
                                              : Color(0xFF76d668),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'اعادة ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Provider.of<MyData>(context)
                                                              .mode ==
                                                          'N'
                                                      ? Colors.grey[200]
                                                      : Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          reset_sumbit();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );

  @override
  void dispose() {
    _controllerTextFiled.dispose();
    _controllerTextFiled2.dispose();
    // brain.localData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MyData>(context, listen: false).setBackground();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          height: 10,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 0, color: Provider.of<MyData>(context).appBarColor),
              color: Provider.of<MyData>(context).appBarColor),
        ),
        Container(
          height: 50,
          color: Provider.of<MyData>(context).bellowAppBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    widget.arrowApper
                        ? Container()
                        : IconButton(
                            onPressed: () {
                              Provider.of<MyData>(context, listen: false).end();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => calcPage(
                                        Provider.of<MyData>(context,
                                                listen: false)
                                            .addedNumber,
                                        widget.askarType),
                                  ));
                              Future.delayed(Duration(seconds: 1), () {
                                setState(() {
                                  Provider.of<MyData>(context, listen: false)
                                      .clearAddedNumber();
                                });
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                              color: Colors.grey,
                            ),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<MyData>(context, listen: false)
                            .changeNight();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.moon,
                        color: Provider.of<MyData>(context)
                            .bellowAppBar_NightIcon_Color,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<MyData>(context, listen: false)
                            .decreaseSize();
                      },
                      child: Text(
                        'ض',
                        style: TextStyle(
                            color: Provider.of<MyData>(context)
                                .bellowAppBarIconColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<MyData>(context, listen: false)
                            .increaseSize();
                      },
                      child: Text(
                        'ض',
                        style: TextStyle(
                            color: Provider.of<MyData>(context)
                                .bellowAppBarIconColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<MyData>(context, listen: false)
                            .changeMode();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.brush,
                        color:
                            Provider.of<MyData>(context).bellowAppBarIconColor,
                        size: 23,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            alignment: Alignment(0, -0.53),
                            insetPadding: EdgeInsets.all(10),
                            contentPadding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            content: Container(
                              decoration: BoxDecoration(
                                  color: Provider.of<MyData>(context)
                                      .menuItemBackground,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  border: Border.all(
                                      color:
                                          Provider.of<MyData>(context).mode ==
                                                  'N'
                                              ? Colors.grey
                                              : Colors.white)),
                              width: 400,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Minu_Item(
                                      'صدقه جارية ',
                                      FontAwesomeIcons.solidHeart,
                                      Provider.of<MyData>(context).mode == 'N'
                                          ? Color(0xff503385)
                                          : Colors.green),
                                  Container(
                                    height: 1,
                                    color: Provider.of<MyData>(context)
                                        .horizontalLineColor,
                                    width: double.infinity,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _controllerTextFiled2.text = '1';
                                      Navigator.of(context).pop();

                                      await openDialogInsert();
                                      setState(() {
                                        pressed = false;
                                      });
                                    },
                                    child: Minu_Item(
                                        'أضافة ذكر ',
                                        FontAwesomeIcons.plus,
                                        Provider.of<MyData>(context).mode == 'N'
                                            ? Color(0xff503385)
                                            : Color(0xFF76d668)),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Provider.of<MyData>(context)
                                        .horizontalLineColor,
                                    width: double.infinity,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Provider.of<MyData>(context,
                                              listen: false)
                                          .mEditeT();
                                      Provider.of<MyData>(context,
                                              listen: false)
                                          .changeRed(true);
                                      Navigator.of(context).pop();
                                    },
                                    child: Minu_Item(
                                        'تعديل ذكر ',
                                        FontAwesomeIcons.pen,
                                        Provider.of<MyData>(context).mode == 'N'
                                            ? Color(0xff503385)
                                            : Color(0xFF76d668)),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Provider.of<MyData>(context)
                                        .horizontalLineColor,
                                    width: double.infinity,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Provider.of<MyData>(context,
                                                listen: false)
                                            .mDleteT();
                                        Provider.of<MyData>(context,
                                                listen: false)
                                            .changeRed(true);
                                        Navigator.of(context).pop();
                                      },
                                      child: Minu_Item(
                                          'حذف ذكر ',
                                          FontAwesomeIcons.trashCan,
                                          Provider.of<MyData>(context).mode ==
                                                  'N'
                                              ? Color(0xff503385)
                                              : Color(0xFF76d668)),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Provider.of<MyData>(context)
                                        .horizontalLineColor,
                                    width: double.infinity,
                                  ),
                                  Minu_Item(
                                    'اعدادات التنبيهات ',
                                    FontAwesomeIcons.bell,
                                    Provider.of<MyData>(context).mode == 'N'
                                        ? Color(0xff503385)
                                        : Color(0xFF76d668),
                                  ),
                                  Container(
                                    height: 1,
                                    color: Provider.of<MyData>(context)
                                        .horizontalLineColor,
                                    width: double.infinity,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      openDialogReset();
                                    },
                                    child: Minu_Item(
                                        ' اعادة اذكار الصباح الافتراضيه',
                                        FontAwesomeIcons.flag,
                                        Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.menu,
                          size: 30,
                          color: Provider.of<MyData>(context)
                              .bellowAppBarIconColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Minu_Item extends StatefulWidget {
  String text;
  IconData icons;
  Color fillIconColor;

  Minu_Item(this.text, this.icons, this.fillIconColor);

  @override
  State<Minu_Item> createState() => _Minu_ItemState();
}

class _Minu_ItemState extends State<Minu_Item> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        margin: EdgeInsets.fromLTRB(60, 8, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: widget.fillIconColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: GestureDetector(
                child: FaIcon(
                  widget.icons,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
