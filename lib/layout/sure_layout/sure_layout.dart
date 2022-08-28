import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/layout/sure_layout/widgets/drawer.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';
import 'package:surebaladi/shared/utilis/constant/app_colors.dart';

class SureLayout extends StatelessWidget {
  SureLayout({Key? key}) : super(key: key);
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()
        ..getCategory()
        ..getHomeProductData(context: context)
        ..getCartData(),
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
                elevation: 0,
                backgroundColor: const Color(0xff119744),
                actions: [
                  if (cubit.isCategoryAdd && cubit.currentIndex == 1)
                    TextButton(
                      onPressed: () {
                        cubit.getProduct();
                      },
                      child: Text('Back'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                ],
                title: customText(
                  text: CacheHelper.getData(key: token) == null
                      ? '${'Welcome! '.tr()} '
                      : '${'Welcome! '.tr()}${CacheHelper.getData(key: 'userName')}!!',
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
              body: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return WillPopScope(
                        onWillPop: () {
                          return cubit.onWillPop(context: context);
                        },
                        child: cubit.screens[cubit.currentIndex]);
                  } else {
                    return buildOfflineWidget();
                  }
                },
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // cubit.screens[cubit.currentIndex],
              bottomNavigationBar: ConvexAppBar.badge(
                const {2: '', 3: ''},
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

  Widget buildOfflineWidget() {
    return Center(
      child: Container(
        height: 320,
        width: 320,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Can\'t connect... check your internet'.tr(),
              style: const TextStyle(color: Colors.grey, fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset(
              'assets/images/check_internet.svg',
              height: 150,
              width: 150,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop({required BuildContext context}) async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 0,
        title: Text('Are you sure?'.tr()),
        content: Text('Do you want close The app?'.tr()),
        actions: <Widget>[
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'.tr()),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'.tr()),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
}
