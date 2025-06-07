import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:bank_test_app/main.dart';
import 'package:bank_test_app/providers/global_providers.dart';
import 'package:bank_test_app/routes/router_paths.dart';
import 'package:bank_test_app/views/home/controllers/login_controller.dart';
import 'package:bank_test_app/widgets/custom_input.dart';
import 'package:bank_test_app/widgets/home_layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late LoginController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _handleLogin() async {
    if (isLoading) return;
    if (_formKey.currentState?.validate() ?? false) {
      isLoading = true;
      EasyLoading.show(status: 'Loading...');
      final User? user = await _controller.login();
      EasyLoading.dismiss();
      if (user != null) {
        ref.read(userProvider.notifier).setUser(user);
        container.read(userProviderWithOutNotifier).setUser(user);
        Get.offAllNamed(RouterPaths.dashboard);
      } else {
        _controller.showErrors.value = true;
        EasyLoading.showError(
          'Error al iniciar sesión. Por favor, inténtalo de nuevo.',
        );
      }
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(LoginController());
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.passwordController.dispose();
    super.dispose();
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
                      Obx(
                        () =>
                            _controller.showErrors.value
                                ? Text(
                                  'Usuario invalido o incorrecta.',
                                  style: CustomStyles.errorText,
                                )
                                : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryActionButton(
                  label: 'Iniciar Sesión',
                  onTap: _handleLogin,
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
