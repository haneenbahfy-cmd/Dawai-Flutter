import 'package:flutter/material.dart';
import '../core/app_data.dart';
import 'home_content.dart';
import 'medicines_screen.dart';
import 'pharmacies_screen.dart';
import 'favorites_screen.dart';

// ================= HOME SCREEN =================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeContent(),
    MedicinesScreen(),
    PharmaciesScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: C.dark,
        body: screens[selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
  backgroundColor: const Color(0xFF241632),
  currentIndex: selectedIndex,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white70,
  type: BottomNavigationBarType.fixed,
  onTap: (index) {
    setState(() {
      selectedIndex = index;
    });
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "الرئيسية",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.medication_outlined),
      activeIcon: Icon(Icons.medication),
      label: "الأدوية",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_pharmacy_outlined),
      activeIcon: Icon(Icons.local_pharmacy),
      label: "الصيدليات",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      activeIcon: Icon(Icons.favorite),
      label: "المفضلة",
    ),
  ],
),
      )
    );
  }
}
