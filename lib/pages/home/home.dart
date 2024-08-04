import 'package:flutter/material.dart';
import 'package:go_router_mvvm_test/pages/home/view.dart';
import 'package:go_router_mvvm_test/pages/home/view_model.dart';
import 'package:go_router_mvvm_test/repository/select_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(context.read<SelectItemRepository>()),
      child: const HomeView(),
    );
  }
}
