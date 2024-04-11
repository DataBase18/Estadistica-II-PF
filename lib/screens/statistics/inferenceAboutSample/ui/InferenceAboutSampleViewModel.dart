

import 'dart:math';

import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';

class InferenceAboutSampleViewModel extends EventViewModel {


  void changeKnowAlphaSwitch(bool newValue){
    notify(ChangeKnowAlphaEvent(newValue));
  }

  void changeItemTypeInequality (String value){
    notify(ChangeCurrentTypeInequalityH2(value));
  }

  double findSignificationLevel(double trustPercentage, {String typeInequality = "Diferente que:"}){
    double x = 1;
    if(trustPercentage>1){
      trustPercentage = trustPercentage/100;
    }
    x = x - trustPercentage;
    double significationLevel = x;
    if(typeInequality=="Diferente que:"){
      significationLevel = x/2;
    }
    return significationLevel;
  }

  double calcZValue({
    required double mean,
    required double M,
    required double sigma,
    required double n
  }){
    double numerator = mean - M;
    double denominator = sigma / sqrt(n);
    double zValue = numerator / denominator;
    return zValue;
  }
}