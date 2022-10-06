import 'package:flutter/material.dart';
import 'package:food_app/authentication/login_screen.dart';
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
builder: (context, dataSnapShot)
        {

          return LoginScreen();
        },

      ),
    );
  }
}

