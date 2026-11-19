import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';
import 'medicine_details_screen.dart';

// ================= MEDICINE CARD =================

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  const MedicineCard({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MedicineDetailsScreen(
                medicine: medicine,
              ),
            ),
          );
        },
        child: glassCard(
          child: Row(
            children: [
              ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: Image.asset(
    medicine.image,
    width: 85,
    height: 85,
    fit: BoxFit.contain,
  ),
),
              
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      medicine.category,
                      style: const TextStyle(
                        color: C.lavender,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      medicine.price,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: C.lavender,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
