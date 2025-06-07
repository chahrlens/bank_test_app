import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bank_test_app/routes/get_routes.dart';
import 'package:bank_test_app/routes/router_paths.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bank_test_app/data/constants/custom_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bank Test App',
      builder: (BuildContext context, Widget? child) {
        return FlutterEasyLoading(child: child);
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppColors.darkGreen,
        scaffoldBackgroundColor: AppColors.lightGreen,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.mediumGreen,
          iconTheme: const IconThemeData(color: AppColors.white),
          titleTextStyle: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.yellow,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouterPaths.home,
      getPages: [...GetRoutes.routes],
    );
  }
}
