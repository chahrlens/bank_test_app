import 'package:bank_test_app/routes/router_paths.dart';
import 'package:bank_test_app/views/home/pages/home_page.dart';
import 'package:bank_test_app/views/home/pages/login_page.dart';
import 'package:bank_test_app/views/home/pages/register_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

class GetRoutes {
  static List<GetPage> routes = [
    GetPage(name: RouterPaths.home, page: () => const HomePage()),
    GetPage(name: RouterPaths.login, page: () => const LoginPage()),
    GetPage(name: RouterPaths.register, page: () => const RegisterPage()),
  ];
}
