import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';
import 'medicine_card.dart';

// ================= MEDICINES SCREEN =================

class MedicinesScreen extends StatefulWidget {
  final String searchText;

  const MedicinesScreen({
    super.key,
    this.searchText = "",
  });

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  String search = "";

  @override
  void initState() {
    super.initState();
    search = widget.searchText;
  }

  @override
  Widget build(BuildContext context) {
    final filteredMedicines = medicines.where((medicine) {
      return medicine.name.toLowerCase().contains(search.toLowerCase()) ||
          medicine.category.contains(search);
    }).toList();

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
                  "قائمة الأدوية",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  textDirection: TextDirection.rtl,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  decoration: fieldDecoration(
                    "ابحث عن دواء",
                    Icons.search,
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    children: filteredMedicines.isEmpty
                        ? const [
                            Text(
                              "لا توجد أدوية مطابقة",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ]
                        : filteredMedicines.map((medicine) {
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
