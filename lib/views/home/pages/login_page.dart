import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:bank_test_app/routes/router_paths.dart';
import 'package:bank_test_app/views/home/controllers/login_controller.dart';
import 'package:bank_test_app/widgets/custom_input.dart';
import 'package:bank_test_app/widgets/home_layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _hadleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      Get.snackbar('Éxito', 'Inicio de sesión exitoso');
    } else {
      Get.snackbar('Error', 'Por favor corrige los errores en el formulario');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: HomeLayout(
        title: 'Iniciar Sesión',
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Bienvenido', style: CustomStyles.headline1),
                Text(
                  'Inicia sesión para continuar',
                  style: CustomStyles.bodyText1,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInput(
                        controller: _controller.emailController,
                        label: 'Correo Electrónico',
                        validator: _controller.validateEmail,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => CustomInput(
                          controller: _controller.passwordController,
                          label: 'Contraseña',
                          validator: _controller.validatePassword,
                          prefixIcon: Icons.lock,
                          obscureText: !_controller.showPassword.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              _controller.showPassword.value =
                                  !_controller.showPassword.value;
                            },
                            icon: Icon(
                              _controller.showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryActionButton(
                  label: 'Iniciar Sesión',
                  onTap: _hadleSubmit,
                ),
                const Spacer(),
                Text('¿No tienes una cuenta?', style: CustomStyles.caption),
                const SizedBox(height: 16),
                PrimaryActionButton(
                  label: 'Registrarse',
                  decoration: CustomStyles.whiteBoxDecoration,
                  textStyle: CustomStyles.buttonBlackText,
                  onTap: () {
                    Get.toNamed(RouterPaths.register);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
