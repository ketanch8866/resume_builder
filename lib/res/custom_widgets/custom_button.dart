import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/res/theam/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool loading;
  final Color? textColor;
  final double? width;
  final List<Color>? buttonColors;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key,
      this.buttonColors,
      this.textColor,
      required this.title,
      this.width,
      this.loading = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: loading ? null : width ?? size.width * 0.75,
        // margin: EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: buttonColors == null
                ? null
                : Border.all(color: AppColors.primaryColor),
            color: loading ? AppColors.primarybgColor : null,
            gradient: loading
                ? null
                : LinearGradient(
                    colors: buttonColors ?? AppColors.linearGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
        child: Center(
            child: loading
                ? SizedBox(
                    height: 20,
                    child: LottieBuilder.asset('asset/lottie/loading.json'))
                : Text(
                    title,
                    style: TextStyle(
                        color: textColor ?? AppColors.whiteColor, fontSize: 18),
                  )),
      ),
    );
  }
}
