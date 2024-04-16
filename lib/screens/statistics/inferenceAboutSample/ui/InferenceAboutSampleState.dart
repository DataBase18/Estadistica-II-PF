
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class InferenceAboutSampleState {
  TextEditingController controllerInterestParameter=TextEditingController();
  TextEditingController controllerInterestH1=TextEditingController();
  TextEditingController controllerInterestH2=TextEditingController();
  bool knowAlphaValue=true;
  TextEditingController controllerAlphaValue=TextEditingController();
  TextEditingController controllerCriticValue =TextEditingController();
  List typeInequalityList=[
    "Mayor que:",
    "Diferente que:",
    "Menor que:"
  ];
  String inferenceResultText="";
  String currentTypeInequality = "Diferente que:";
  int currentTypeCalcSelected = 1;

  TextEditingController controllerMean = TextEditingController();
  TextEditingController controllerS = TextEditingController();
  TextEditingController controllerSigma = TextEditingController();
  TextEditingController controllerSample = TextEditingController();

  double? leftCriticalValue ;
  double? rightCriticalValue ;
  double? zValue ;

  List<FlSpot> pointsGauss = [];
  List<FlSpot> pointsLeftIntervalFunction = [];
  List<FlSpot> pointsRightIntervalFunction = [];
  List<FlSpot> pointsToRectZResult = [];
}