import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        currentIndex: navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Flotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_rounded),
            label: 'Rutas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        onTap: _goBranch,
      ),
      body: navigationShell,
    );
  }
}
