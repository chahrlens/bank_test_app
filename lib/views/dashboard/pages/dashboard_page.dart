import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:bank_test_app/data/models/vehicle_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:bank_test_app/views/dashboard/controllers/dashboard_controller.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardController _controller;

  void _start() async {
    EasyLoading.show(status: 'Loading vehicles...');
    final result = await _controller.fetchVehicles(null);
    EasyLoading.dismiss();
    if (result != null) {
      EasyLoading.showError(result);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(DashboardController());
    _start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Welcome to the Dashboard',
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
                ElevatedButton(
                  onPressed: () {
                    _start();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;

  const VehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vehicle.model?.name ?? 'Modelo desconocido',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  vehicle.status == 1 ? 'Activo' : 'Inactivo',
                  style: TextStyle(
                    fontSize: 14,
                    color: vehicle.status == 1 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Vehicle Details
            Text(
              'VIM: ${vehicle.vim}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            Text(
              'Color: ${vehicle.color ?? 'No especificado'}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            Text(
              'Tipo de combustible: ${vehicle.fuelType ?? 'No especificado'}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            Text(
              'Transmisión: ${vehicle.transmissionType ?? 'No especificado'}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Mileage
            Text(
              'Kilometraje: ${vehicle.mileage} km',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Registration Date
            Text(
              'Fecha de registro: ${vehicle.registrationDate.toLocal()}'.split(
                ' ',
              )[0],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
