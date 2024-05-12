

import 'dart:typed_data';

import 'package:fisicapf/mvvm/observer.dart';

class ChangeFirstRowTitlesCheckBox extends ViewEvent{
  bool newState;
  ChangeFirstRowTitlesCheckBox(this.newState):super("ChangeFirstRowTitlesCheckBox");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}