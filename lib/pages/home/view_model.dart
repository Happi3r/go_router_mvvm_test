import 'package:flutter/material.dart';
import 'package:go_router_mvvm_test/repository/select_item.dart';

class HomeViewModel with ChangeNotifier {
  final SelectItemRepository repository;

  HomeViewModel(this.repository);

  set idx(int i) {
    repository.idx = i;
    notifyListeners();
  }
}
