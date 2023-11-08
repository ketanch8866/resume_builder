import 'package:flutter/material.dart';
import 'package:resume_builder/res/app_text_style/app_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Splash Screen",
            style: AppTextStyle.largeTitleBlack,
          ),
        ],
      ),
    );
  }
}
