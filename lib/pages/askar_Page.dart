import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'calculating page.dart';
import 'package:test_local_notification1/providerAskarBrain.dart';
import 'package:test_local_notification1/askars_component.dart';

class AskarPage extends StatefulWidget {
  String typeOfAskar;
  Box boxOfText;
  Box boxOfRepet;
  List<String> listOfAskar;
  List<int> listOfRepet;

  AskarPage(this.typeOfAskar, this.boxOfText, this.boxOfRepet, this.listOfAskar,
      this.listOfRepet);

  @override
  State<AskarPage> createState() => _AskarPageState();
}

class _AskarPageState extends State<AskarPage> {
  var box = Hive.box('askar_custom');
  late var boxtText;
  late var boxRepet;
  bool flag = true;
  // 'size' key  for decrease or increase
  // 'mode' key for mode
  // 'nConst' key for nConst
  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<String> ListOfAskar = [];
  List<int> ListOfKeys = [];
  void setDataBase() {
    var t = boxtText.isEmpty;
    // 2 the minmum number for askar
    if (t) {
      ListOfKeys = [];
      ListOfAskar = [];
      List<String> askar = widget.listOfAskar;
      List<int> repet = widget.listOfRepet;
      for (int i = 0; i < askar.length; i++) {
        boxtText.put(i, askar[i]);
        boxRepet.put(i, repet[i]);
        ListOfAskar.add(askar[i]);
        ListOfKeys.add(repet[i]);
      }
    } else {
      ListOfKeys = [];
      ListOfAskar = [];
      Map map1 = boxtText.toMap();
      for (final mapEntry in map1.entries) {
        var key = mapEntry.key;
        var value = mapEntry.value;
        ListOfAskar.add(value);
      }
      Map map2 = boxRepet.toMap();
      for (final mapEntry in map2.entries) {
        var key = mapEntry.key;
        var value = mapEntry.value;
        ListOfKeys.add(value);
      }

      // int v = boxtText.length - 1;
      // for (int i = 0; i < v; i++) {
      //   ListOfKeys = [];
      //   ListOfAskar = [];
      //   ListOfAskar.add(boxtText.get(i));
      //   ListOfKeys.add(boxRepet.get(i));
      // }
    }
    // print('#########################################');
    // print(ListOfKeys);
    // print(boxRepet.toMap());
    // print(boxtText.toMap());
  }

  late IconData icon;

  double _removableWidgetSize = 50;
  bool _isStickyOnTop = false;
  bool arrwoApper = true;
  bool shouldPop = true;

  Widget cards(
      Box bt,
      Box br,
      List<String> lt,
      List<int> lr,
      GlobalKey<AnimatedListState> k,
      String t,
      int r,
      Function f,
      Animation<double> a,
      int index) {
    late Widget w;
    String mode = Provider.of<MyData>(context, listen: false).mode;
    if (mode == '01') {
      w = CardStyleOne1(
          bt, br, lt, lr, k, r, t, a, f, Provider.of<MyData>(context).colors01);
    } else if (mode == '02') {
      w = CardStyleTwo1(
          bt, br, lt, lr, k, r, t, a, f, Provider.of<MyData>(context).colors02);
    } else if (mode == '03') {
      w = CardStyleOne1(
          bt, br, lt, lr, k, r, t, a, f, Provider.of<MyData>(context).colors03);
    } else if (mode == '04') {
      w = CardStyleTwo1(
          bt, br, lt, lr, k, r, t, a, f, Provider.of<MyData>(context).colors04);
    } else if (mode == 'N') {
      w = CardStyleN1(
          bt, br, lt, lr, k, r, t, a, f, Provider.of<MyData>(context).colorsN);
    }

    return w;
  }

  @override
  void initState() {
    boxtText = widget.boxOfText;
    boxRepet = widget.boxOfRepet;
    setState(() {
      if (widget.typeOfAskar == 'أذكارالصباح ') {
        icon = FontAwesomeIcons.cloudSun;
      } else if (widget.typeOfAskar == 'أذكارالمساء ') {
        icon = FontAwesomeIcons.cloudMoon;
      } else if (widget.typeOfAskar == 'أذكارالمسجد ') {
        icon = FontAwesomeIcons.mosque;
      } else if (widget.typeOfAskar == 'أذكارالإستيقاظ ') {
        icon = FontAwesomeIcons.clock;
      } else if (widget.typeOfAskar == 'أذكارالنوم ') {
        icon = FontAwesomeIcons.bed;
      } else {
        icon = FontAwesomeIcons.handsPraying;
      }
    });
    Provider.of<MyData>(context, listen: false).setSizeOfText();

    _mainScrollController.addListener(() {
      int height = _mainScrollController.offset.toInt();
      // print('##########################################################');
      if (_mainScrollController.offset >= _removableWidgetSize &&
          !_isStickyOnTop) {
        setState(() {
          _isStickyOnTop = true;
        });
      } else if (_mainScrollController.offset < _removableWidgetSize &&
          _isStickyOnTop) {
        setState(() {
          _isStickyOnTop = false;
        });
      } else if (height >= 10) {
        setState(() {
          arrwoApper = false;
        });
      } else if (height < 10) {
        setState(() {
          arrwoApper = true;
        });
      }
    });

    if (mounted) {
      setState(() {
        setDataBase();
        ListOfKeys;
        ListOfAskar;
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    _subScrollController.dispose();
    // Provider.of<MyData>(context, listen: false).`setDataBase`Morning();

    // Future.delayed(const Duration(microseconds: 10), () {
    //   setState(() {
    //     added_number = 0;
    //   });
    // });
    super.dispose();
  }

  void endOfAskar() {
    if (ListOfAskar.isEmpty && flag) {
      setState(() {
        flag = false;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        Provider.of<MyData>(context, listen: false).end();

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => calcPage(
                  Provider.of<MyData>(context, listen: false).addedNumber,
                  widget.typeOfAskar),
            ));
        Future.delayed(Duration(seconds: 1), () {
          Provider.of<MyData>(context, listen: false).clearAddedNumber();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    endOfAskar();
    Provider.of<MyData>(context, listen: false).setBackground();
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MyData>(context, listen: false).end();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => calcPage(
                  Provider.of<MyData>(context, listen: false).addedNumber,
                  widget.typeOfAskar),
            ));
        Future.delayed(Duration(seconds: 1), () {
          Provider.of<MyData>(context, listen: false).clearAddedNumber();
        });
        return false;
      },
      child: Container(
          color: Colors.grey,
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Provider.of<MyData>(context).scaffoledColor,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          StretchingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            child: ListView(
                                controller: _mainScrollController,
                                padding: EdgeInsets.all(0),
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    height: 60.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0,
                                            color: Provider.of<MyData>(context)
                                                .appBarColor),
                                        color: Provider.of<MyData>(context)
                                            .appBarColor),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Visibility(
                                          visible: arrwoApper,
                                          child: IconButton(
                                            padding: widget.typeOfAskar ==
                                                        'أذكارالصلاه' ||
                                                    widget.typeOfAskar ==
                                                        'أذكارالنوم '
                                                ? EdgeInsets.only(right: 40)
                                                : EdgeInsets.all(0),
                                            onPressed: () async {
                                              Provider.of<MyData>(context,
                                                      listen: false)
                                                  .end();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        calcPage(
                                                            Provider.of<MyData>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addedNumber,
                                                            widget.typeOfAskar),
                                                  ));
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                setState(() {
                                                  Provider.of<MyData>(context,
                                                          listen: false)
                                                      .clearAddedNumber();
                                                });
                                              });
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              size: 30.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: widget.typeOfAskar ==
                                                  'أذكارالإستيقاظ '
                                              ? 30
                                              : 50,
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            child: FaIcon(
                                              icon,
                                              size: 35,
                                              color: Colors.white70,
                                            )),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                              right: 40, left: 75),
                                          child: Text(
                                            widget.typeOfAskar,
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!_isStickyOnTop)
                                    GetStickyWidget(
                                        widget.typeOfAskar,
                                        boxtText,
                                        boxRepet,
                                        ListOfAskar,
                                        ListOfKeys,
                                        _key,
                                        arrwoApper),
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      setState(() {
                                        ListOfKeys;
                                        ListOfAskar;
                                      });
                                      // Box boxtText;
                                      // Box boxRepet;
                                      // List<String> ListOfAskar;
                                      // List<int> ListOfKeys;
                                      // GlobalKey<AnimatedListState> _key;
                                      // int added_number;
                                      return AnimatedList(
                                        itemBuilder:
                                            (context, index, animation) {
                                          return cards(
                                              boxtText,
                                              boxRepet,
                                              ListOfAskar,
                                              ListOfKeys,
                                              _key,
                                              ListOfAskar[index],
                                              ListOfKeys[index], () {
                                            setState(() {
                                              ListOfKeys;
                                              ListOfAskar;
                                            });
                                          }, animation, index);
                                        },
                                        initialItemCount: ListOfAskar.length,
                                        key: _key,
                                        physics: ScrollPhysics(),
                                        padding: EdgeInsets.all(20),
                                        shrinkWrap: true,
                                      );
                                    },
                                  ),
                                ]),
                          ),
                          if (_isStickyOnTop)
                            GetStickyWidget(
                                widget.typeOfAskar,
                                boxtText,
                                boxRepet,
                                ListOfAskar,
                                ListOfKeys,
                                _key,
                                arrwoApper)
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
// void setASkarAndKeys() {
//
//
//   Map map = boxt.toMap();
//   ListOfAskar.clear();
//   for (final mapEntry in map.entries) {
//     var value = mapEntry.value;
//     ListOfAskar.add(value);
//   }
//   map = boxr.toMap();
//   ListOfKeys.clear();
//   for (final mapEntry in map.entries) {
//     var value = mapEntry.value;
//     ListOfKeys.add(value);
//   }
//
//   if (ListOfAskar.isEmpty || ListOfKeys.isEmpty) {
//     List<String> text = [];
//     List<int> repet = [];
//     askar_morning.forEach((key, value) {
//       boxt.put('askar', text);
//       boxr.put('repet', repet);
//
//
//     });
//     box.put('askar', text);
//     box.put('repet', repet);
//
//     ListOfAskar = box.get('askar');
//     ListOfKeys = box.get('repet');
//   } else {
//     ListOfKeys = r;
//     ListOfAskar = t;
//   }
//   print('############################################');
//   print(ListOfKeys);
// }
// Future<void> setDataBase(Function f) async {
//   ListOfAskar = [];
//   ListOfKeys = [];
//   ListOfAskar = await box.get('morningAskar11', defaultValue: );
//   ;
//   ListOfKeys = await box.get('repeting11', defaultValue: );
// }

// class GetStickyWidget extends StatefulWidget {
//   bool arrowApper;
//
//   GetStickyWidget(this.arrowApper);
//
//   @override
//   State<GetStickyWidget> createState() => _GetStickyWidgetState();
// }
//
// class _GetStickyWidgetState extends State<GetStickyWidget> {
//   final _controllerTextFiled = TextEditingController();
//   final _controllerTextFiled2 = TextEditingController();
//   String error = '';
//   @override
//   void initState() {
//     _controllerTextFiled2.text = '1';
//     super.initState();
//   }
//
//   bool pressed = false;
//   String? get _errorText {
//     var text = _controllerTextFiled.text;
//
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       return 'برجاء أضافه دعاء او ذكر';
//     }
//
//     // return null if the text is valid
//     return null;
//   }
//
//   String? get _errorText2 {
//     var text = _controllerTextFiled2.text;
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       error = 'برجاء أدخال رقم التكرار ';
//       return '';
//       // } else if ((text.isEmpty || text.trim().isEmpty)) {
//       //   error = 'برجاء أدخال رقم التكرار ';
//     } else if (text == '0' ||
//         text == '00' ||
//         text == '000' ||
//         text == '0000' ||
//         text == '00000' ||
//         text == '000000') {
//       error = 'يجب ان لا يقل عدد التكرار عن واحد ';
//       return '';
//     }
//     error = '';
//
//     // return null if the text is valid
//     return null;
//   }
//
//   void addAskar(String text, int repet) async {
//     boxtText.add(text);
//     boxRepet.add(repet);
//   }
//
//   Future<void> Anew_sumbit() async {
//     String text = _controllerTextFiled.text;
//     String text2 = _controllerTextFiled2.text;
//     pressed = true;
//     var validate1 = _errorText;
//     var validate2 = _errorText2;
//     if (validate1 == null && validate2 == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           duration: Duration(milliseconds: 500),
//           backgroundColor: Color(0xFF76d668),
//           content: Text(
//             textAlign: TextAlign.end,
//             'تم بنجاح ',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//       );
//       setState(() {
//         //############add in list3##############
//         addAskar(text, int.parse(text2));
//         ListOfAskar.add(text);
//         ListOfKeys.add(int.parse(text2));
//
//         _key.currentState!.insertItem(ListOfAskar.length - 1);
//         Navigator.of(context).pop(text);
//
//         _controllerTextFiled.clear();
//         _controllerTextFiled2.text = '1';
//         pressed = false;
//       });
//       // print('###########################Add############################');
//       // print(box.toMap());
//     }
//   }
//
//   Future<String?> openDialogInsert() => showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) => AlertDialog(
//             insetPadding: EdgeInsets.all(20),
//             contentPadding: EdgeInsets.all(0),
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10.0),
//               ),
//             ),
//             content: Container(
//               height: 470,
//               width: 400,
//               decoration: BoxDecoration(
//                 color: Provider.of<MyData>(context).mode == 'N'
//                     ? Color(0xff503385)
//                     : Color(0xFF76d668),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'إضافه ذكر / دعاء',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Provider.of<MyData>(context).mode == 'N'
//                                   ? Colors.grey[300]
//                                   : Colors.white),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           margin: EdgeInsets.only(left: 10),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           child: GestureDetector(
//                             child: FaIcon(
//                               FontAwesomeIcons.plus,
//                               size: 15,
//                               color: Provider.of<MyData>(context).mode == 'N'
//                                   ? Color(0xff503385)
//                                   : Color(0xFF76d668),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Provider.of<MyData>(context).menuItemBackground,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(top: 20, bottom: 20),
//                                   child: Text(
//                                     'النص ',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color:
//                                             Provider.of<MyData>(context).mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black54,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 140,
//                                   child: TextField(
//                                     controller: _controllerTextFiled,
//                                     autofocus: false,
//                                     textAlign: TextAlign.end,
//                                     style: TextStyle(
//                                       fontSize: 18.0,
//                                       color:
//                                           Provider.of<MyData>(context).mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black,
//                                     ),
//                                     onSubmitted: (_) {},
//                                     onChanged: (text) {
//                                       setState(() {});
//                                     },
//                                     decoration: InputDecoration(
//                                       errorText: _errorText,
//                                       contentPadding: EdgeInsets.symmetric(
//                                           vertical: 4, horizontal: 4),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.white
//                                                 : Colors.grey,
//                                             width: 1),
//                                       ),
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.white
//                                                 : Colors.grey,
//                                             width: 1),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         gapPadding: 0.0,
//                                         borderRadius: BorderRadius.circular(10),
//                                         borderSide: BorderSide(
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.white
//                                                 : Colors.grey,
//                                             width: 1),
//                                       ),
//                                     ),
//                                     maxLines: 5,
//                                     minLines: 5,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 25,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       error,
//                                       style: TextStyle(
//                                           fontSize: 12, color: Colors.red[900]),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Container(
//                                       alignment: Alignment.center,
//                                       width: 75,
//                                       height: 75,
//                                       child: TextField(
//                                         controller: _controllerTextFiled2,
//                                         maxLength: 6,
//                                         autofocus: false,
//                                         style: TextStyle(
//                                           fontSize: 18.0,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                         textAlignVertical:
//                                             TextAlignVertical.bottom,
//                                         onSubmitted: (_) {},
//                                         keyboardType: TextInputType.number,
//                                         onChanged: (text) {
//                                           setState(() {
//                                             _errorText2;
//                                           });
//                                         },
//                                         decoration: InputDecoration(
//                                           // labelText: 'التكرار',
//                                           hintText: 'العدد',
//                                           errorText: _errorText2,
//
//                                           contentPadding: EdgeInsets.only(
//                                               right: 3,
//                                               left: 3,
//                                               top: 10,
//                                               bottom: 10),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Provider.of<MyData>(context)
//                                                                 .mode ==
//                                                             'N'
//                                                         ? Colors.white
//                                                         : Colors.grey,
//                                                 width: 1),
//                                           ),
//                                           border: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Provider.of<MyData>(context)
//                                                                 .mode ==
//                                                             'N'
//                                                         ? Colors.white
//                                                         : Colors.grey,
//                                                 width: 1),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             gapPadding: 0.0,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             borderSide: BorderSide(
//                                                 color:
//                                                     Provider.of<MyData>(context)
//                                                                 .mode ==
//                                                             'N'
//                                                         ? Colors.white
//                                                         : Colors.grey,
//                                                 width: 1),
//                                           ),
//                                         ),
//                                         maxLines: 1,
//                                         minLines: 1,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 23,
//                                     ),
//                                     Padding(
//                                       padding: EdgeInsets.only(bottom: 25),
//                                       child: Text(
//                                         'التكرار ',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black54,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 5, right: 5, top: 8),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Expanded(
//                                   child: InkResponse(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 9),
//                                       margin:
//                                           EdgeInsets.only(top: 10, bottom: 10),
//                                       decoration: BoxDecoration(
//                                         color: Provider.of<MyData>(context)
//                                             .menuItemBackground,
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0),
//                                         ),
//                                         border: Border.all(
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.white
//                                                 : Colors.grey),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'رجوع ',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.white
//                                                 : Colors.grey,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       // pressed = false;
//                                       Navigator.of(context).pop();
//                                       _controllerTextFiled.clear();
//                                       pressed = false;
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 25,
//                                 ),
//                                 Expanded(
//                                   child: TextButton(
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 9),
//                                       margin:
//                                           EdgeInsets.only(top: 10, bottom: 10),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             Provider.of<MyData>(context).mode ==
//                                                     'N'
//                                                 ? Color(0xff880ED4)
//                                                 : Color(0xFF76d668),
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10.0),
//                                         ),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'إضافة ',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.grey[200]
//                                                 : Colors.white,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         Anew_sumbit();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//
//   Future<void> reset_sumbit() async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(milliseconds: 500),
//         backgroundColor: Color(0xFF76d668),
//         content: Text(
//           textAlign: TextAlign.end,
//           'تم بنجاح ',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//     );
//     setState(() {
//       boxtText.clear();
//       boxRepet.clear();
//       Navigator.pop(context);
//       Navigator.pop(context);
//       Navigator.pop(context);
//     });
//   }
//
//   Future<String?> openDialogReset() => showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 275,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'اعادة الاذكار الافتراضيه',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.trashCan,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       'سيتم مسح كل الاذكار! '
//                                       'واضافه الاذكار الافتراضيه ',
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'اعادة ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           reset_sumbit();
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   @override
//   void dispose() {
//     _controllerTextFiled.dispose();
//     _controllerTextFiled2.dispose();
//     // brain.localData();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<MyData>(context, listen: false).setBackground();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: EdgeInsets.zero,
//           margin: EdgeInsets.zero,
//           height: 10,
//           decoration: BoxDecoration(
//               border: Border.all(
//                   width: 0, color: Provider.of<MyData>(context).appBarColor),
//               color: Provider.of<MyData>(context).appBarColor),
//         ),
//         Container(
//           height: 50,
//           color: Provider.of<MyData>(context).bellowAppBarColor,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     widget.arrowApper
//                         ? Container()
//                         : IconButton(
//                             onPressed: () {
//                               Provider.of<MyData>(context, listen: false).end();
//
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => calcPage(
//                                         Provider.of<MyData>(context,
//                                                 listen: false)
//                                             .addedNumber),
//                                   ));
//                               Future.delayed(Duration(seconds: 1), () {
//                                 setState(() {
//                                   Provider.of<MyData>(context, listen: false)
//                                       .clearAddedNumber();
//                                 });
//                               });
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               size: 30.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Provider.of<MyData>(context, listen: false)
//                             .changeNight();
//                       },
//                       icon: FaIcon(
//                         FontAwesomeIcons.moon,
//                         color: Provider.of<MyData>(context)
//                             .bellowAppBar_NightIcon_Color,
//                         size: 28,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Provider.of<MyData>(context, listen: false)
//                             .decreaseSize();
//                       },
//                       child: Text(
//                         'ض',
//                         style: TextStyle(
//                             color: Provider.of<MyData>(context)
//                                 .bellowAppBarIconColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Provider.of<MyData>(context, listen: false)
//                             .increaseSize();
//                       },
//                       child: Text(
//                         'ض',
//                         style: TextStyle(
//                             color: Provider.of<MyData>(context)
//                                 .bellowAppBarIconColor,
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Provider.of<MyData>(context, listen: false)
//                             .changeMode();
//                       },
//                       icon: FaIcon(
//                         FontAwesomeIcons.brush,
//                         color:
//                             Provider.of<MyData>(context).bellowAppBarIconColor,
//                         size: 23,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             alignment: Alignment(0, -0.53),
//                             insetPadding: EdgeInsets.all(10),
//                             contentPadding: EdgeInsets.all(0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10.0),
//                               ),
//                             ),
//                             content: Container(
//                               decoration: BoxDecoration(
//                                   color: Provider.of<MyData>(context)
//                                       .menuItemBackground,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(10.0),
//                                   ),
//                                   border: Border.all(
//                                       color:
//                                           Provider.of<MyData>(context).mode ==
//                                                   'N'
//                                               ? Colors.grey
//                                               : Colors.white)),
//                               width: 400,
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Minu_Item(
//                                       'صدقه جارية ',
//                                       FontAwesomeIcons.solidHeart,
//                                       Provider.of<MyData>(context).mode == 'N'
//                                           ? Color(0xff503385)
//                                           : Colors.green),
//                                   Container(
//                                     height: 1,
//                                     color: Provider.of<MyData>(context)
//                                         .horizontalLineColor,
//                                     width: double.infinity,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () async {
//                                       Navigator.of(context).pop();
//                                       await openDialogInsert();
//                                     },
//                                     child: Minu_Item(
//                                         'أضافة ذكر ',
//                                         FontAwesomeIcons.plus,
//                                         Provider.of<MyData>(context).mode == 'N'
//                                             ? Color(0xff503385)
//                                             : Color(0xFF76d668)),
//                                   ),
//                                   Container(
//                                     height: 1,
//                                     color: Provider.of<MyData>(context)
//                                         .horizontalLineColor,
//                                     width: double.infinity,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Provider.of<MyData>(context,
//                                               listen: false)
//                                           .mEditeT();
//                                       Provider.of<MyData>(context,
//                                               listen: false)
//                                           .changeRed(true);
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Minu_Item(
//                                         'تعديل ذكر ',
//                                         FontAwesomeIcons.pen,
//                                         Provider.of<MyData>(context).mode == 'N'
//                                             ? Color(0xff503385)
//                                             : Color(0xFF76d668)),
//                                   ),
//                                   Container(
//                                     height: 1,
//                                     color: Provider.of<MyData>(context)
//                                         .horizontalLineColor,
//                                     width: double.infinity,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         Provider.of<MyData>(context,
//                                                 listen: false)
//                                             .mDleteT();
//                                         Provider.of<MyData>(context,
//                                                 listen: false)
//                                             .changeRed(true);
//                                         Navigator.of(context).pop();
//                                       },
//                                       child: Minu_Item(
//                                           'حذف ذكر ',
//                                           FontAwesomeIcons.trashCan,
//                                           Provider.of<MyData>(context).mode ==
//                                                   'N'
//                                               ? Color(0xff503385)
//                                               : Color(0xFF76d668)),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 1,
//                                     color: Provider.of<MyData>(context)
//                                         .horizontalLineColor,
//                                     width: double.infinity,
//                                   ),
//                                   Minu_Item(
//                                     'اعدادات التنبيهات ',
//                                     FontAwesomeIcons.bell,
//                                     Provider.of<MyData>(context).mode == 'N'
//                                         ? Color(0xff503385)
//                                         : Color(0xFF76d668),
//                                   ),
//                                   Container(
//                                     height: 1,
//                                     color: Provider.of<MyData>(context)
//                                         .horizontalLineColor,
//                                     width: double.infinity,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       openDialogReset();
//                                     },
//                                     child: Minu_Item(
//                                         ' اعادة اذكار الصباح الافتراضيه',
//                                         FontAwesomeIcons.flag,
//                                         Colors.redAccent),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       icon: Icon(Icons.menu,
//                           size: 30,
//                           color: Provider.of<MyData>(context)
//                               .bellowAppBarIconColor),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

// class CardStyleOne extends StatefulWidget {
//   int repet;
//   String text;
//   Function f;
//   Animation<double> animation;
//   List<Color> C;
//
//   CardStyleOne(this.repet, this.text, this.animation, this.f, this.C);
//
//   @override
//   State<CardStyleOne> createState() => _CardStyleOneState();
// }
//
// class _CardStyleOneState extends State<CardStyleOne> {
//   late List<Color> c;
//   int index = 0;
//   String error = '';
//
//   final _controllerTextFiled = TextEditingController();
//   final _controllerTextFiled2 = TextEditingController();
//
//   bool pressed = false;
//   String? get _errorText {
//     var text = _controllerTextFiled.text;
//
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       return 'برجاء أضافه دعاء او ذكر';
//     }
//
//     // return null if the text is valid
//     return null;
//   }
//
//   String? get _errorText2 {
//     var text = _controllerTextFiled2.text;
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       error = 'برجاء أدخال رقم التكرار ';
//       return '';
//       // } else if ((text.isEmpty || text.trim().isEmpty)) {
//       //   error = 'برجاء أدخال رقم التكرار ';
//     } else if (text == '0' ||
//         text == '00' ||
//         text == '000' ||
//         text == '0000' ||
//         text == '00000' ||
//         text == '000000') {
//       error = 'يجب ان لا يقل عدد التكرار عن واحد ';
//       return '';
//     }
//     error = '';
//
//     // return null if the text is valid
//     return null;
//   }
//
//   void DleteAskar(String text, int repet) {
//     var keytext = boxtText
//         .toMap()
//         .keys
//         .firstWhere((k) => boxtText.toMap()[k] == text, orElse: () => 'null');
//     var keyRepet = boxRepet
//         .toMap()
//         .keys
//         .firstWhere((k) => boxRepet.toMap()[k] == repet, orElse: () => 'null');
//
//     boxtText.delete(keytext);
//     boxRepet.delete(keyRepet);
//   }
//
//   void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
//     var keytext = boxtText.toMap().keys.firstWhere(
//         (k) => boxtText.toMap()[k] == oldtext,
//         orElse: () => 'null');
//     var keyRepet = boxRepet.toMap().keys.firstWhere(
//         (k) => boxRepet.toMap()[k] == oldRepet,
//         orElse: () => 'null');
//
//     boxtText.put(keytext, newText);
//     boxRepet.put(keyRepet, newRepet);
//   }
//
//   Future<void> Aedite_sumbit(int index) async {
//     String text = _controllerTextFiled.text;
//     String text2 = _controllerTextFiled2.text;
//     pressed = true;
//     var validate1 = _errorText;
//     var validate2 = _errorText2;
//     if (validate1 == null && validate2 == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           duration: Duration(milliseconds: 500),
//           backgroundColor: Color(0xFF76d668),
//           content: Text(
//             textAlign: TextAlign.end,
//             'تم بنجاح ',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//       );
//       setState(() {
//         //############add in list3##############
//         editAskar(widget.text, widget.repet, text, int.parse(text2));
//         ListOfKeys[index] = int.parse(text2);
//         ListOfAskar[index] = text;
//         Navigator.of(context).pop(text);
//         pressed = false;
//       });
//       widget.f();
//       // print('###########################Add############################');
//       // print(box.toMap());
//     }
//   }
//
//   Future<String?> openDialogEdite(int index, String text, int key) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 470,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'تعديل ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.plus,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       'النص ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 140,
//                                     child: TextField(
//                                       controller: _controllerTextFiled,
//                                       autofocus: false,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                         color:
//                                             Provider.of<MyData>(context).mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black,
//                                       ),
//                                       onSubmitted: (_) {},
//                                       onChanged: (text) {
//                                         setState(() {});
//                                       },
//                                       decoration: InputDecoration(
//                                         errorText: _errorText,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 4, horizontal: 4),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           gapPadding: 0.0,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                       ),
//                                       maxLines: 5,
//                                       minLines: 5,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         error,
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.red[900]),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: 75,
//                                         height: 75,
//                                         child: TextField(
//                                           controller: _controllerTextFiled2,
//                                           maxLength: 6,
//                                           autofocus: false,
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black54,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                           textAlignVertical:
//                                               TextAlignVertical.bottom,
//                                           onSubmitted: (_) {},
//                                           keyboardType: TextInputType.number,
//                                           onChanged: (text) {
//                                             setState(() {
//                                               _errorText2;
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             // labelText: 'التكرار',
//                                             hintText: 'العدد',
//                                             errorText: _errorText2,
//
//                                             contentPadding: EdgeInsets.only(
//                                                 right: 3,
//                                                 left: 3,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               gapPadding: 0.0,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                           ),
//                                           maxLines: 1,
//                                           minLines: 1,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 23,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(bottom: 25),
//                                         child: Text(
//                                           'التكرار ',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[300]
//                                                       : Colors.black54,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         // pressed = false;
//                                         Navigator.of(context).pop();
//                                         pressed = false;
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'إضافة ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Aedite_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   Future<void> Dlete_sumbit(int index) async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(milliseconds: 500),
//         backgroundColor: Color(0xFF76d668),
//         content: Text(
//           textAlign: TextAlign.end,
//           'تم بنجاح ',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//     );
//     setState(() {
//       String text = ListOfAskar.removeAt(index);
//       int key = ListOfKeys.removeAt(index);
//       DleteAskar(widget.text, widget.repet);
//       _key.currentState!.removeItem(index, (context, animation) {
//         return SizeTransition(
//           key: ValueKey(widget.text),
//           sizeFactor: animation,
//           child: CardStyleOne(key, text, animation, () {
//             setState(() {
//               ListOfAskar;
//               ListOfKeys;
//             });
//           }, widget.C),
//         );
//       }, duration: Duration(milliseconds: 450));
//
//       widget.f();
//
//       Navigator.of(context).pop(text);
//       pressed = false;
//     });
//     widget.f();
//     // print('###########################Add############################');
//     // print(box.toMap());
//   }
//
//   Future<String?> openDialogDlete(int index, String text, int repet) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 225,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'حذف ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.trashCan,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       ' !سيتم حذف الذكر ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'حذف ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Dlete_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   @override
//   void initState() {
//     _controllerTextFiled.text = widget.text;
//     _controllerTextFiled2.text = widget.repet.toString();
//     setState(() {
//       index = ListOfAskar.indexOf(widget.text);
//     });
//     Provider.of<MyData>(context, listen: false).setSizeOfText();
//     c = widget.C;
//
//     // c0=appBarColor
//     // c1=bellowAppBarColor
//     // c2=bellowAppBarIconColor
//     // c3=bellowAppBar_NightIcon_Color
//     // c4=cardTextColor
//     // c5=cardContainerColor
//     // c6=cardPositionColor
//     // c7=cardPositionIcon
//     // c8=cardPositionLine
//     // c9=cardPositionTextColor
//
//     super.initState();
//   }
//
//   void removeItem() {
//     setState(() {
//       Provider.of<MyData>(context, listen: false).AddedNumber();
//       if (widget.repet == 0) {
//         String text = ListOfAskar.removeAt(index);
//
//         int key = ListOfKeys.removeAt(index);
//         _key.currentState!.removeItem(index, (context, animation) {
//           return SlideTransition(
//             key: ValueKey(widget.text),
//             position: animation.drive(Tween<Offset>(
//               begin: Offset(-1, 0),
//               end: Offset(0, 0),
//             )),
//             child: CardStyleOne(key, text, animation, () {
//               setState(() {
//                 ListOfAskar;
//                 ListOfKeys;
//               });
//             }, widget.C),
//           );
//         }, duration: Duration(milliseconds: 450));
//
//         widget.f();
//       }
//     });
//   }
//
//   @override
//   @override
//   Widget build(BuildContext context) {
//     // setState(() {
//     //   setTheSizeOfText();
//     //   size;
//     // });
//
//     return SizedBox(
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           GestureDetector(
//             onTap: () {
//               int value = 0;
//               setState(() {
//                 if (!Provider.of<MyData>(context, listen: false).edite &&
//                     !Provider.of<MyData>(context, listen: false).dlete) {
//                   value = widget.repet--;
//                   ListOfKeys[index] = value - 1;
//                   removeItem();
//                 } else if (Provider.of<MyData>(context, listen: false).edite) {
//                   //###############edite Card ###################
//                   openDialogEdite(index, widget.text, widget.repet);
//                   Provider.of<MyData>(context, listen: false).mEditeF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 } else {
//                   //############### dlete Card ###################
//                   openDialogDlete(index, widget.text, widget.repet);
//
//                   Provider.of<MyData>(context, listen: false).mDleteF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 }
//               });
//             },
//             child: AbsorbPointer(
//               child: Container(
//                 constraints:
//                     BoxConstraints(minHeight: 100, minWidth: double.infinity),
//                 margin: EdgeInsets.only(bottom: 60),
//                 decoration: BoxDecoration(
//                   color: c[5],
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(15.0),
//                   ),
//                   border: Border.all(
//                     color: Provider.of<MyData>(context).red
//                         ? Colors.red
//                         : Color(0xffFFFFF4),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Provider.of<MyData>(context).red
//                           ? Color(0xffFFFFF4)
//                           : Colors.black87,
//                       blurRadius: 1,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
//                   child: Text(
//                     widget.text,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: Provider.of<MyData>(context).sizeOfText,
//                       color: c[4],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 30,
//             left: 15,
//             width: 340,
//             height: 50,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: c[6],
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(15.0),
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (!Provider.of<MyData>(context, listen: false)
//                                 .edite &&
//                             !Provider.of<MyData>(context, listen: false)
//                                 .dlete) {
//                           // shared linkes  here
//                         } else if (Provider.of<MyData>(context, listen: false)
//                             .edite) {
//                           //###############edite Card ###################
//                           openDialogEdite(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mEditeF();
//                         } else {
//                           //############### dlete Card ###################
//                           openDialogDlete(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mDleteF();
//                         }
//                       });
//                     },
//                     child: AbsorbPointer(
//                       child: Container(
//                         margin: EdgeInsets.only(left: 30, right: 30),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(5),
//                               margin: EdgeInsets.only(right: 8),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   border: Border.all(width: 2, color: c[7])),
//                               child: GestureDetector(
//                                 child: Icon(
//                                   Icons.share,
//                                   size: 20,
//                                   color: c[7],
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'مشاركه ',
//                               style: TextStyle(color: c[9], fontSize: 20),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   VerticalDivider(
//                     endIndent: 10,
//                     color: c[8],
//                     indent: 10,
//                     thickness: 1,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       int value = 0;
//                       setState(() {
//                         if (!Provider.of<MyData>(context, listen: false)
//                                 .edite &&
//                             !Provider.of<MyData>(context, listen: false)
//                                 .dlete) {
//                           value = widget.repet--;
//                           ListOfKeys[index] = value - 1;
//                           removeItem();
//                         } else if (Provider.of<MyData>(context, listen: false)
//                             .edite) {
//                           //###############edite Card ###################
//                           openDialogEdite(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mEditeF();
//                         } else {
//                           //############### dlete Card ###################
//                           openDialogDlete(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mDleteF();
//                         }
//                       });
//                     },
//                     child: AbsorbPointer(
//                       child: Container(
//                         margin: EdgeInsets.only(right: 30, left: 30),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 33.0,
//                               height: 33.0,
//                               margin: EdgeInsets.only(right: 10),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                       color: c[7],
//                                       width: 2,
//                                       style: BorderStyle.solid)),
//                               child: new RawMaterialButton(
//                                 shape: new CircleBorder(),
//                                 elevation: 0.0,
//                                 child: Text(
//                                   '${widget.repet}',
//                                   style: TextStyle(fontSize: 15, color: c[7]),
//                                 ),
//                                 onPressed: () {},
//                               ),
//                             ),
//                             Text(
//                               'التكرار ',
//                               style: TextStyle(color: c[9], fontSize: 20),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//####################################################################################################################

// class CardStyleN extends StatefulWidget {
//   int repet;
//   String text;
//   Function f;
//   Animation<double> animation;
//   List<Color> C;
//
//   CardStyleN(this.repet, this.text, this.animation, this.f, this.C);
//
//   @override
//   State<CardStyleN> createState() => _CardStyleNState();
// }
//
// class _CardStyleNState extends State<CardStyleN> {
//   late List<Color> c;
//   int index = 0;
//   String error = '';
//
//   final _controllerTextFiled = TextEditingController();
//   final _controllerTextFiled2 = TextEditingController();
//
//   bool pressed = false;
//   String? get _errorText {
//     var text = _controllerTextFiled.text;
//
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       return 'برجاء أضافه دعاء او ذكر';
//     }
//
//     // return null if the text is valid
//     return null;
//   }
//
//   String? get _errorText2 {
//     var text = _controllerTextFiled2.text;
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       error = 'برجاء أدخال رقم التكرار ';
//       return '';
//       // } else if ((text.isEmpty || text.trim().isEmpty)) {
//       //   error = 'برجاء أدخال رقم التكرار ';
//     } else if (text == '0' ||
//         text == '00' ||
//         text == '000' ||
//         text == '0000' ||
//         text == '00000' ||
//         text == '000000') {
//       error = 'يجب ان لا يقل عدد التكرار عن واحد ';
//       return '';
//     }
//     error = '';
//
//     // return null if the text is valid
//     return null;
//   }
//
//   void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
//     var keytext = boxtText.toMap().keys.firstWhere(
//         (k) => boxtText.toMap()[k] == oldtext,
//         orElse: () => 'null');
//     var keyRepet = boxRepet.toMap().keys.firstWhere(
//         (k) => boxRepet.toMap()[k] == oldRepet,
//         orElse: () => 'null');
//
//     boxtText.put(keytext, newText);
//     boxRepet.put(keyRepet, newRepet);
//   }
//
//   Future<void> Aedite_sumbit(int index) async {
//     String text = _controllerTextFiled.text;
//     String text2 = _controllerTextFiled2.text;
//     pressed = true;
//     var validate1 = _errorText;
//     var validate2 = _errorText2;
//     if (validate1 == null && validate2 == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           duration: Duration(milliseconds: 500),
//           backgroundColor: Color(0xFF76d668),
//           content: Text(
//             textAlign: TextAlign.end,
//             'تم بنجاح ',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//       );
//       setState(() {
//         //############add in list3##############
//         editAskar(widget.text, widget.repet, text, int.parse(text2));
//         ListOfKeys[index] = int.parse(text2);
//         ListOfAskar[index] = text;
//         Navigator.of(context).pop(text);
//         pressed = false;
//       });
//       widget.f();
//       // print('###########################Add############################');
//       // print(box.toMap());
//     }
//   }
//
//   Future<String?> openDialogEdite(int index, String text, int key) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 470,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'تعديل ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.plus,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       'النص ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 140,
//                                     child: TextField(
//                                       controller: _controllerTextFiled,
//                                       autofocus: false,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                         color:
//                                             Provider.of<MyData>(context).mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black,
//                                       ),
//                                       onSubmitted: (_) {},
//                                       onChanged: (text) {
//                                         setState(() {});
//                                       },
//                                       decoration: InputDecoration(
//                                         errorText: _errorText,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 4, horizontal: 4),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           gapPadding: 0.0,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                       ),
//                                       maxLines: 5,
//                                       minLines: 5,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         error,
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.red[900]),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: 75,
//                                         height: 75,
//                                         child: TextField(
//                                           controller: _controllerTextFiled2,
//                                           maxLength: 6,
//                                           autofocus: false,
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black54,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                           textAlignVertical:
//                                               TextAlignVertical.bottom,
//                                           onSubmitted: (_) {},
//                                           keyboardType: TextInputType.number,
//                                           onChanged: (text) {
//                                             setState(() {
//                                               _errorText2;
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             // labelText: 'التكرار',
//                                             hintText: 'العدد',
//                                             errorText: _errorText2,
//
//                                             contentPadding: EdgeInsets.only(
//                                                 right: 3,
//                                                 left: 3,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               gapPadding: 0.0,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                           ),
//                                           maxLines: 1,
//                                           minLines: 1,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 23,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(bottom: 25),
//                                         child: Text(
//                                           'التكرار ',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[300]
//                                                       : Colors.black54,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         // pressed = false;
//                                         Navigator.of(context).pop();
//                                         pressed = false;
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'إضافة ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Aedite_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   void DleteAskar(String text, int repet) {
//     var keytext = boxtText
//         .toMap()
//         .keys
//         .firstWhere((k) => boxtText.toMap()[k] == text, orElse: () => 'null');
//     var keyRepet = boxRepet
//         .toMap()
//         .keys
//         .firstWhere((k) => boxRepet.toMap()[k] == repet, orElse: () => 'null');
//
//     boxtText.delete(keytext);
//     boxRepet.delete(keyRepet);
//   }
//
//   Future<void> Dlete_sumbit(int index) async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(milliseconds: 500),
//         backgroundColor: Color(0xFF76d668),
//         content: Text(
//           textAlign: TextAlign.end,
//           'تم بنجاح ',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//     );
//     setState(() {
//       String text = ListOfAskar.removeAt(index);
//       int key = ListOfKeys.removeAt(index);
//       DleteAskar(widget.text, widget.repet);
//       _key.currentState!.removeItem(index, (context, animation) {
//         return SizeTransition(
//           key: ValueKey(widget.text),
//           sizeFactor: animation,
//           child: CardStyleN(key, text, animation, () {
//             setState(() {
//               ListOfAskar;
//               ListOfKeys;
//             });
//           }, widget.C),
//         );
//       }, duration: Duration(milliseconds: 450));
//
//       widget.f();
//
//       Navigator.of(context).pop(text);
//       pressed = false;
//     });
//     widget.f();
//     // print('###########################Add############################');
//     // print(box.toMap());
//   }
//
//   Future<String?> openDialogDlete(int index, String text, int repet) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 225,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'حذف ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.trashCan,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       ' !سيتم حذف الذكر ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'حذف ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Dlete_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//   @override
//   void initState() {
//     _controllerTextFiled.text = widget.text;
//     _controllerTextFiled2.text = widget.repet.toString();
//     setState(() {
//       index = ListOfAskar.indexOf(widget.text);
//     });
//     Provider.of<MyData>(context, listen: false).setSizeOfText();
//     c = widget.C;
//
//     // c0=appBarColor
//     // c1=bellowAppBarColor
//     // c2=bellowAppBarIconColor
//     // c3=bellowAppBar_NightIcon_Color
//     // c4=cardTextColor
//     // c5=cardContainerColor
//     // c6=cardPositionColor
//     // c7=cardPositionIcon
//     // c8=cardPositionLine
//     // c9=cardPositionTextColor
//
//     super.initState();
//   }
//
//   void removeItem() {
//     setState(() {
//       Provider.of<MyData>(context, listen: false).AddedNumber();
//       if (widget.repet == 0) {
//         String text = ListOfAskar.removeAt(index);
//
//         int key = ListOfKeys.removeAt(index);
//         _key.currentState!.removeItem(index, (context, animation) {
//           return SlideTransition(
//             key: ValueKey(widget.text),
//             position: animation.drive(Tween<Offset>(
//               begin: Offset(-1, 0),
//               end: Offset(0, 0),
//             )),
//             child: CardStyleN(key, text, animation, () {
//               setState(() {
//                 ListOfAskar;
//                 ListOfKeys;
//               });
//             }, widget.C),
//           );
//         }, duration: Duration(milliseconds: 450));
//
//         widget.f();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // setState(() {
//     //   setTheSizeOfText();
//     //   size;
//     // });
//
//     return SizedBox(
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           GestureDetector(
//             onTap: () {
//               int value = 0;
//               setState(() {
//                 if (!Provider.of<MyData>(context, listen: false).edite &&
//                     !Provider.of<MyData>(context, listen: false).dlete) {
//                   value = widget.repet--;
//                   ListOfKeys[index] = value - 1;
//                   removeItem();
//                 } else if (Provider.of<MyData>(context, listen: false).edite) {
//                   //###############edite Card ###################
//                   openDialogEdite(index, widget.text, widget.repet);
//                   Provider.of<MyData>(context, listen: false).mEditeF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 } else {
//                   //############### dlete Card ###################
//                   openDialogDlete(index, widget.text, widget.repet);
//
//                   Provider.of<MyData>(context, listen: false).mDleteF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 }
//               });
//             },
//             child: AbsorbPointer(
//               child: Container(
//                 constraints:
//                     BoxConstraints(minHeight: 100, minWidth: double.infinity),
//                 margin: EdgeInsets.only(bottom: 60),
//                 decoration: BoxDecoration(
//                   color: c[5],
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(15.0),
//                   ),
//                   border: Border.all(
//                     color: Provider.of<MyData>(context).red
//                         ? Colors.red
//                         : Colors.grey,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Provider.of<MyData>(context).red
//                           ? Colors.grey
//                           : Colors.grey,
//                       blurRadius: 1,
//                     )
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
//                   child: Text(
//                     widget.text,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: Provider.of<MyData>(context).sizeOfText,
//                       color: c[4],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 30,
//             left: 15,
//             width: 340,
//             height: 50,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: c[6],
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(15.0),
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (!Provider.of<MyData>(context, listen: false)
//                                 .edite &&
//                             !Provider.of<MyData>(context, listen: false)
//                                 .dlete) {
//                           // shared linkes  here
//                         } else if (Provider.of<MyData>(context, listen: false)
//                             .edite) {
//                           //###############edite Card ###################
//                           openDialogEdite(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mEditeF();
//                         } else {
//                           //############### dlete Card ###################
//                           openDialogDlete(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mDleteF();
//                         }
//                       });
//                     },
//                     child: AbsorbPointer(
//                       child: Container(
//                         margin: EdgeInsets.only(left: 30, right: 30),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(5),
//                               margin: EdgeInsets.only(right: 8),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   border: Border.all(width: 2, color: c[7])),
//                               child: GestureDetector(
//                                 child: Icon(
//                                   Icons.share,
//                                   size: 20,
//                                   color: c[7],
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               'مشاركه ',
//                               style: TextStyle(color: c[9], fontSize: 20),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   VerticalDivider(
//                     endIndent: 10,
//                     color: c[8],
//                     indent: 10,
//                     thickness: 1,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       int value = 0;
//                       setState(() {
//                         if (!Provider.of<MyData>(context, listen: false)
//                                 .edite &&
//                             !Provider.of<MyData>(context, listen: false)
//                                 .dlete) {
//                           value = widget.repet--;
//                           ListOfKeys[index] = value - 1;
//                           removeItem();
//                         } else if (Provider.of<MyData>(context, listen: false)
//                             .edite) {
//                           //###############edite Card ###################
//                           openDialogEdite(index, widget.text, widget.repet);
//                           Provider.of<MyData>(context, listen: false).mEditeF();
//                           Provider.of<MyData>(context, listen: false)
//                               .changeRed(false);
//                         } else {
//                           //############### dlete Card ###################
//                           openDialogDlete(index, widget.text, widget.repet);
//
//                           Provider.of<MyData>(context, listen: false).mDleteF();
//                           Provider.of<MyData>(context, listen: false)
//                               .changeRed(false);
//                         }
//                       });
//                     },
//                     child: AbsorbPointer(
//                       child: Container(
//                         margin: EdgeInsets.only(right: 30, left: 30),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 33.0,
//                               height: 33.0,
//                               margin: EdgeInsets.only(right: 10),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   border: Border.all(
//                                       color: c[7],
//                                       width: 2,
//                                       style: BorderStyle.solid)),
//                               child: new RawMaterialButton(
//                                 shape: new CircleBorder(),
//                                 elevation: 0.0,
//                                 child: Text(
//                                   '${widget.repet}',
//                                   style: TextStyle(fontSize: 15, color: c[7]),
//                                 ),
//                                 onPressed: () {},
//                               ),
//                             ),
//                             Text(
//                               'التكرار ',
//                               style: TextStyle(color: c[9], fontSize: 20),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CardStyleTwo extends StatefulWidget {
//   String text;
//   int repet;
//   Function f;
//   Animation<double> animation;
//   List<Color> c;
//   CardStyleTwo(this.repet, this.text, this.animation, this.f, this.c);
//
//   @override
//   State<CardStyleTwo> createState() => _CardStyleTwoState();
// }
//
// class _CardStyleTwoState extends State<CardStyleTwo> {
//   late List<Color> c;
//   int index = 0;
//   String error = '';
//
//   final _controllerTextFiled = TextEditingController();
//   final _controllerTextFiled2 = TextEditingController();
//
//   bool pressed = false;
//   String? get _errorText {
//     var text = _controllerTextFiled.text;
//
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       return 'برجاء أضافه دعاء او ذكر';
//     }
//
//     // return null if the text is valid
//     return null;
//   }
//
//   String? get _errorText2 {
//     var text = _controllerTextFiled2.text;
//     if ((text.isEmpty || text.trim().isEmpty) && pressed) {
//       error = 'برجاء أدخال رقم التكرار ';
//       return '';
//       // } else if ((text.isEmpty || text.trim().isEmpty)) {
//       //   error = 'برجاء أدخال رقم التكرار ';
//     } else if (text == '0' ||
//         text == '00' ||
//         text == '000' ||
//         text == '0000' ||
//         text == '00000' ||
//         text == '000000') {
//       error = 'يجب ان لا يقل عدد التكرار عن واحد ';
//       return '';
//     }
//     error = '';
//
//     // return null if the text is valid
//     return null;
//   }
//
//   void editAskar(String oldtext, int oldRepet, String newText, int newRepet) {
//     var keytext = boxtText.toMap().keys.firstWhere(
//         (k) => boxtText.toMap()[k] == oldtext,
//         orElse: () => 'null');
//     var keyRepet = boxRepet.toMap().keys.firstWhere(
//         (k) => boxRepet.toMap()[k] == oldRepet,
//         orElse: () => 'null');
//
//     boxtText.put(keytext, newText);
//     boxRepet.put(keyRepet, newRepet);
//   }
//
//   Future<void> Aedite_sumbit(int index) async {
//     String text = _controllerTextFiled.text;
//     String text2 = _controllerTextFiled2.text;
//     pressed = true;
//     var validate1 = _errorText;
//     var validate2 = _errorText2;
//     if (validate1 == null && validate2 == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           duration: Duration(milliseconds: 500),
//           backgroundColor: Color(0xFF76d668),
//           content: Text(
//             textAlign: TextAlign.end,
//             'تم بنجاح ',
//             style: TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//       );
//       setState(() {
//         //############add in list3##############
//         editAskar(widget.text, widget.repet, text, int.parse(text2));
//         ListOfKeys[index] = int.parse(text2);
//         ListOfAskar[index] = text;
//         Navigator.of(context).pop(text);
//         pressed = false;
//       });
//       widget.f();
//       // print('###########################Add############################');
//       // print(box.toMap());
//     }
//   }
//
//   Future<String?> openDialogEdite(int index, String text, int key) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 470,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'تعديل ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.plus,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       'النص ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 140,
//                                     child: TextField(
//                                       controller: _controllerTextFiled,
//                                       autofocus: false,
//                                       textAlign: TextAlign.end,
//                                       style: TextStyle(
//                                         fontSize: 18.0,
//                                         color:
//                                             Provider.of<MyData>(context).mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black,
//                                       ),
//                                       onSubmitted: (_) {},
//                                       onChanged: (text) {
//                                         setState(() {});
//                                       },
//                                       decoration: InputDecoration(
//                                         errorText: _errorText,
//                                         contentPadding: EdgeInsets.symmetric(
//                                             vertical: 4, horizontal: 4),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         border: OutlineInputBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           gapPadding: 0.0,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           borderSide: BorderSide(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               width: 1),
//                                         ),
//                                       ),
//                                       maxLines: 5,
//                                       minLines: 5,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 25,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         error,
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.red[900]),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.center,
//                                         width: 75,
//                                         height: 75,
//                                         child: TextField(
//                                           controller: _controllerTextFiled2,
//                                           maxLength: 6,
//                                           autofocus: false,
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             color: Provider.of<MyData>(context)
//                                                         .mode ==
//                                                     'N'
//                                                 ? Colors.grey[300]
//                                                 : Colors.black54,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                           textAlignVertical:
//                                               TextAlignVertical.bottom,
//                                           onSubmitted: (_) {},
//                                           keyboardType: TextInputType.number,
//                                           onChanged: (text) {
//                                             setState(() {
//                                               _errorText2;
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             // labelText: 'التكرار',
//                                             hintText: 'العدد',
//                                             errorText: _errorText2,
//
//                                             contentPadding: EdgeInsets.only(
//                                                 right: 3,
//                                                 left: 3,
//                                                 top: 10,
//                                                 bottom: 10),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               gapPadding: 0.0,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               borderSide: BorderSide(
//                                                   color: Provider.of<MyData>(
//                                                                   context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                                   width: 1),
//                                             ),
//                                           ),
//                                           maxLines: 1,
//                                           minLines: 1,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 23,
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(bottom: 25),
//                                         child: Text(
//                                           'التكرار ',
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[300]
//                                                       : Colors.black54,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         // pressed = false;
//                                         Navigator.of(context).pop();
//                                         pressed = false;
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'إضافة ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Aedite_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//
//   void DleteAskar(String text, int repet) {
//     var keytext = boxtText
//         .toMap()
//         .keys
//         .firstWhere((k) => boxtText.toMap()[k] == text, orElse: () => 'null');
//     var keyRepet = boxRepet
//         .toMap()
//         .keys
//         .firstWhere((k) => boxRepet.toMap()[k] == repet, orElse: () => 'null');
//
//     boxtText.delete(keytext);
//     boxRepet.delete(keyRepet);
//   }
//
//   Future<void> Dlete_sumbit(int index) async {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         duration: Duration(milliseconds: 500),
//         backgroundColor: Color(0xFF76d668),
//         content: Text(
//           textAlign: TextAlign.end,
//           'تم بنجاح ',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ),
//     );
//     setState(() {
//       String text = ListOfAskar.removeAt(index);
//       int key = ListOfKeys.removeAt(index);
//       DleteAskar(widget.text, widget.repet);
//       _key.currentState!.removeItem(index, (context, animation) {
//         return SizeTransition(
//           key: ValueKey(widget.text),
//           sizeFactor: animation,
//           child: CardStyleTwo(key, text, animation, () {
//             setState(() {
//               ListOfAskar;
//               ListOfKeys;
//             });
//           }, widget.c),
//         );
//       }, duration: Duration(milliseconds: 450));
//
//       widget.f();
//
//       Navigator.of(context).pop(text);
//       pressed = false;
//     });
//     widget.f();
//     // print('###########################Add############################');
//     // print(box.toMap());
//   }
//
//   Future<String?> openDialogDlete(int index, String text, int repet) =>
//       showDialog<String>(
//         context: context,
//         builder: (context) => StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.all(20),
//               contentPadding: EdgeInsets.all(0),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.0),
//                 ),
//               ),
//               content: Container(
//                 height: 225,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Provider.of<MyData>(context).mode == 'N'
//                       ? Color(0xff503385)
//                       : Color(0xFF76d668),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             'حذف ذكر / دعاء',
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Colors.grey[300]
//                                     : Colors.white),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(left: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: GestureDetector(
//                               child: FaIcon(
//                                 FontAwesomeIcons.trashCan,
//                                 size: 15,
//                                 color: Provider.of<MyData>(context).mode == 'N'
//                                     ? Color(0xff503385)
//                                     : Color(0xFF76d668),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color:
//                               Provider.of<MyData>(context).menuItemBackground,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     margin:
//                                         EdgeInsets.only(top: 20, bottom: 20),
//                                     child: Text(
//                                       ' !سيتم حذف الذكر ',
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Colors.grey[300]
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin:
//                                   EdgeInsets.only(left: 5, right: 5, top: 8),
//                               child: Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                     child: InkResponse(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                               .menuItemBackground,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                           border: Border.all(
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'رجوع ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.white
//                                                       : Colors.grey,
//                                               fontSize: 18,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Navigator.of(context).pop();
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 25,
//                                   ),
//                                   Expanded(
//                                     child: TextButton(
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 8, horizontal: 9),
//                                         margin: EdgeInsets.only(
//                                             top: 10, bottom: 10),
//                                         decoration: BoxDecoration(
//                                           color: Provider.of<MyData>(context)
//                                                       .mode ==
//                                                   'N'
//                                               ? Color(0xff880ED4)
//                                               : Color(0xFF76d668),
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(10.0),
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             'حذف ',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color:
//                                                   Provider.of<MyData>(context)
//                                                               .mode ==
//                                                           'N'
//                                                       ? Colors.grey[200]
//                                                       : Colors.white,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           Dlete_sumbit(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//   @override
//   void initState() {
//     _controllerTextFiled.text = widget.text;
//     _controllerTextFiled2.text = widget.repet.toString();
//     setState(() {
//       index = ListOfAskar.indexOf(widget.text);
//     });
//     Provider.of<MyData>(context, listen: false).setSizeOfText();
//
//     c = widget.c;
//
//     super.initState();
//   }
//
//   void removeItem() {
//     setState(() {
//       Provider.of<MyData>(context, listen: false).AddedNumber();
//       if (widget.repet == 0) {
//         String text = ListOfAskar.removeAt(index);
//
//         int key = ListOfKeys.removeAt(index);
//         _key.currentState!.removeItem(index, (context, animation) {
//           return SlideTransition(
//             key: ValueKey(widget.text),
//             position: animation.drive(Tween<Offset>(
//               begin: Offset(-1, 0),
//               end: Offset(0, 0),
//             )),
//             child: CardStyleTwo(key, text, animation, () {
//               setState(() {
//                 ListOfAskar;
//                 ListOfKeys;
//               });
//             }, widget.c),
//           );
//         }, duration: Duration(milliseconds: 450));
//
//         widget.f();
//       }
//     });
//   }
//
//   // c0  bigContainer and bottonContainer and iconColor
// // c1   container of text fill
// // c2 shadow of textContainer
// // c3 text of container
// // c4 Icon Cirecl fill color
// // c5  text in icons container
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 35),
//       decoration: BoxDecoration(
//         color: c[0],
//         // border: Border.all(
//         //   color: Provider.of<MyData>(context).red ? Colors.red : c[0],
//         // ),
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: Provider.of<MyData>(context).red ? Colors.red : c[0],
//         //     blurRadius: 1,
//         //   )
//         // ],
//         borderRadius: BorderRadius.all(Radius.circular(20.0)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           GestureDetector(
//             onTap: () {
//               int value = 0;
//               setState(() {
//                 if (!Provider.of<MyData>(context, listen: false).edite &&
//                     !Provider.of<MyData>(context, listen: false).dlete) {
//                   value = widget.repet--;
//                   ListOfKeys[index] = value - 1;
//                   removeItem();
//                 } else if (Provider.of<MyData>(context, listen: false).edite) {
//                   //###############edite Card ###################
//                   openDialogEdite(index, widget.text, widget.repet);
//                   Provider.of<MyData>(context, listen: false).mEditeF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 } else {
//                   //############### dlete Card ###################
//                   openDialogDlete(index, widget.text, widget.repet);
//
//                   Provider.of<MyData>(context, listen: false).mDleteF();
//                   Provider.of<MyData>(context, listen: false).changeRed(false);
//                 }
//               });
//             },
//             child: AbsorbPointer(
//               child: Container(
//                   constraints:
//                       BoxConstraints(minHeight: 100, minWidth: double.infinity),
//                   decoration: BoxDecoration(
//                     color: c[1],
//                     boxShadow: [
//                       BoxShadow(
//                         color: Provider.of<MyData>(context).red
//                             ? Colors.red
//                             : c[2],
//                         blurRadius: 2,
//                       )
//                     ],
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15.0),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
//                     child: Text(
//                       widget.text,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Provider.of<MyData>(context).sizeOfText,
//                         color: c[3],
//                       ),
//                     ),
//                   )),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 8.0),
//             alignment: Alignment.bottomCenter,
//             height: 48,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: c[0],
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(15.0),
//                   bottomLeft: Radius.circular(15.0)),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       if (!Provider.of<MyData>(context, listen: false).edite &&
//                           !Provider.of<MyData>(context, listen: false).dlete) {
//                         // shared linkes  here
//                       } else if (Provider.of<MyData>(context, listen: false)
//                           .edite) {
//                         //###############edite Card ###################
//                         openDialogEdite(index, widget.text, widget.repet);
//                         Provider.of<MyData>(context, listen: false).mEditeF();
//                       } else {
//                         //############### dlete Card ###################
//                         openDialogDlete(index, widget.text, widget.repet);
//                         Provider.of<MyData>(context, listen: false).mDleteF();
//                       }
//                     });
//                   },
//                   child: AbsorbPointer(
//                     child: Container(
//                       margin: EdgeInsets.only(left: 40, right: 40),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.all(5),
//                             margin: EdgeInsets.only(right: 8),
//                             decoration: BoxDecoration(
//                               color: c[4],
//                               borderRadius: BorderRadius.circular(100),
//                               border: Border.all(
//                                 width: 1,
//                                 color: c[0],
//                               ),
//                             ),
//                             child: GestureDetector(
//                               child: Icon(
//                                 Icons.share,
//                                 size: 18,
//                                 color: c[0],
//                               ),
//                             ),
//                           ),
//                           Text(
//                             'مشاركه ',
//                             style: TextStyle(color: c[5], fontSize: 18),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     int value = 0;
//                     setState(() {
//                       if (!Provider.of<MyData>(context, listen: false).edite &&
//                           !Provider.of<MyData>(context, listen: false).dlete) {
//                         value = widget.repet--;
//                         ListOfKeys[index] = value - 1;
//                         removeItem();
//                       } else if (Provider.of<MyData>(context, listen: false)
//                           .edite) {
//                         //###############edite Card ###################
//                         openDialogEdite(index, widget.text, widget.repet);
//                         Provider.of<MyData>(context, listen: false).mEditeF();
//                         Provider.of<MyData>(context, listen: false)
//                             .changeRed(false);
//                       } else {
//                         //############### dlete Card ###################
//                         openDialogDlete(index, widget.text, widget.repet);
//
//                         Provider.of<MyData>(context, listen: false).mDleteF();
//                         Provider.of<MyData>(context, listen: false)
//                             .changeRed(false);
//                       }
//                     });
//                   },
//                   child: AbsorbPointer(
//                     child: Container(
//                       margin: EdgeInsets.only(right: 40, left: 40),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 31.0,
//                             height: 31.0,
//                             margin: EdgeInsets.only(right: 10),
//                             decoration: BoxDecoration(
//                                 color: c[4],
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     color: c[0],
//                                     width: 1,
//                                     style: BorderStyle.solid)),
//                             child: new RawMaterialButton(
//                               shape: new CircleBorder(),
//                               elevation: 0.0,
//                               child: Text(
//                                 '${widget.repet}',
//                                 style: TextStyle(fontSize: 15, color: c[0]),
//                               ),
//                               onPressed: () {},
//                             ),
//                           ),
//                           Text(
//                             'التكرار ',
//                             style: TextStyle(color: c[5], fontSize: 18),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// ListView(
// controller: _controller,
// children: [
// Container(
// height: 80.0,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[Color(0xff85abd6), Color(0xff7aa7d8)],
// ),
// ),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// icon: Icon(
// Icons.arrow_back,
// size: 30.0,
// color: Colors.white,
// ),
// ),
// Container(
// alignment: Alignment.center,
// child: Image.asset(
// 'images/icons8-sun-48.png',
// height: 30,
// width: 30,
// ),
// ),
// Container(
// alignment: Alignment.center,
// margin: EdgeInsets.only(right: 40, left: 80),
// child: Text(
// 'اذكار الصباح',
// style: TextStyle(
// color: Colors.white70,
// fontSize: 25.0,
// fontWeight: FontWeight.bold),
// ),
// ),
// ],
// ),
// ),
// Container(
// child: ListView(
// physics: NeverScrollableScrollPhysics(),
// children: [
// Container(
// height: 830,
// width: double.infinity,
// color: Colors.yellow,
// )
// ],
// ),
// )
// ],
// ))
//

// NestedScrollView(
// headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
// SliverAppBar(
// pinned: false,
// expandedHeight: 70.0,
// flexibleSpace: Container(
// height: 20,
// color: Colors.red,
// ),
// elevation: 0.0,
// leading: IconButton(
// icon: Icon(
// Icons.arrow_back,
// size: 30.0,
// color: Colors.white,
// ),
// onPressed: () {
// Navigator.pop(context);
// },
// ),
// ),
// ],
// body: CustomScrollView(
// slivers: [
// SliverList(
// delegate: SliverChildBuilderDelegate(
// (context, index) => Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// ),
// )
// ],
// ))),

// children: [
// Container(
// height: 80.0,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[Color(0xff85abd6), Color(0xff7aa7d8)],
// ),
// ),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// icon: Icon(
// Icons.arrow_back,
// size: 30.0,
// color: Colors.white,
// ),
// ),
// Container(
// alignment: Alignment.center,
// child: Image.asset(
// 'images/icons8-sun-48.png',
// height: 30,
// width: 30,
// ),
// ),
// Container(
// alignment: Alignment.center,
// margin: EdgeInsets.only(right: 40, left: 80),
// child: Text(
// 'اذكار الصباح',
// style: TextStyle(
// color: Colors.white70,
// fontSize: 25.0,
// fontWeight: FontWeight.bold),
// ),
// ),
// ],
// ),
// ),
// Container(
// height: 50,
// color: Color(0xffe0e0e0),
// ),

// SingleChildScrollView(
// physics: ScrollPhysics(),
// child: Column(
// children: [
// Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// Column(
// children: [
// SizedBox(
// height: 120.0,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-sun-48.png',
// 'ورد الصباح ',
// Color(0xffffd179),
// Color(0xfffebd3d)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-ramadan-32.png',
// 'ورد المساء ',
// Color(0xffc8b4eb),
// Color(0xff8964ce),
// ),
// ),
// ],
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Expanded(
// child: MiniCardHome(
// 'images/icons8-tasbih-66.png',
// 'تسبيح  ',
// Color(0xff85abd6),
// Color(0xff7aa7d8)),
// ),
// Expanded(
// child: MiniCardHome(
// 'images/icons8-paint-50.png',
// 'تغير الشكل  ',
// Color(0xff3ac8dc),
// Color(0xff5494e3)),
// ),
// ],
// ),
// ],
// ),
// ],
// ),
// )
// ],
// )
//
//

// Container(
// height: 20.0,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[Color(0xff85abd6), Color(0xff7aa7d8)],
// ),
// ),
// ),

// CustomScrollView(
// slivers: [
// SliverAppBar(
// pinned: false,
// expandedHeight: 70.0,
// elevation: 0.0,
// leading: IconButton(
// onPressed: () {
// Navigator.pop(context);
// },
// alignment: Alignment.topLeft,
// icon: Icon(
// Icons.arrow_back,
// size: 30.0,
// color: Colors.white,
// ),
// ),
// flexibleSpace: Container(
// decoration: BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[Color(0xff85abd6), Color(0xff7aa7d8)],
// ),
// ),
// child: FlexibleSpaceBar(
// centerTitle: true,
// titlePadding:
// EdgeInsets.only(right: 40, bottom: 10, top: 10),
// expandedTitleScale: 1,
// title: Align(
// child: Text(
// 'أذكار الصباح ',
// style: TextStyle(
// fontSize: 25,
// color: Colors.white70,
// fontWeight: FontWeight.bold),
// ),
// alignment: Alignment.bottomRight,
// ),
// ),
// ),
// ),
// SliverList(
// delegate: SliverChildBuilderDelegate(
// (context, index) => Container(
// child: Text('morning'),
// ),
// ),
// ),
// ],
// ),
