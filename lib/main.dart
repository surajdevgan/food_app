import 'package:flutter/material.dart';
import 'package:food_app/authentication/login_screen.dart';
import 'package:food_app/screens/screens_manager.dart';
import 'package:food_app/sharedPreferences/user_shared_preferences.dart';
import 'package:get/get.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: UserSharedPrefs.readUserInfo(), // this readUserInfo() method will return us the current user information.

builder: (context, dataSnapShot)
        {
          if(dataSnapShot.data == null)
            {
return LoginScreen();

            }

          else {

            return ScreensManager();
          }

        },

      ),
    );
  }
}

