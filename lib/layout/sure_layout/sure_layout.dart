import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/sure_layout/widgets/drawer.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';
import 'package:surebaladi/shared/utilis/constant/app_strings.dart';

class SureLayout extends StatelessWidget {
  SureLayout({Key? key}) : super(key: key);
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()
        ..getCategory()
        ..getHomeProductData()
        ..getCartData()
        ..getCategoryProduct(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = HomeCubit.get(context);
          return AdvancedDrawer(
            backdropColor: Colors.blueGrey,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            // openScale: 1.0,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: const MyDrawer(),
            child: Scaffold(
              // end: Colors.black,
              appBar: AppBar(
                // centerTitle: true,
                backgroundColor: const Color(0xff119744),
                actions: [
                  if (cubit.isCategoryAdd && cubit.currentIndex == 3)
                    IconButton(
                        onPressed: () {
                          cubit.getProduct();
                        },
                        icon: const Icon(
                          IconBroken.arrowLeft2,
                          color: Colors.white,
                        )),
                ],
                title: customText(
                  text: CacheHelper.getData(key: token) == null ? '${AppStrings.welcome} ' :
                  '${AppStrings.welcome} ' '${CacheHelper.getData(key: 'userName')}!!',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                leading: IconButton(
                  onPressed: _handleMenuButtonPressed,
                  icon: ValueListenableBuilder<AdvancedDrawerValue>(
                    valueListenable: _advancedDrawerController,
                    builder: (_, value, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: Icon(
                          value.visible ? Icons.clear : Icons.menu,
                          key: ValueKey<bool>(value.visible),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: ConvexAppBar.badge(
                {2: cubit.cartSize != '0' ? "+1" : " ", 3: ''},
                badgeMargin: const EdgeInsets.only(
                  bottom: 30,
                  right: 40,
                ),
                top: -21,
                height: 52,
                backgroundColor: Colors.grey.shade200,
                color: Colors.grey.shade800,
                activeColor: AppColors.primaryColor,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                elevation: 5,
                items: [
                  TabItem(icon: Icons.home_outlined, title: 'Home'.tr()),
                  TabItem(icon: IconBroken.category, title: 'Category'.tr()),
                  TabItem(icon: Icons.shopping_cart, title: 'Cart'.tr()),
                  TabItem(icon: Icons.favorite, title: 'Favorite'.tr()),
                ],
              ),
              // BottomNavigationBar(
              //   selectedItemColor: AppColors.primaryColor,
              //     onTap: (index) {
              //       cubit.changeBottomNav(index);
              //     },
              //     currentIndex: cubit.currentIndex,
              //     type: BottomNavigationBarType.fixed,
              //     items: [
              //       const BottomNavigationBarItem(
              //           icon: Icon(
              //             Icons.home_outlined,
              //           ),
              //           label: 'Home'),
              //       const BottomNavigationBarItem(
              //           icon: Icon(
              //             Icons.menu_open,
              //           ),
              //           label: 'Category'),
              //       BottomNavigationBarItem(
              //           icon: Stack(
              //             alignment: Alignment.topRight,
              //             children:  const [
              //               Icon(
              //                 Icons.shopping_cart,
              //               ),
              //               Positioned(
              //                 bottom: 8,
              //                 left: 6,
              //                 child: CircleAvatar(
              //                   radius: 20,
              //                   backgroundColor: Colors.red,
              //                   child: Text('12'),
              //                 ),
              //               )
              //             ],
              //           ),
              //           label: 'Cart'),
              //       BottomNavigationBarItem(
              //           icon: Icon(
              //             Icons.favorite,
              //           ),
              //           label: 'Favorite'),
              //       BottomNavigationBarItem(
              //           icon: Icon(
              //             Icons.compare_arrows,
              //           ),
              //           label: 'Compare'),
              //     ]),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
