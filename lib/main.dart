import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/app_routes/app_routes.dart';
import 'package:resume_builder/app_routes/app_routes_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDf9bDt081avtCfI7-UYJ3TcNVTDYp6ssc",
          appId: "1:755327683082:web:88614384ab9ee9eb102df3",
          messagingSenderId: "755327683082",
          projectId: "resumbuilder-8e775"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutesName.initialRoutes,
      getPages: AppRoutes.getRoutes(),
    );
  }
}
