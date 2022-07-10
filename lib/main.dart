import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surebaladi/layout/cubit/cubit.dart';
import 'package:surebaladi/modules/splash_screen/splash_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/Network/dio_helper.dart';
import 'package:surebaladi/shared/bloc_ovserve.dart';
import 'package:surebaladi/shared/constants/const.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  BlocOverrides.runZoned(
        () {
          HomeCubit();
    },
    blocObserver: MyBlocObserver(),
  );
   if (kDebugMode) {
     print(savedToken.toString());
   }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sure Baladi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

