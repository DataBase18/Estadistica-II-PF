

import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeConstants {
  static String physicsMenuItem ="Física";
  static String statisticsMenuItem ="Estadisitica";

  static List<MenuModel> drawerMenus = [
    MenuModel(
        title: HomeConstants.statisticsMenuItem,
        icon: Icons.add_chart_rounded,
        screenContent: StatisticsScreen(),
        description: ""
    ),
    MenuModel(
        title: HomeConstants.physicsMenuItem,
        icon: Icons.accessibility_new_outlined,
        screenContent: PhysicalScreen(),
        description: ""
    ),

  ];
}