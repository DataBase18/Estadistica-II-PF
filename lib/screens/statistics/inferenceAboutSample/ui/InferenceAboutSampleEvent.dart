
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class ChangeKnowAlphaEvent extends ViewEvent {
  bool newValue;
  ChangeKnowAlphaEvent(this.newValue):super("ChangeKnowAlphaEvent");
}

class ChangeCurrentTypeInequalityH2 extends ViewEvent {
  String newValue;
  ChangeCurrentTypeInequalityH2(this.newValue):super("ChangeCurrentTypeInequalityH2");

}

class ChangeCurrentTypeCalc extends ViewEvent {
  int newType;
  ChangeCurrentTypeCalc(this.newType):super("ChangeCurrentTypeCalc");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}

class SetRightCriticValue extends ViewEvent {
  double rightValue;
  SetRightCriticValue(this.rightValue):super("SetRightCriticValue");
}

class SetLeftCriticValue extends ViewEvent {
  double leftValue;
  SetLeftCriticValue(this.leftValue):super("SetLeftCriticValue");
}

class SetZValue extends ViewEvent {
  double zValue;
  SetZValue(this.zValue):super("SetZValue");
}

class SetInferenceText extends ViewEvent {
  String result;
  SetInferenceText(this.result):super("SetInferenceText");
}

class SetGaussBellPoints extends ViewEvent {
  List<FlSpot> points;
  SetGaussBellPoints(this.points):super("SetGaussBellPoints");
}


class SetFunctionLeftInterval extends ViewEvent {
  List<FlSpot> points;
  SetFunctionLeftInterval(this.points):super("SetFunctionLeftInterval");
}

class SetFunctionRightInterval extends ViewEvent {
  List<FlSpot> points;
  SetFunctionRightInterval(this.points):super("SetFunctionRightInterval");
}

class SetRectPointsToZResult extends ViewEvent {
  List<FlSpot> points;
  SetRectPointsToZResult(this.points):super("SetRectPointsToZResult");
}