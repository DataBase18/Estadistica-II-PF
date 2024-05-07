

import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/screens/history/ui/HistoryScreen.dart';
import 'package:fisicapf/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeConstants {
  static String physicsMenuItem ="Física";
  static String statisticsMenuItem ="Estadisitica";
  static String historyMenuItem  = "Historial de operaciones";

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
    MenuModel(
        title: HomeConstants.historyMenuItem,
        icon: Icons.history,
        screenContent: HistoryScreen(),
        description: ""
    ),
  ];
}