import 'dart:convert';

import 'package:food_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs

{
  // this method is to put user info to shared prefs
static Future<void> saveUserInfo (User userInfo)
async {
SharedPreferences preferences = await SharedPreferences.getInstance();
String userJsonData = jsonEncode(userInfo.toJson());
await preferences.setString("currentUser", userJsonData); // currentUser is the key name of our shared preferences data, so keep this key name in mind

}

// this method is used to get user info from shared prefs

  static Future<User?> readUserInfo ()
  async {
  User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
          String? userInfo  =  preferences.getString("currentUser");
          if(userInfo != null)
            {
              Map<String, dynamic> userDataMap = jsonDecode(userInfo);
              currentUserInfo =  User.fromJson(userDataMap);
            }
          return currentUserInfo;

  }

  static Future<void> deleteUserInfo () async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");

  }


}