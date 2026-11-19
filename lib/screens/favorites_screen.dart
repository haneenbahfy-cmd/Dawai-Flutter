import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';
import 'medicine_card.dart';

// ================= FAVORITES SCREEN =================

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LuxuryBackground(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "الأدوية المفضلة",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: favoriteMedicines.isEmpty
                      ? const Center(
                          child: Text(
                            "لم تضيفي أي دواء للمفضلة بعد 💜",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: C.lavender,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView(
                          children: favoriteMedicines.map((medicine) {
                            return MedicineCard(
                              medicine: medicine,
                            );
                          }).toList(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
