
import 'package:fisicapf/mvvm/observer.dart';
import 'package:flutter/material.dart';

class SetCurrentMenu extends ViewEvent {
  Widget currentPage;
  int currentIndex;
  SetCurrentMenu({required this.currentPage, required this.currentIndex}):super("SetCurrentMenu");
}