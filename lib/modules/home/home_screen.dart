import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:surebaladi/modules/home/home_products.dart';
import 'package:surebaladi/modules/home/slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = ScrollController();

  void scrollUp() {
    double start = 0;
    controller.animateTo(start,
        duration: const Duration(seconds: 3), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SliderBanner(),
          HomeProducts(onPressed: () {
            scrollUp();
          }),
        ],
      ),
    );
  }
}
