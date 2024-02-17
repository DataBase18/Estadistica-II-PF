
import 'package:flutter/material.dart';

class MenuModel {
  String title;
  String description;
  String? imageSvgPath;
  Function()? onTab;
  Widget? screenContent;
  String? imageLottiePath;
  Color? backgroundColor;
  IconData? icon;

  MenuModel({
    required this.title,
    required this.description,
    this.imageSvgPath,
    this.onTab,
    this.screenContent,
    this.imageLottiePath,
    this.backgroundColor,
    this.icon
  });
}