import 'package:bank_test_app/data/constants/custom_text_style.dart';
import 'package:bank_test_app/providers/global_providers.dart';
import 'package:bank_test_app/widgets/layout.dart';
import 'package:bank_test_app/widgets/primary_action_button.dart';
import 'package:bank_test_app/widgets/vehicle_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bank_test_app/views/dashboard/controllers/dashboard_controller.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late DashboardController _controller;

  void _start() async {
    EasyLoading.show(status: 'Loading vehicles...');
    final result = await _controller.fetchVehicles(null);
    EasyLoading.dismiss();
    if (result != null) {
      EasyLoading.showError(result);
    }
  }

  void _handleLogout() {
    ref.read(userProviderWithOutNotifier).logout();
    Get.offAllNamed('/login');
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(DashboardController());
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Lista de Vehículos',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (_controller.vehicles.isEmpty) {
                    return const Center(child: Text('No vehicles found.'));
                  }
                  return ListView.builder(
                    itemCount: _controller.vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = _controller.vehicles[index];
                      return VehicleCard(vehicle: vehicle);
                    },
                  );
                }),
              ),
              PrimaryActionButton(
                decoration: CustomStyles.whiteBoxDecoration,
                textStyle: CustomStyles.buttonWhiteText,
                label: 'Cerrar sesión',
                onTap: _handleLogout,
              ),
            ],
          );
        },
      ),
    );
  }
}
