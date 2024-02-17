
import 'package:flutter/material.dart';

class MenuModel {
  String title;
  String description;
  String? imageSvgPath;
  Widget? screenContent;
  String? screenPath;
  String? imageLottiePath;
  Color? backgroundColor;
  IconData? icon;

  MenuModel({
    required this.title,
    required this.description,
    this.imageSvgPath,
    this.screenContent,
    this.imageLottiePath,
    this.backgroundColor,
    this.icon,
    this.screenPath
  });
}