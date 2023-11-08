import 'package:get/get.dart';
import 'package:resume_builder/app_routes/app_middleware.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';
import 'package:resume_builder/screens/auth/auth_controller.dart';
import 'package:resume_builder/screens/auth/login_screen.dart';
import 'package:resume_builder/screens/auth/signup_screen.dart';
import 'package:resume_builder/screens/home_screen.dart';
import 'package:resume_builder/screens/splash_screen.dart';
import 'package:resume_builder/screens/view_model.dart/home_view_model.dart';

abstract class AppRoutes {
  static getRoutes() => [
        GetPage(
            name: AppRoutesName.initialRoutes,
            page: () => const SplashScreen(),
            middlewares: [SplashMiddleware()]),
        GetPage(
            name: AppRoutesName.loginRoutes,
            page: () => LoginScreen(),
            middlewares: [LoginMiddleware()],
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthController());
            })),
        GetPage(
            name: AppRoutesName.signUpRoutes,
            page: () => const SignUpScreen(),
            middlewares: [LoginMiddleware()],
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthController());
            })),
        GetPage(
            name: AppRoutesName.homeRoutes,
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => HomeController());
            })),
      ];
}
