import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedEmail = prefs.getString('email') ?? '';
    String savedPassword = prefs.getString('password') ?? '';

    if (email.value == savedEmail && password.value == savedPassword) {
      Get.off(HomeScreen());
    } else {
      Get.snackbar('Error', 'Invalid credentials');
    }
  }

  void signUp(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    Get.off(HomeScreen());
  }
}
