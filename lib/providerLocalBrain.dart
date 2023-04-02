import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProviderLocal with ChangeNotifier {
  Box box = Hive.box('pageOne');
  List<String> values = [];

  Future<void> refreshAndGetValuesList() async {
    print('#########################update#################################');
    Map map = box.toMap();
    print('#########################update#################################');
    print(map);
    values.clear();
    for (final mapEntry in map.entries) {
      var key = mapEntry.key;
      var value = mapEntry.value;
      values.add(value);
    }
  }

  List<String> getValues() {
    return values;
  }

  void setData(String value) {
    box.put((box.toMap().length + 1).toString(), value);
    notifyListeners();
  }

  void update(String value, String newValue) {
    var key = box
        .toMap()
        .keys
        .firstWhere((k) => box.toMap()[k] == value, orElse: () => 'null');
    if (key == 'null') {
      print('there isnt key in update func');
    }
    box.put(key, newValue);

    // print('#########################update#################################');
    // print(_box.toMap());
    notifyListeners();
  }

  void delete(String value) {
    var key = box
        .toMap()
        .keys
        .firstWhere((k) => box.toMap()[k] == value, orElse: () => 'null');
    if (key == 'null') {
      print('there isnt key in update func');
    }
    box.delete(key);
    notifyListeners();
  }
}
