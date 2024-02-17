
import 'package:flutter/material.dart';

class MenuModel {
  String title;
  String description;
  String? imageSvgPath;
  Function()? onTab;
  String? screenPath;
  String? imageLottiePath;
  Color? backgroundColor;
  IconData? icon;

  MenuModel({
    required this.title,
    required this.description,
    this.imageSvgPath,
    this.onTab,
    this.screenPath,
    this.imageLottiePath,
    this.backgroundColor,
    this.icon
  });
}