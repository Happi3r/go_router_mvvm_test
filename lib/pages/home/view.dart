import 'package:flutter/material.dart';
import 'package:go_router_mvvm_test/pages/home/view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Colors.lightGreen.withOpacity(0.25),
          Colors.amber,
          Colors.lightBlueAccent.withOpacity(0.25),
          Colors.greenAccent,
          Colors.blueGrey.withOpacity(0.25),
          Colors.redAccent,
        ].map((color) {
          return GestureDetector(
            onTap: () {
              context.read<HomeViewModel>().idx = color.opacity == 0.25 ? 1 : 0;
            },
            child: Container(color: color, height: 150),
          );
        }).toList(),
      ),
    );
  }
}
