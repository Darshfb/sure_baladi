import 'package:flutter/material.dart';
import 'package:surebaladi/modules/home/mob/mob_home_product_staggered.dart';
import 'package:surebaladi/modules/home/mob/mob_slider.dart';
import 'package:surebaladi/modules/home/tab/tab_home_product_staggered.dart';
import 'package:surebaladi/modules/home/tab/tab_slider.dart';
import 'package:surebaladi/shared/utilis/responsive.dart';

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
          const Responsive(
            mobile: MobSliderBanner(),
            desktop: TabSliderBanner(),
            tablet: TabSliderBanner(),
          ),
          // const SliderBanner(),
          Responsive(
            mobile: MobStaggeredHomeProduct(
              onPressed: () {
                scrollUp();
              },
            ),
            desktop: TapStaggeredHomeProduct(
              onPressed: () {
                scrollUp();
              },
            ),
            tablet: TapStaggeredHomeProduct(
              onPressed: () {
                scrollUp();
              },
            ),
          ),
          // LayoutBuilder(
          //   builder: (BuildContext context, BoxConstraints constraints) {
          //    print('sssssssssssssssssss ${constraints.minWidth.toInt()}');
          //     if (constraints.minWidth.toInt() <= 560) {
          //       return MobStaggeredHomeProduct(
          //         onPressed: () {
          //           scrollUp();
          //         },
          //       );
          //     }else{
          //       return TapStaggeredHomeProduct(onPressed: (){scrollUp();},);
          //     }
          //   },
          // ),
          // StaggeredHomeProduct(onPressed: () {
          //   scrollUp();
          // }),
        ],
      ),
    );
  }
}
