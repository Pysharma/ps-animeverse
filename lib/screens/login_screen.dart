import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 26),
              Lottie.network('https://lottie.host/3089894f-52db-46a8-a83a-efc63d28854e/x6tibNp1W9.json',),
              CupertinoTextField(
                onChanged: (value) => loginController.email.value = value,
                placeholder: 'Email',
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              SizedBox(height: 16),
              CupertinoTextField(
                onChanged: (value) => loginController.password.value = value,
                placeholder: 'Password',
                padding: EdgeInsets.all(16),
                obscureText: true,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: () {
                  loginController.login();
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
