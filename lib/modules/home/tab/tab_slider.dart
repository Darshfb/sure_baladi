import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class TabSliderBanner extends StatelessWidget {
  const TabSliderBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0),
      child: CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height / 2.5,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/loading.gif',
                  width: MediaQuery.of(context).size.width,
                  image: 'https://img.freepik.com/free-vector/promotion-sale-labels-best-offers_206725-127.jpg?w=2000',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 10.0),
                  child: CustomButton(
                      backgroundColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      onPressed: (){},
                      child: Text('Shop Now'.tr())),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
