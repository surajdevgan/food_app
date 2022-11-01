import 'package:food_app/models/user.dart';
import 'package:food_app/sharedPreferences/user_shared_preferences.dart';
import 'package:get/get.dart';

// this class is to get the shared preferences data
class CurrentUserData extends GetxController
{
  // this thing xhenge according to the constructor
  Rx<User> _currentUserData  = User(0, '', '', '', '', '').obs;

  User get user => _currentUserData.value;

    getUserInfo()
async {

  User? getUserInfoFromSharedPrefs = await UserSharedPrefs.readUserInfo();
    _currentUserData.value  = getUserInfoFromSharedPrefs!;


}
}