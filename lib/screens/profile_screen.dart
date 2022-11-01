import 'package:flutter/material.dart';
import 'package:food_app/authentication/login_screen.dart';
import 'package:food_app/sharedPreferences/current_user_shared_prefs_data.dart';
import 'package:food_app/sharedPreferences/user_shared_preferences.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {

  // with this we can get the current user shared preference data
final CurrentUserData _currentUserData = Get.put(CurrentUserData());


signOutUser() async {

 var resultResponse =  await Get.dialog(
     AlertDialog(
      backgroundColor: Colors.redAccent,
      title: const Text("LogOut",
      style: TextStyle(
fontSize: 18,
        fontWeight: FontWeight.bold,

      ),
      ),

      content: const Text("Are you Sure?"),
      actions: [
        TextButton(
            onPressed: ()
            {
              Get.back();

            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.amberAccent,
              ),
            )
        ),
        TextButton(
            onPressed: ()
            {
              Get.back(result: "LoggedOut");

            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.amberAccent,
              ),
            )
        ),
        
      ],

    ),
  );

 if(resultResponse == "LoggedOut")
   {
     // delete the shared preferences data
UserSharedPrefs.deleteUserInfo().then((value) {
Get.off(const LoginScreen());

});

   }


}

// This is our reusable widget
  Widget userInfoItemProfile (IconData iconData, String userData)
  {
return Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: Colors.yellowAccent,
),
  padding:const EdgeInsets.symmetric(
horizontal: 16,
    vertical: 8,
  ) ,
  child: Row(
children: [
  Icon(
iconData,
    size: 30,
      color: Colors.purpleAccent,

  ),
  const SizedBox(width: 16),
  Text(
userData,
style: const TextStyle(
  fontSize: 12,

),
  ),

],

  ),
);

  }
  // reusable widget ends here

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(

children: [

  Center(


child: Image.asset("images/man.png", width: 240,),
  ),

  const SizedBox(height: 20),

  // now we are using the reusable widget
  userInfoItemProfile(Icons.person, _currentUserData.user.user_name),

  const SizedBox(height: 20),
  userInfoItemProfile(Icons.email, _currentUserData.user.user_email),

  const SizedBox(height: 20),

  Center(
      child: Material(
color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: ()
          {
signOutUser();

          },

          borderRadius: BorderRadius.circular(32),
          child: const Padding(
padding: EdgeInsets.symmetric(
horizontal: 30,
  vertical: 12,
),
            child: Text("Sign Out", style: TextStyle(
              color: Colors.purpleAccent,
              fontSize: 16,

            ),),

          ),

        ),


      ),
  )



],
      ),
    );
  }
}
