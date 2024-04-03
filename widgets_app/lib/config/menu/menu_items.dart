import 'package:flutter/material.dart';

// La idea es ir añadiendo aquí cada una de las opciones del menú que vayamos haciendo.
class MenuItem {

  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  // Constante porque una vez creados los objetos nunca van a cambiar.
  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Botones',
    subTitle: 'Varios botones en Flutter',
    link: '/buttons',
    icon: Icons.smart_button_outlined
  ),

  MenuItem(
    title: 'Tarjetas',
    subTitle: 'Un contenedor estilizado',
    link: '/cards',
    icon: Icons.credit_card
  ),
];
