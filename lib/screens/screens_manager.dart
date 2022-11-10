

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/sharedPreferences/current_user_shared_prefs_data.dart';
import 'package:food_app/screens/home_screen.dart';
import 'package:food_app/screens/order_screen.dart';
import 'package:food_app/screens/profile_screen.dart';
import 'package:food_app/screens/wishlist_screen.dart';
import 'package:get/get.dart';

class ScreensManager extends StatelessWidget {


  CurrentUserData _rememberCurrentUser  = Get.put(CurrentUserData());

  List<Widget> _screens =
      [
        HomeScreen(),
        WishlistScreen(),
        OrderScreen(),
        ProfileScreen(),
      ];

  List _navigationButtonProperties =
  [
    {
      "active_icon" : Icons.home,
      "non_active_icon" : Icons.home_outlined,
      "label" : "Home"
    },

    {
      "active_icon" : Icons.favorite,
      "non_active_icon" : Icons.favorite_border,
      "label" : "Wishlist"
    },

    {
      "active_icon" : FontAwesomeIcons.boxOpen,
      "non_active_icon" : FontAwesomeIcons.box,
      "label" : "Orders"
    },

    {
      "active_icon" : Icons.person,
      "non_active_icon" : Icons.person_outline,
      "label" : "Profile"
    },

  ];

  RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context)
  {
    return GetBuilder(
        init: CurrentUserData(),
        initState: (currentState)
        {
        _rememberCurrentUser.getUserInfo();

        },
        builder: (controller)
    {
return Scaffold(
  backgroundColor: Colors.black,
  body: SafeArea(
child: Obx(
    () => _screens[_indexNumber.value]
),

  ),
  bottomNavigationBar: Obx(

      () => BottomNavigationBar (
          currentIndex: _indexNumber.value,
          onTap: (value)
          {
            _indexNumber.value = value;
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white24,
          items: List.generate(4, (index)
          {
              var navBtnProperty = _navigationButtonProperties[index];
              return BottomNavigationBarItem(
backgroundColor: Colors.black,
                icon: Icon(navBtnProperty["non_active_icon"]),
                activeIcon: Icon(navBtnProperty["active_icon"]),
label: navBtnProperty["label"],
              );
          }),

      ),
  ),

);

    },
    );
  }
}
