import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell currentChild;

  const CustomBottomNavigation({super.key, required this.currentChild});

  void onItemTapped(int idx) {
    currentChild.goBranch(idx, initialLocation: idx == currentChild.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentChild.currentIndex,
      onTap: (idx) => onItemTapped(idx),
      elevation: 0,
      // Tenemos que indicar al menos 2 hijos. Con uno no funciona.
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favoritos'
        ),
      ]
    );
  }
}
