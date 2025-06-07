import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:bank_test_app/providers/global_providers.dart';
import 'package:bank_test_app/routes/router_paths.dart';
import 'package:bank_test_app/views/home/controllers/register_controller.dart';
import 'package:bank_test_app/widgets/custom_input.dart';
import 'package:bank_test_app/widgets/home_layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  late RegisterController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _handleSubmit() async {
    if (isLoading) return;
    if (_formKey.currentState?.validate() ?? false) {
      isLoading = true;
      EasyLoading.show(status: "Loading...");
      final User? user = await _controller.register();
      EasyLoading.dismiss();
      ref.read(userProvider.notifier).setUser(user);
      Get.offAllNamed(RouterPaths.dashboard);
    } else {
      EasyLoading.showError('Error al crear usuario.\nInténtalo de nuevo.');
    }
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(RegisterController());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: HomeLayout(
        title: 'Registrarse',
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text('Bienvenido', style: CustomStyles.headline1),
                Text(
                  'Crea una cuenta para continuar',
                  style: CustomStyles.bodyText1,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInput(
                        controller: _controller.nameController,
                        label: 'Nombre Completo',
                        validator: _controller.validateName,
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 8),
                      CustomInput(
                        controller: _controller.emailController,
                        label: 'Correo Electrónico',
                        validator: _controller.validateEmail,
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      CustomInput(
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
                      const SizedBox(height: 8),
                      CustomInput(
                        controller: _controller.passwordController,
                        label: 'Confirmar Contraseña',
                        validator: _controller.validateConfirmPassword,
                        prefixIcon: Icons.lock,
                        obscureText: !_controller.showConfirmPassword.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _controller.showConfirmPassword.value =
                                !_controller.showConfirmPassword.value;
                          },
                          icon: Icon(
                            _controller.showConfirmPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryActionButton(label: 'Registrarse', onTap: _handleSubmit),
                const Spacer(),
                Text('¿Ya tienes una cuenta?', style: CustomStyles.caption),
                PrimaryActionButton(
                  label: 'Iniciar Sesión',
                  decoration: CustomStyles.whiteBoxDecoration,
                  textStyle: CustomStyles.buttonBlackText,
                  onTap: () {
                    Get.toNamed(RouterPaths.login);
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
