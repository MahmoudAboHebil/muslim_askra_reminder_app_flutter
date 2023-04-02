import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// var box = Hive.box('askarPage1');

List<String> askar = [
  'الحمد لله',
  'سبحان الله',
  'الله اكبر',
  'استغفر الله',
  'أستغفر الله العظيم الذي لا إله إلا هو الحي القيوم وأتوب إليه',
  'اشهد ان لا اله الا الله واشهد ان محمدا عبده ورسوله',
  'اللهم استرنا فوق الارض وتحت الارض ويوم العرض عليك',
  'اللهم اسلمت نفسي اليك ووجهت وجهي اليك وفوضت امري اليك',
  'اللهم اعنا على ذكرك وشكرك وحسن عبادتك',
  'اللهم انى اسالك علما نافعا ورزقا طيبا وعملا متقبلا',
  'اللهم انك عفو كريم تحب العفو فاعف عني',
  'اللهم صل وسلم وبارك على سيدنا محمد',
  'اللهم قنى عذابك يوم تبعث عبادك',
  'اللهم اني اسالك الهدى والتقى والعفاف والغنى',
  'ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار',
];

class BodyOfaskar_2_Page1 extends StatefulWidget {
  @override
  State<BodyOfaskar_2_Page1> createState() => _BodyOfaskar_2_Page1State();
}

class _BodyOfaskar_2_Page1State extends State<BodyOfaskar_2_Page1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: SizedBox(
        height: 650,
        child: StatefulBuilder(
          builder: (context, setState) {
            setState(() {});
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RecatangleBodyOfAskary_2_Page1(askar[index]);
              },
              itemCount: askar.length,
            );
          },
        ),
      ),
    );
  }
}

class RecatangleBodyOfAskary_2_Page1 extends StatefulWidget {
  String title;

  RecatangleBodyOfAskary_2_Page1(this.title);

  @override
  State<RecatangleBodyOfAskary_2_Page1> createState() =>
      _RecatangleBodyOfAskary_2_Page1State();
}

class _RecatangleBodyOfAskary_2_Page1State
    extends State<RecatangleBodyOfAskary_2_Page1> {
  var checkBoxValue;
  void setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        checkBoxValue = prefs.get(widget.title) ?? false;
      });
    }

    // setState(() {
    //   checkBoxValue = box.toMap()[widget.title] ?? false;
    // });
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  bool t = false;
  @override
  Widget build(BuildContext context) {
    setData();
    //
    // if(checkBoxValue==null){
    //   t=false;
    // }else{
    //   t=checkBoxValue;
    // }
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      constraints: BoxConstraints(minHeight: 80, minWidth: double.infinity),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StatefulBuilder(
            builder: (context, setState) => Checkbox(
              tristate: true,
              checkColor: Colors.white,
              fillColor: MaterialStateColor.resolveWith(
                (states) =>
                    (checkBoxValue ?? false) ? Color(0xFF76d668) : Colors.grey,
              ),
              value: checkBoxValue,
              onChanged: (bool? value) async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                bool v = value ?? false;
                prefs.setBool(widget.title, v);

                // setState(
                //   () {
                //     box.put(widget.title, value);
                //     setData();
                //   },
                // );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20,
                  color: t ? Color(0xFF76d668) : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
