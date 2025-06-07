import 'package:bank_test_app/data/models/vehicle_model.dart';
import 'package:flutter/material.dart';

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
            // description
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

            Text(
              'Kilometraje: ${vehicle.mileage} km',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            Text(
              'Fecha de registro: ${vehicle.registrationDate.toLocal()}'.split(
                ' ',
              )[0],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),

            // Optional image
            if (vehicle.imageUrl != null && vehicle.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.network(
                  vehicle.imageUrl!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
