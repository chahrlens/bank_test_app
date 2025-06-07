import 'package:bank_test_app/data/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          title: const Text('Dashboard'),
          actionsIconTheme: IconThemeData(color: AppColors.white),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.darkGreen,
                AppColors.mediumGreen,
                AppColors.mediumGreen,
                AppColors.lightGreen,
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
