import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/layout/cubit/states.dart';
import 'package:surebaladi/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is ChangeLangState) {
            // context.read<HomeCubit>().changeLanguage(context);

            // Phoenix.rebirth(context);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff119744),
              elevation: 5.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.arrowLeft2, size: 30),
                  color: Colors.white),
              actions: [
                TextButton(
                    onPressed: () {
                      cubit.changeLanguage(context);
                      Phoenix.rebirth(context);
                    },
                    child: Text(
                      'Update'.tr(),
                      style: TextStyle(color: Colors.white),
                    )),
              ],
              title: Text(
                'Settings'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Arabic Language'.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                    subtitle: Text(
                      'to change language to Arabic'.tr(),
                    ),
                    trailing: Switch(
                        activeColor: Colors.grey,
                        value: HomeCubit.isLang,
                        onChanged: (value) {
                          // // cubit.isLang = value;
                          print(value);
                          // print(cubit.isLang);
                          // CacheHelper.saveData(key: 'lang', value: value);
                          cubit.changeLang(language: value);
                        }),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
