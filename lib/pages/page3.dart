import 'package:flutter/material.dart';
import 'package:test_local_notification1/component.dart';
import 'package:test_local_notification1/main.dart';

class AppBar3Page extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ),
              (route) => false);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30.0,
          color: Colors.white,
        ),
      ),
      title: Align(
        child: CustomText('صدقه جارية ', 20.0, Colors.white),
        alignment: Alignment.centerRight,
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Image.asset(
            'images/love.png',
            width: 30.0,
            height: 30.0,
          ),
        )
      ],
      backgroundColor: Color(0xFF76d668),
    );
  }
}

class Page3 extends StatefulWidget {
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF76d668),
                border: Border.all(
                  width: 0,
                  color: Color(0xFF76d668),
                ),
              ),
              height: 300.0,
              child: Column(
                children: [
                  Text(
                    'صدقه جارية',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'شارك التطبيق لمن تعرف الان ليصبح "صدقه جاريه" خاصه بك بحيث يتناقله الاف الناس من بعدك',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Column(
                children: [
                  CardPage3('شارك مع واتس اب', 'images/icons8-whatsapp-96.png',
                      Colors.green),
                  CardPage3('نسخ الرابط للمشاركه', 'images/icons8-copy-50.png',
                      Colors.grey),
                  CardPage3('شارك مع فيسبوك', 'images/icons8-facebook-f-50.png',
                      Colors.blueAccent),
                  CardPage3('شارك مع تويتر', 'images/icons8-twitter-80.png',
                      Color(0xff1DA1F2)),
                ],
              ),
              top: 280,
            ),
          ],
        ),
      ],
    );
  }
}

class CardPage3 extends StatelessWidget {
  String title;
  String assestPath;
  Color couler;

  CardPage3(this.title, this.assestPath, this.couler);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      height: 60.0,
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            title,
            25,
            couler,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25.0),
            child: Image.asset(assestPath),
          )
        ],
      ),
    );
  }
}
