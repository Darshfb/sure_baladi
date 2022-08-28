import 'dart:async';
import 'package:flutter/material.dart';
import 'package:surebaladi/layout/sure_layout/sure_layout.dart';
import 'package:surebaladi/modules/auth/login/login_screen.dart';
import 'package:surebaladi/shared/Local/cache_helper.dart';
import 'package:surebaladi/shared/constants/const.dart';
import 'package:surebaladi/shared/utilis/asset_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 2000), _goNext);
  }
String firstToken = (CacheHelper.getData(key: token) == null) ? '' : CacheHelper.getData(key: token);
  _goNext() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SureLayout()));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage(ImageAsset.logoImage)),
      ),
    );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
