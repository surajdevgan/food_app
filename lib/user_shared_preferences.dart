

import 'dart:convert';

import 'package:food_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs

{
static Future<void> saveRememberUser (User userInfo)
async {
SharedPreferences preferences = await SharedPreferences.getInstance();
String userJsonData = jsonEncode(userInfo.toJson());
await preferences.setString("currentUser", userJsonData); // currentUser is the key name of our shared preferences data, so keep this key name in mind

}

}