import 'package:surebaladi/shared/Local/cache_helper.dart';

String token = '';
String savedToken = (CacheHelper.getData(key: token) == null) ? '' : CacheHelper.getData(key: token);
const String bearer = 'Bearer';
const String xToken = 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiYWRhd3k4OCIsImlhdCI6MTY1NTMxMDA2OCwiZXhwIjoxNjU1Mzk2NDY4fQ.wUUEAnKV7Ey9q2OQK_QoHgyM6ztVR97riHRs5Mj-XKzfSnN2z2ZvAkqU1tMZh6_vKfqwJCE6ZzWLaGYkSQID5w';
String? loginToken;
String cartLength = '';