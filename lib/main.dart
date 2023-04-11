import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_local_notification1/splashScreen.dart';
import 'pages/page2.dart';
import 'pages/page1.dart';
import 'pages/page3.dart';
import 'pages/firstPage.dart';
import 'constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pages/askar_Page.dart';
import 'package:provider/provider.dart';
import 'providerAskarBrain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import 'package:shared_preferences_foundation/shared_preferences_foundation.dart';

final FlutterLocalNotificationsPlugin _notifications =
    FlutterLocalNotificationsPlugin();

// Future showNotification() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appDocumentDirectory = await getApplicationDocumentsDirectory();
//   WidgetsFlutterBinding.ensureInitialized();
//   Hive.init(appDocumentDirectory.path);
//   await Hive.openBox('askarPage1');
//   await Hive.openBox('addAskarPage1');
//   List<String> allList = ['test1', 'test2', 'test3', 'test4'];
//   var box1 = Hive.box('addAskarPage1');
//   var box2 = Hive.box('askarPage1');
//
//   Map map1 = box1.toMap();
//   for (final mapEntry in map1.entries) {
//     var key = mapEntry.key;
//     var value = mapEntry.value;
//     allList.add(value);
//   }
//   Map map2 = box2.toMap();
//   for (final mapEntry in map2.entries) {
//     var key = mapEntry.key;
//     allList.add(key);
//   }
//
//   int rndmIndex = Random().nextInt(allList.length - 1);
//
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     '$rndmIndex.0',
//     'تطبيق المسلم',
//     channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
//     importance: Importance.max,
//     priority: Priority.high,
//     playSound: true,
//     enableVibration: true,
//   );
//   var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
//     threadIdentifier: 'thread_id',
//   );
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);
//
//   print('##########################################');
//   print(allList);
//   await flutterLocalNotificationsPlugin.show(
//     rndmIndex,
//     'فَذَكِّرْ',
//     allList[rndmIndex],
//     platformChannelSpecifics,
//   );
//
//   /// periodically...but const id && const title,body
//   /*await flutterLocalNotificationsPlugin.periodicallyShow(
//     Random().nextInt(azkar.length-1),
//     'السلام عليكم',
//     azkar[Random().nextInt(azkar.length-1)],
//     RepeatInterval.everyMinute,
//     platformChannelSpecifics,
//     androidAllowWhileIdle: true,
//     payload: '',
//   );*/
// }
//
// void callbackDispatcher() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final appDocumentDirectory = await getApplicationDocumentsDirectory();
//   WidgetsFlutterBinding.ensureInitialized();
//   Hive.init(appDocumentDirectory.path);
//   await Hive.openBox('askarPage1');
//   await Hive.openBox('addAskarPage1');
//   var initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   var initializationSettingsIOS = DarwinInitializationSettings();
//
//   var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//   );
//
//   Workmanager().executeTask((task, inputData) {
//     showNotification();
//     return Future.value(true);
//   });
// }
Future showNotification(String text, bool fifteen) async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final appDocumentDirectory = await getApplicationDocumentsDirectory();
  // WidgetsFlutterBinding.ensureInitialized();
  // Hive.init(appDocumentDirectory.path);
  // await Hive.openBox('askarPage1');
  // await Hive.openBox('addAskarPage1');
  // List<String> allList = ['test1', 'test2', 'test3', 'test4'];
  // var box1 = Hive.box('addAskarPage1');
  // var box2 = Hive.box('askarPage1');
  //
  // Map map1 = box1.toMap();
  // for (final mapEntry in map1.entries) {
  //   var key = mapEntry.key;
  //   var value = mapEntry.value;
  //   allList.add(value);
  // }
  // Map map2 = box2.toMap();
  // for (final mapEntry in map2.entries) {
  //   var key = mapEntry.key;
  //   allList.add(key);
  // }
  // await Hive.box('addAskarPage1').close();
  // await Hive.box('askarPage1').close();

  // int rndmIndex = Random().nextInt(allList.length - 1);

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('hellow', 'تطبيق المسلم',
          channelDescription: 'تطبيق اذكار وادعية وتلاوة وقراءة القرءان الكريم',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          autoCancel: true,
          timeoutAfter: fifteen ? 15000 : null);
  var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await _notifications.show(
    0,
    'فَذَكِّرْ',
    text,
    platformChannelSpecifics,
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  // initial notifications
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = DarwinInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  WidgetsFlutterBinding.ensureInitialized();

  _notifications.initialize(
    initializationSettings,
  );

  Workmanager().executeTask((task, inputData) async {
    if (Platform.isAndroid) SharedPreferencesAndroid.registerWith();
    if (Platform.isIOS) SharedPreferencesFoundation.registerWith();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? allAskar = [];
    if (prefs.getStringList('addAskarPage1') == null &&
        prefs.getBool('الحمد لله') == null) {
      allAskar = [
        'أهلا وسهلا ومرحبا بكم',
        'أهلا وسهلا ومرحبا بكم',
        'أهلا وسهلا ومرحبا بكم',
      ];
    } else {
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
      var m = prefs.getStringList('addAskarPage1');
      bool? n = m?.isEmpty;
      if (n != null) {
        allAskar = (n || m == null) ? ['لاحول ولا قوة الا بالله'] : m;
      } else {
        allAskar = m == null ? ['لاحول ولا قوة الا بالله'] : m;
      }

      for (int i = 0; i < askar.length; i++) {
        String x = askar[i];
        bool? b = prefs.getBool(x) ?? false;
        if (b) {
          allAskar.add(x);
        }
      }
    }

    bool mode_15 = prefs.getBool('mode15') ?? true;
    if (allAskar.length == 1 || allAskar.isEmpty) {
      allAskar.add('لاحول ولا قوة الا بالله');
    }
    int rndmIndex = Random().nextInt(allAskar.length - 1);
    String text = allAskar[rndmIndex];

    showNotification(text, mode_15);

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  WidgetsFlutterBinding.ensureInitialized();
  Noti.init(initScheduled: true);
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Hive.initFlutter();
  await Hive.openBox('askarPage1');
  await Hive.openBox('addAskarPage1');
  await Hive.openBox('total_number_uget');
  await Hive.openBox('askar_custom');
  // 'size' key  for decrease or increase
  // 'mode' key for mode
  // 'nConst' key for nConst
  await Hive.openBox('tsbeh_custom');
  // 'count' key for the counter number
  // 'Night' for night mode
  // 'Vibrate'
  // 'Sound'
  // 'CardNumber'

  await Hive.openBox('askar_morning_text');
  await Hive.openBox('askar_morning_repet');

  await Hive.openBox('askar_night_text');
  await Hive.openBox('askar_night_repet');

  await Hive.openBox('askar_mosque_text');
  await Hive.openBox('askar_mosque_repet');

  await Hive.openBox('askar_gettingUp_text');
  await Hive.openBox('askar_gettingUp_repet');

  await Hive.openBox('askar_sleeping_text');
  await Hive.openBox('askar_sleeping_repet');

  await Hive.openBox('askar_pray_text');
  await Hive.openBox('askar_pray_repet');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyData>(
      create: (context) => MyData(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/splashScreen': (context) => SplashScreen(),
          // '/calcPage': (context) => calcPage(),
          // '/morningPage': (context) => Morning(),
          '/page2': (context) => Page2(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static var box1 = Hive.box('addAskarPage1');
  // static var box2 = Hive.box('askarPage1');
  // static List<String> collectAllAskar() {
  //   List<String> smallDo3a2 = [];
  //   smallDo3a2.clear();
  //   Map map1 = box1.toMap();
  //   for (final map1Entry in map1.entries) {
  //     var value = map1Entry.value;
  //     smallDo3a2.add(value);
  //   }
  //   Map map2 = box2.toMap();
  //   for (final map2Entry in map2.entries) {
  //     var key = map2Entry.key;
  //     smallDo3a2.add(key);
  //   }
  //   return smallDo3a2;
  // }

  void listenNotifications() {
    Noti.onNotifications.stream.listen((payload) {
      if (payload == 1) {
        //اذكار الصباح
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AskarPage(
            'أذكارالصباح ',
            Hive.box('askar_morning_text'),
            Hive.box('askar_morning_repet'),
            [
              '  اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
              'قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ',
              'قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
              'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ',
              'أَصْـبَحْنا وَأَصْـبَحَ المُـلْكُ لله وَالحَمدُ لله ، لا إلهَ إلاّ اللّهُ وَحدَهُ لا شَريكَ لهُ، لهُ المُـلكُ ولهُ الحَمْـد، وهُوَ على كلّ شَيءٍ قدير ، رَبِّ أسْـأَلُـكَ خَـيرَ ما في هـذا اليوم وَخَـيرَ ما بَعْـدَه ، وَأَعـوذُ بِكَ مِنْ شَـرِّ ما في هـذا اليوم وَشَرِّ ما بَعْـدَه، رَبِّ أَعـوذُبِكَ مِنَ الْكَسَـلِ وَسـوءِ الْكِـبَر ، رَبِّ أَعـوذُ بِكَ مِنْ عَـذابٍ في النّـارِ وَعَـذابٍ في القَـبْر',
              'اللّهـمَّ أَنْتَ رَبِّـي لا إلهَ إلاّ أَنْتَ ، خَلَقْتَنـي وَأَنا عَبْـدُك ، وَأَنا عَلـى عَهْـدِكَ وَوَعْـدِكَ ما اسْتَـطَعْـت ، أَعـوذُبِكَ مِنْ شَـرِّ ما صَنَـعْت ، أَبـوءُ لَـكَ بِنِعْـمَتِـكَ عَلَـيَّ وَأَبـوءُ بِذَنْـبي فَاغْفـِرْ لي فَإِنَّـهُ لا يَغْـفِرُ الذُّنـوبَ إِلاّ أَنْتَ',
              'رَضيـتُ بِاللهِ رَبَّـاً وَبِالإسْلامِ ديـناً وَبِمُحَـمَّدٍ صلى الله عليه وسلم نَبِيّـاً',
              'اللّهُـمَّ إِنِّـي أَصْبَـحْتُ أُشْـهِدُك ، وَأُشْـهِدُ حَمَلَـةَ عَـرْشِـك ، وَمَلَائِكَتَكَ ، وَجَمـيعَ خَلْـقِك ، أَنَّـكَ أَنْـتَ اللهُ لا إلهَ إلاّ أَنْـتَ وَحْـدَكَ لا شَريكَ لَـك ، وَأَنَّ ُ مُحَمّـداً عَبْـدُكَ وَرَسـولُـك',
              'اللّهُـمَّ ما أَصْبَـَحَ بي مِـنْ نِعْـمَةٍ أَو بِأَحَـدٍ مِـنْ خَلْـقِك ، فَمِـنْكَ وَحْـدَكَ لا شريكَ لَـك ، فَلَـكَ الْحَمْـدُ وَلَـكَ الشُّكْـر',
              'حَسْبِـيَ اللّهُ لا إلهَ إلاّ هُوَ عَلَـيهِ تَوَكَّـلتُ وَهُوَ رَبُّ العَرْشِ العَظـيم',
              'بِسـمِ اللهِ الذي لا يَضُـرُّ مَعَ اسمِـهِ شَيءٌ في الأرْضِ وَلا في السّمـاءِ وَهـوَ السّمـيعُ العَلـيم',
              'اللّهُـمَّ بِكَ أَصْـبَحْنا وَبِكَ أَمْسَـينا ، وَبِكَ نَحْـيا وَبِكَ نَمُـوتُ وَإِلَـيْكَ النُّـشُور',
              'أَصْبَـحْـنا عَلَى فِطْرَةِ الإسْلاَمِ، وَعَلَى كَلِمَةِ الإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ، وَعَلَى مِلَّةِ أَبِينَا إبْرَاهِيمَ حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ المُشْرِكِينَ',
              'سُبْحـانَ اللهِ وَبِحَمْـدِهِ عَدَدَ خَلْـقِه ، وَرِضـا نَفْسِـه ، وَزِنَـةَ عَـرْشِـه ، وَمِـدادَ كَلِمـاتِـه',
              'اللّهُـمَّ عافِـني في بَدَنـي ، اللّهُـمَّ عافِـني في سَمْـعي ، اللّهُـمَّ عافِـني في بَصَـري ، لا إلهَ إلاّ أَنْـتَ',
              'اللّهُـمَّ إِنّـي أَعـوذُ بِكَ مِنَ الْكُـفر ، وَالفَـقْر ، وَأَعـوذُ بِكَ مِنْ عَذابِ القَـبْر ، لا إلهَ إلاّ أَنْـتَ',
              'اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في الدُّنْـيا وَالآخِـرَة ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ العَـفْوَ وَالعـافِـيةَ في ديني وَدُنْـيايَ وَأهْـلي وَمالـي ، اللّهُـمَّ اسْتُـرْ عـوْراتي وَآمِـنْ رَوْعاتـي ، اللّهُـمَّ احْفَظْـني مِن بَـينِ يَدَيَّ وَمِن خَلْفـي وَعَن يَمـيني وَعَن شِمـالي ، وَمِن فَوْقـي ، وَأَعـوذُ بِعَظَمَـتِكَ أَن أُغْـتالَ مِن تَحْتـي',
              'يَا حَيُّ يَا قيُّومُ بِرَحْمَتِكَ أسْتَغِيثُ أصْلِحْ لِي شَأنِي كُلَّهُ وَلاَ تَكِلْنِي إلَى نَفْسِي طَـرْفَةَ عَيْنٍ',
              'أَصْبَـحْـنا وَأَصْبَـحْ المُـلكُ للهِ رَبِّ العـالَمـين ، اللّهُـمَّ إِنِّـي أسْـأَلُـكَ خَـيْرَ هـذا الـيَوْم ، فَـتْحَهُ ، وَنَصْـرَهُ ، وَنـورَهُ وَبَـرَكَتَـهُ ، وَهُـداهُ ، وَأَعـوذُ بِـكَ مِـنْ شَـرِّ ما فـيهِ وَشَـرِّ ما بَعْـدَه',
              'اللّهُـمَّ عالِـمَ الغَـيْبِ وَالشّـهادَةِ فاطِـرَ السّماواتِ وَالأرْضِ رَبَّ كـلِّ شَـيءٍ وَمَليـكَه ، أَشْهَـدُ أَنْ لا إِلـهَ إِلاّ أَنْت ، أَعـوذُ بِكَ مِن شَـرِّ نَفْسـي وَمِن شَـرِّ الشَّيْـطانِ وَشِرْكِهِ ، وَأَنْ أَقْتَـرِفَ عَلـى نَفْسـي سوءاً أَوْ أَجُـرَّهُ إِلـى مُسْـلِم',
              'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق',
              'اللَّهُمَّ صَلِّ وَسَلِّمْ وَبَارِكْ على نَبِيِّنَا مُحمَّد',
              'اللَّهُمَّ إِنَّا نَعُوذُ بِكَ مِنْ أَنْ نُشْرِكَ بِكَ شَيْئًا نَعْلَمُهُ ، وَنَسْتَغْفِرُكَ لِمَا لَا نَعْلَمُهُ',
              'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ الْهَمِّ وَالْحَزَنِ، وَأَعُوذُ بِكَ مِنْ الْعَجْزِ وَالْكَسَلِ، وَأَعُوذُ بِكَ مِنْ الْجُبْنِ وَالْبُخْلِ، وَأَعُوذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ، وَقَهْرِ الرِّجَالِ',
              'أسْتَغْفِرُ اللهَ العَظِيمَ الَّذِي لاَ إلَهَ إلاَّ هُوَ، الحَيُّ القَيُّومُ، وَأتُوبُ إلَيهِ',
              'يَا رَبِّ , لَكَ الْحَمْدُ كَمَا يَنْبَغِي لِجَلَالِ وَجْهِكَ , وَلِعَظِيمِ سُلْطَانِكَ',
              'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا',
              'اللَّهُمَّ أَنْتَ رَبِّي لا إِلَهَ إِلا أَنْتَ ، عَلَيْكَ تَوَكَّلْتُ ، وَأَنْتَ رَبُّ الْعَرْشِ الْعَظِيمِ , مَا شَاءَ اللَّهُ كَانَ ، وَمَا لَمْ يَشَأْ لَمْ يَكُنْ ، وَلا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ الْعَلِيِّ الْعَظِيمِ , أَعْلَمُ أَنَّ اللَّهَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ ، وَأَنَّ اللَّهَ قَدْ أَحَاطَ بِكُلِّ شَيْءٍ عِلْمًا , اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي ، وَمِنْ شَرِّ كُلِّ دَابَّةٍ أَنْتَ آخِذٌ بِنَاصِيَتِهَا ، إِنَّ رَبِّي عَلَى صِرَاطٍ مُسْتَقِيمٍ',
              'لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءِ قَدِيرِ',
              'سُبْحـانَ اللهِ وَبِحَمْـدِه',
              'أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ'
            ],
            [
              1,
              3,
              3,
              3,
              1,
              1,
              3,
              4,
              1,
              7,
              3,
              1,
              1,
              3,
              3,
              3,
              1,
              3,
              1,
              1,
              3,
              10,
              3,
              3,
              3,
              3,
              1,
              1,
              100,
              100,
              100
            ],
          ),
        ));
      } else if (payload == 2) {
        //اذكار المساء
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AskarPage(
            'أذكارالمساء ',
            Hive.box('askar_night_text'),
            Hive.box('askar_night_repet'),
            [
              '  اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
              'آمَنَ الرَّسُولُ بِمَا أُنْزِلَ إِلَيْهِ مِنْ رَبِّهِ وَالْمُؤْمِنُونَ ۚ كُلٌّ آمَنَ بِاللَّهِ وَمَلَائِكَتِهِ وَكُتُبِهِ وَرُسُلِهِ لَا نُفَرِّقُ بَيْنَ أَحَدٍ مِنْ رُسُلِهِ ۚ وَقَالُوا سَمِعْنَا وَأَطَعْنَا ۖ غُفْرَانَكَ رَبَّنَا وَإِلَيْكَ الْمَصِيرُ. لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا لَهَا مَا كَسَبَتْ وَعَلَيْهَا مَا اكْتَسَبَتْ رَبَّنَا لَا تُؤَاخِذْنَا إِنْ نَّسِينَآ أَوْ أَخْطَأْنَا رَبَّنَا وَلَا تَحْمِلْ عَلَيْنَا إِصْرًا كَمَا حَمَلْتَهُ عَلَى الَّذِينَ مِنْ قَبْلِنَا رَبَّنَا وَلَا تُحَمِّلْنَا مَا لَا طَاقَةَ لَنَا بِهِ وَاعْفُ عَنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا أَنْتَ مَوْلَانَا فَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِرِينَ',
              'قُلْ هُوَ ٱللَّهُ أَحَدٌ، ٱللَّهُ ٱلصَّمَدُ، لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌۢ',
              'قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ، مِن شَرِّ مَا خَلَقَ، وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ، وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِى ٱلْعُقَدِ، وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
              'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ، مَلِكِ ٱلنَّاسِ، إِلَٰهِ ٱلنَّاسِ، مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ، ٱلَّذِى يُوَسْوِسُ فِى صُدُورِ ٱلنَّاسِ، مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ',
              'أمسيـنا وأمسـى المـلك لله والحمد لله ، لا إله إلا الله وحده لا شريك له، له المـلك وله الحمـد، وهو على كل شيء قدير ، رب أسـألـك خـير ما في هـذه اللـيلة وخـير ما بعـدهـا ، وأعـوذ بك من شـر ما في هـذه اللـيلة وشر ما بعـدهـا ، رب أعـوذبك من الكسـل وسـوء الكـبر ، رب أعـوذ بك من عـذاب في النـار وعـذاب في القـبر',
              'اللهـم أنت ربـي لا إله إلا أنت ، خلقتنـي وأنا عبـدك ، وأنا علـى عهـدك ووعـدك ما استـطعـت ، أعـوذبك من شـر ما صنـعت ، أبـوء لـك بنعـمتـك علـي وأبـوء بذنـبي فاغفـر لي فإنـه لا يغـفر الذنـوب إلا أنت ',
              'رضيـت بالله ربـا وبالإسلام ديـنا وبمحـمد صلى الله عليه وسلم نبيـا',
              'اللهـم إنـي أمسيت أشـهدك ، وأشـهد حملـة عـرشـك ، وملائكتك ، وجمـيع خلـقك ، أنـك أنـت الله لا إله إلا أنـت وحـدك لا شريك لـك ، وأن محمـدا عبـدك ورسـولـك',
              'اللهـم ما أمسى بي مـن نعـمة أو بأحـد مـن خلـقك ، فمـنك وحـدك لا شريك لـك ، فلـك الحمـد ولـك الشكـر',
              'حسبـي الله لا إله إلا هو علـيه توكـلت وهو رب العرش العظـيم',
              'بسـم الله الذي لا يضـر مع اسمـه شيء في الأرض ولا في السمـاء وهـو السمـيع العلـيم',
              'اللهـم بك أمسـينا وبك أصـبحنا، وبك نحـيا وبك نمـوت وإلـيك المصير',
              'أمسينا على فطرة الإسلام، وعلى كلمة الإخلاص، وعلى دين نبينا محمد صلى الله عليه وسلم، وعلى ملة أبينا إبراهيم حنيفا مسلما وما كان من المشركين',
              'سبحـان الله وبحمـده عدد خلـقه ، ورضـا نفسـه ، وزنـة عـرشـه ، ومـداد كلمـاتـه',
              'اللهـم عافـني في بدنـي ، اللهـم عافـني في سمـعي ، اللهـم عافـني في بصـري ، لا إله إلا أنـت',
              'اللهـم إنـي أعـوذ بك من الكـفر ، والفـقر ، وأعـوذ بك من عذاب القـبر ، لا إله إلا أنـت',
              'اللهـم إنـي أسـألـك العـفو والعـافـية في الدنـيا والآخـرة ، اللهـم إنـي أسـألـك العـفو والعـافـية في ديني ودنـياي وأهـلي ومالـي ، اللهـم استـر عـوراتي وآمـن روعاتـي ، اللهـم احفظـني من بـين يدي ومن خلفـي وعن يمـيني وعن شمـالي ، ومن فوقـي ، وأعـوذ بعظمـتك أن أغـتال من تحتـي',
              'يا حي يا قيوم برحمتك أستغيث أصلح لي شأني كله ولا تكلني إلى نفسي طـرفة عين',
              'أمسينا وأمسى الملك لله رب العالمين، اللهم إني أسألك خير هذه الليلة فتحها ونصرها، ونورها وبركتها، وهداها، وأعوذ بك من شر ما فيها وشر ما بعدها',
              'اللهـم عالـم الغـيب والشـهادة فاطـر السماوات والأرض رب كـل شـيء ومليـكه ، أشهـد أن لا إلـه إلا أنت ، أعـوذ بك من شـر نفسـي ومن شـر الشيـطان وشركه ، وأن أقتـرف علـى نفسـي سوءا أو أجـره إلـى مسـلم',
              'أَعـوذُ بِكَلِمـاتِ اللّهِ التّـامّـاتِ مِنْ شَـرِّ ما خَلَـق',
              'اللهم صل وسلم وبارك على نبينا محمد',
              'اللهم إنا نعوذ بك من أن نشرك بك شيئا نعلمه ، ونستغفرك لما لا نعلمه',
              'اللهم إني أعوذ بك من الهم والحزن، وأعوذ بك من العجز والكسل، وأعوذ بك من الجبن والبخل، وأعوذ بك من غلبة الدين، وقهر الرجال',
              'أستغفر الله العظيم الذي لا إله إلا هو، الحي القيوم، وأتوب إليه',
              'يا رب , لك الحمد كما ينبغي لجلال وجهك , ولعظيم سلطانك',
              'اللهم إني أسألك علما نافعا، ورزقا طيبا، وعملا متقبلا',
              'اللهم أنت ربي لا إله إلا أنت ، عليك توكلت ، وأنت رب العرش العظيم , ما شاء الله كان ، وما لم يشأ لم يكن ، ولا حول ولا قوة إلا بالله العلي العظيم , أعلم أن الله على كل شيء قدير ، وأن الله قد أحاط بكل شيء علما , اللهم إني أعوذ بك من شر نفسي ، ومن شر كل دابة أنت آخذ بناصيتها ، إن ربي على صراط مستقيم',
              'لا إله إلا الله وحده لا شريك له، له الملك وله الحمد وهو على كل شيء قدير',
              'سُبْحـانَ اللهِ وَبِحَمْـدِهِ',
              'أسْتَغْفِرُ اللهَ وَأتُوبُ إلَيْهِ'
            ],
            [
              1,
              1,
              3,
              3,
              3,
              1,
              1,
              3,
              4,
              1,
              7,
              3,
              1,
              1,
              3,
              3,
              3,
              1,
              3,
              1,
              1,
              3,
              10,
              3,
              3,
              3,
              3,
              1,
              1,
              100,
              100,
              100,
            ],
          ),
        ));
      }
    });
  }

  int _CurrentPage = 0;
  final pages = [
    FirstPage(),
    Page1(),
    Page2(),
    Page3(),
  ];
  PreferredSizeWidget getAppBar(int num) {
    if (num == 3) {
      return AppBar3Page();
    } else if (num == 2) {
      return AppBar2Page();
    } else if (num == 1) {
      return AppBar1Page();
    } else {
      return AppBarFirstPage();
    }
  }

  void setNotificationNormalScheduling() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool shoNormalNoti = prefs.getBool('shoNormalNoti') ?? true;

    if (shoNormalNoti) {
      int? x = prefs.getInt('notiMinutes');
      if (x != null) {
        Workmanager().registerPeriodicTask(
          "0$x",
          "periodic Notification",
          frequency: Duration(minutes: x),
        );
      } else {
        Workmanager().registerPeriodicTask(
          "015",
          "periodic Notification",
          frequency: Duration(minutes: 15),
        );
      }
    }
  }

  void setNotificationM_NScheduling() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showNM_Noti = prefs.getBool('showNoti_MN') ?? true;
    print('################ showNM_Noti########################');
    print(showNM_Noti);
    if (showNM_Noti) {
      String morningHour = prefs.getString('morningHour') ?? '5';
      String morningMinute = prefs.getString('morningMinute') ?? '00';
      String morningMode = prefs.getString('morningMode') ?? 'ص';

      String nightHour = prefs.getString('nightHour') ?? '6';
      String nightMinute = prefs.getString('nightMinute') ?? '50';
      String nightMode = prefs.getString('nightMode') ?? 'م';

      int mh = int.parse(morningHour);
      mh = mh + (morningMode == 'م' ? 12 : 0);
      int mm = int.parse(morningMinute);

      int nh = int.parse(nightHour);
      nh = nh + (nightMode == 'م' ? 12 : 0);
      int nm = int.parse(nightMinute);

      Noti.notificationScheduled(
          id: 1,
          title: 'حصن المسلم ',
          body: 'اذكار الصباح',
          time: Time(mh, mm),
          payload: 'اذكار الصباح');
      Noti.notificationScheduled(
          id: 2,
          title: 'حصن المسلم ',
          body: 'اذكار المساء',
          time: Time(nh, nm),
          payload: 'اذكار المساء');
    }
  }

  @override
  void initState() {
    setNotificationNormalScheduling();

    super.initState();
    Noti.init();
    listenNotifications();
    setNotificationM_NScheduling();
    // Noti.showNotification(
    //     title: 'firstNoti',
    //     body: 'الحمد لله',
    //     id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
    //     payload: '1');
    // Timer.periodic(
    //   Duration(seconds: 10),
    //   (timer) {
    //     List<String> list = ['1', '2', '3', '4', '5'];
    //     int rndmIndex = Random().nextInt(list.length - 1);
    //     Noti.showNotification(
    //         title: 'firstNoti',
    //         body: list[rndmIndex],
    //         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
    //         payload: '1');
    //   },
    // );
    // Workmanager().registerPeriodicTask('uniqueName1', 'taskName1',
    //     frequency: Duration(minutes: 15));
    // listenNotifications();

    // Noti.notificationScheduled(
    //     id: 3, title: 'حصن المسلم ', body: 'اذكار المساء', time: Time(2));

    // Future.delayed(Duration(milliseconds: 100), () {
    //   Provider.of<MyData>(context, listen: false).setAllAskar();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: getAppBar(_CurrentPage),
          body: pages[_CurrentPage],
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [kBoxShadow],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                    icon: _CurrentPage == 3
                        ? Image.asset('images/icons8-filled-heart-64.png',
                            height: 40.0)
                        : Image.asset('images/icons8-favorite-50.png',
                            height: 40.0),
                    onPressed: () {
                      setState(() {
                        _CurrentPage = 3;
                      });
                    },
                    enableFeedback: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: _CurrentPage == 2
                        ? Icon(Icons.book, size: 35.0)
                        : Icon(Icons.book_outlined, size: 35.0),
                    onPressed: () {
                      setState(() {
                        _CurrentPage = 2;
                      });
                    },
                    enableFeedback: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: _CurrentPage == 1
                        ? Image.asset('images/icons8-moon-star-50 (1).png',
                            height: 35.0)
                        : Image.asset('images/icons8-moon-star-50.png',
                            height: 35.0),
                    onPressed: () {
                      setState(() {
                        _CurrentPage = 1;
                      });
                    },
                    enableFeedback: false,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    icon: _CurrentPage == 0
                        ? Icon(Icons.home, size: 40.0)
                        : Icon(Icons.home_outlined, size: 40.0),
                    onPressed: () {
                      setState(() {
                        _CurrentPage = 0;
                      });
                    },
                    enableFeedback: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        color: Colors.red,
      ),
    );
  }
}
