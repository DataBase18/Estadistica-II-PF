
import 'package:excel/excel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class MMCState {
  bool loadingProcess=false;
  bool firstRowTitles = true;
  List<List<dynamic>> table=[];
  TextEditingController projectedValueController=TextEditingController();
  String nameFile ="";
  Excel? excelSelected ;
  double projectValue=0;
  double b=0;
  double a=0;
  double c=0;
  double y=0;
  String equation = "";
  List<LineChartBarData> points = [];
  List<FlSpot> pointsToLine=[];
  String typeCorrelation = "";
  double r  =0;
 }