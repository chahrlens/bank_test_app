import 'package:bank_test_app/routes/router_paths.dart';
import 'package:bank_test_app/widgets/home_layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:bank_test_app/data/constants/assets_paths.dart';
import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      title: '',
      child: Column(
        children: [
          Center(
            child: Image.asset(
              AssetsPaths.logo,
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Explora y descubre vehículos',
            style: CustomStyles.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          PrimaryActionButton(
            label: 'Iniciar Sesión',
            onTap: () {
              Get.toNamed(RouterPaths.login);
            },
          ),
          const Spacer(),
          Text(
            '¿No tienes cuenta?\n Crea una ahora!',
            style: CustomStyles.caption,
          ),
          PrimaryActionButton(
            label: 'Registrarse',
            onTap: () {
              Get.toNamed(RouterPaths.register);
            },
            decoration: CustomStyles.whiteBoxDecoration,
            textStyle: CustomStyles.buttonBlackText,
          ),
        ],
      ),
    );
  }
}
