

import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:fisicapf/mvvm/observer.dart';
import 'package:fl_chart/fl_chart.dart';

class ChangeFirstRowTitlesCheckBox extends ViewEvent{
  bool newState;
  ChangeFirstRowTitlesCheckBox(this.newState):super("ChangeFirstRowTitlesCheckBox");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}

class SetDataResults extends ViewEvent {
  List<List<dynamic>> data;
  double b;
  double a;
  double c;
  double y;
  String yEquation;
  List<LineChartBarData> points;
  List<FlSpot> pointsToDrawRect;
  String typeCorrelation ;
  double r ;
  double eS;
  SetDataResults(this.data, {
    required this.b,
    required this.a,
    required this.c,
    required this.y,
    required this.yEquation,
    required this.points,
    required this.pointsToDrawRect,
    required this.r,
    required this.typeCorrelation,
    required this.eS
  }):super("SetDataResults");
}

class SetExcel extends ViewEvent {
  Excel excel;
  String nameExcel;
  SetExcel(this.excel, this.nameExcel):super("Excel");
}