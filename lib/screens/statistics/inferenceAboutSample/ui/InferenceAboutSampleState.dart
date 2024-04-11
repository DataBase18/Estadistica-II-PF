
import 'package:flutter/cupertino.dart';

class InferenceAboutSampleState {
  TextEditingController controllerInterestParameter=TextEditingController();
  TextEditingController controllerInterestH1=TextEditingController();
  TextEditingController controllerInterestH2=TextEditingController();
  bool knowAlphaValue=false;
  TextEditingController controllerAlphaValue=TextEditingController();
  TextEditingController controllerPercentageTrust =TextEditingController();
  List typeInequalityList=[
    "Mayor que: ",
    "Diferente que:",
    "Menor que:"
  ];
  String inferenceResultText="";
  String currentTypeInequality = "Diferente que:";
}