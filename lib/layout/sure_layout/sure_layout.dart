import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/sure_layout/drawer.dart';
import 'package:surebaladi/modules/category/category_screen.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class SureLayout extends StatelessWidget {
  SureLayout({Key? key}) : super(key: key);
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getCategory()..getHomeProductData()..getCartData(),
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
              // NOTICE: Uncomment if you want to add shadow behind the page.
              // Keep in mind that it may cause animation jerks.
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //     color: Colors.black12,
              //     blurRadius: 0.0,
              //   ),
              // ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: const MyDrawer(),
            child: Scaffold(
              // end: Colors.black,
              endDrawer: const CategoryScreen(),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppColors.primaryColor,
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
                {
                  1: '${context.watch<HomeCubit>().cartModels != null ? context.watch<HomeCubit>().cartModels!.cartItems.length : ''}',
                  2: '100'
                },
                badgeMargin: const EdgeInsets.only(
                  bottom: 30,
                  right: 40,
                ),
                top: -21,
                height: 50,
                backgroundColor: Colors.grey.shade200,
                color: Colors.grey.shade800,
                activeColor: AppColors.primaryColor,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                items: const [
                  TabItem(icon: Icons.home_outlined, title: 'Home'),
                  TabItem(icon: Icons.shopping_cart, title: 'Cart'),
                  TabItem(icon: Icons.favorite, title: 'Favorite'),
                  TabItem(icon: Icons.compare_arrows, title: 'Compare'),
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
