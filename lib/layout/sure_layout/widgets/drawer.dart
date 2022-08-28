import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:surebaladi/layout/sure_layout/settings_screen.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/modules/address/address_screen.dart';
import 'package:surebaladi/modules/auth/login/login_screen.dart';
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
                fit: BoxFit.cover,
              ),
            ),
            if (CacheHelper.getData(key: token) != null)
              Column(
                children: [
                  Text(
                    CacheHelper.getData(key: 'userName').toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    CacheHelper.getData(key: 'email').toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(color: Colors.white),
            ListTile(
              onTap: () {
                navigateAndFinish(context: context, widget: SureLayout());
              },
              leading: const Icon(IconBroken.home),
              title: Text('Home'.tr()),
            ),
            ListTile(
              onTap: () {
                navigateTo(context: context, widget: SettingsScreen());
              },
              leading: const Icon(IconBroken.setting),
              title: Text('Settings'.tr()),
            ),
            if (CacheHelper.getData(key: token) != null)
              ListTile(
                onTap: () {
                  navigateTo(context: context, widget: AddressScreen());
                },
                leading: const Icon(IconBroken.setting),
                title: Text('Address'.tr()),
              ),
            ListTile(
              onTap: () {
                if (CacheHelper.getData(key: token) != null) {
                  CacheHelper.clearData(token).then((value) {
                    showToast(
                        text: 'Logged out successfully'.tr(),
                        state: ToastStates.ERROR);
                    navigateAndFinish(context: context, widget: SureLayout());
                  });
                } else {
                  navigateTo(context: context, widget: LoginScreen());
                }
              },
              leading: const Icon(IconBroken.logout),
              title: Text(CacheHelper.getData(key: token) != null
                  ? 'Log out'.tr()
                  : 'Log in'.tr()),
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
