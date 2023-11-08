import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/app_routes/app_routes.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/data/auth/base_auth.dart';

class SplashMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    loadSplash();
    return super.onPageCalled(page);
  }

  loadSplash() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(AppRoutesName.loginRoutes);
      },
    );
  }
}

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final user = BaseAuthenticatiopn.firebaseAuth.currentUser;
    if (user != null) {
      return RouteSettings(name: AppRoutesName.homeRoutes);
    }
    return super.redirect(route);
  }
}
