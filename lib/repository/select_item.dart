import 'package:flutter/material.dart';

class SelectItemRepository with ChangeNotifier {
  int _idx = 0;
  int get idx => _idx;
  set idx(int i) {
    _idx = i;
    notifyListeners();
  }
}
