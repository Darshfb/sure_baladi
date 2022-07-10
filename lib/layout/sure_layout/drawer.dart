import 'package:flutter/material.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/modules/auth/login/login_screen.dart';
import 'package:surebaladi/modules/cart_list/cart_list_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/component/component.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 128.0,
              height: 128.0,
              margin: const EdgeInsets.only(
                top: 24.0,
                bottom: 64.0,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/ass.jpg',
                fit: BoxFit.fill,
              ),
            ),
            ListTile(
              onTap: () {
                navigateAndFinish(context: context, widget: SureLayout());
              },
              leading: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Profile'),
            ),
            ListTile(
              onTap: () {
                navigateTo(context: context, widget: const CartScreen());
              },
              leading: const Icon(IconBroken.buy),
              title: const Text('Cart'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.favorite),
              title: const Text('Favourites'),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
            ),
            ListTile(
              onTap: () {
                CacheHelper.clearData(token).then((value) {
                  navigateAndFinish(context: context, widget: LoginScreen());
                }).then((value) {
                  CacheHelper.clearAll();
                });
              },
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
            ),
            const Spacer(),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: const Text('Terms of Service | Privacy Policy'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
