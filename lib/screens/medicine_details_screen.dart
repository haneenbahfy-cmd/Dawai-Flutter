import 'package:flutter/material.dart';
import '../core/app_data.dart';
import '../widgets/common_widgets.dart';

// ================= MEDICINE DETAILS =================

class MedicineDetailsScreen extends StatefulWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({
    super.key,
    required this.medicine,
  });

  @override
  State<MedicineDetailsScreen> createState() =>
      _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState
    extends State<MedicineDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;

    final isFavorite = favoriteMedicines.contains(medicine);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            const LuxuryBackground(),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    glassCard(
                      child: Column(
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
                          const SizedBox(height: 15),
                          Text(
                            medicine.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            medicine.category,
                            style: const TextStyle(
                              color: C.lavender,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            medicine.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            medicine.price,
                            style: const TextStyle(
                              color: C.lavender,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "الصيدليات المتوفر فيها",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    ...medicine.pharmacies.map(
                      (pharmacy) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: glassCard(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_pharmacy,
                                color: C.lavender,
                                size: 30,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  pharmacy,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    gradientButton(
                      text: isFavorite
                          ? "إزالة من المفضلة"
                          : "إضافة إلى المفضلة",
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoriteMedicines.remove(medicine);
                          } else {
                            favoriteMedicines.add(medicine);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
