import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_local_notification1/providerAskarBrain.dart';
import 'providerAskarBrain.dart';
import 'package:workmanager/workmanager.dart';
import 'package:provider/provider.dart';
import 'main.dart';

// List<String> askar = [
//   'الحمد لله',
//   'سبحان الله',
//   'الله اكبر',
//   'استغفر الله',
//   'أستغفر الله العظيم الذي لا إله إلا هو الحي القيوم وأتوب إليه',
//   'اشهد ان لا اله الا الله واشهد ان محمدا عبده ورسوله',
//   'اللهم استرنا فوق الارض وتحت الارض ويوم العرض عليك',
//   'اللهم اسلمت نفسي اليك ووجهت وجهي اليك وفوضت امري اليك',
//   'اللهم اعنا على ذكرك وشكرك وحسن عبادتك',
//   'اللهم انى اسالك علما نافعا ورزقا طيبا وعملا متقبلا',
//   'اللهم انك عفو كريم تحب العفو فاعف عني',
//   'اللهم صل وسلم وبارك على سيدنا محمد',
//   'اللهم قنى عذابك يوم تبعث عبادك',
//   'اللهم اني اسالك الهدى والتقى والعفاف والغنى',
//   'ربنا آتنا في الدنيا حسنة وفي الآخرة حسنة وقنا عذاب النار',
// ];

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future showNotification(List<String> allList) async {
  int rndmIndex = Random().nextInt(allList.length - 1);
  String defuled = allList.isEmpty
      ? 'سبحان الله , هذا اول اشعار لك , مرحبا بك '
      : allList[rndmIndex];

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    '$rndmIndex.0',
    'حصن المسلم',
    channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    rndmIndex,
    'فَذَكِّرْ',
    defuled,
    platformChannelSpecifics,
  );
}

void cancelWorkmanage(String uniqueName) {
  Workmanager().cancelByUniqueName(uniqueName);
}

void cal(List<String> allList) {
  // initial notifications
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) {
    showNotification(allList);
    return Future.value(true);
  });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Workmanager().initialize(
      cal,
      isInDebugMode: false,
    );
    // Future.delayed(Duration(milliseconds: 100), () {
    //   Provider.of<MyData>(context, listen: false).setAllAskar();
    //   List<String> allList =
    //       Provider.of<MyData>(context, listen: false).allAskar;
    //
    //
    // });

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash',
          style: TextStyle(fontSize: 70),
        ),
      ),
    );
  }
}
