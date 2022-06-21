import 'package:surebaladi/shared/Local/cache_helper.dart';

String LOGIN = 'api/auth/signin';
String REGISTER = 'api/auth/signup';
// String? TOKEN ;
String BARER = "Bearer ";
String? getToken;
String userName = CacheHelper.getData(key: 'name').toString();

bool onBoarding = (CacheHelper.getData(key: 'onBoarding') == null)
    ? false
    : CacheHelper.getData(key: 'onBoarding');
