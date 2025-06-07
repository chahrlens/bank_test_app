import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(vehicle.description),
                            subtitle: Text(vehicle.vim),
                          ),
                        );
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
