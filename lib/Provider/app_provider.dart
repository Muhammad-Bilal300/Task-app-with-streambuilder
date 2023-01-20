import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_app/Models/list_item_model.dart';

class AppProvider extends ChangeNotifier {
  final List<ListItem> _listItems = [];

  List<ListItem> get getItems => _listItems;

  void removeItem(int index) {
    _listItems.removeAt(index);

    notifyListeners();
  }

  void editItem(int index, String element) {
    _listItems[index].title = element;

    notifyListeners();
  }

  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  void addItem() {
    for (var i = 0; i < 2; i++) {
      _listItems.add(
        ListItem(
            title: "${getRandom(8)}",
            image:
                "assets/apple.jpg"),
      );
    }
    print("2 Items added");
    notifyListeners();
  }
}
