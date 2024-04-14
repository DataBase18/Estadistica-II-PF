

import 'dart:math';

import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';
import 'package:flutter/cupertino.dart';

class InferenceAboutSampleViewModel extends EventViewModel {


  void changeKnowAlphaSwitch(bool newValue){
    notify(ChangeKnowAlphaEvent(newValue));
  }

  void changeItemTypeInequality (String value){
    notify(ChangeCurrentTypeInequalityH2(value));
  }

  void changeCurrentTypeCalc(int newType){
    notify(ChangeCurrentTypeCalc(newType));
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

  double calcTrialValue({
    required double mean,
    required double M,
    required double sigmaOrStandardDeviation,
    required double n
  }){
    double numerator = mean - M;
    double denominator = sigmaOrStandardDeviation / sqrt(n);
    double zValue = numerator / denominator;
    return zValue;
  }


  void calculate({
    required TextEditingController interestParameterController,
    required TextEditingController h1Controller,
    required TextEditingController h2Controller,
    required String typeInequality,
    required bool knowAlphaValue,
    TextEditingController? criticValueController,
    TextEditingController? alphaValueController,
    required int typeCalc,
    required TextEditingController meanController ,
    required TextEditingController sigmaController,
    required TextEditingController sampleController,
    required TextEditingController deviationSController,
    
  }){
    //validation inputs empty
    if(interestParameterController.text.isEmpty){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidInterestParameterMessage));
      return;
    }else if(double.tryParse(h1Controller.text)==null){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidH1ValueMessage));
      return;
    }else if(double.tryParse(h2Controller.text)==null){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidH2ValueMessage));
      return;
    }else if(double.tryParse(criticValueController?.text??"") == null && !knowAlphaValue){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidCriticValueMessage));
      return;
    }else if(double.tryParse(alphaValueController?.text??"") == null && knowAlphaValue){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidAlphaValueMessage));
      return;
    }else if(double.tryParse(sampleController.text) == null){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidSizeSampleValueMessage));
      return;
    }
    if(typeCalc == 1 || typeCalc == 2){
      if(double.tryParse(meanController.text) == null){
        notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidMeanValueMessage));
        return;
      }
    }else{
      //after, validate data to proportion experiment
    }
    //init decimals values
    double h1 = double.parse(h1Controller.text);
    double h2 = double.parse(h2Controller.text);
    double alphaValue = 0;
    if(knowAlphaValue){
      alphaValue = double.parse(alphaValueController!.text);
    }else{
      //por ahora, dejar así, pero validar si el intervalo izquierdo del calculo
      //de intervalos de confianza es el que se usa para este calculo.
    }
    double n = double.parse(sampleController.text);
    if(typeInequality=="Diferente que:"){
      alphaValue=alphaValue/2;
    }

    //calc
    if(typeCalc == 1){
      double mean = double.parse(meanController.text);
      double sigma = double.parse(sigmaController.text);
      double M = h1;
      double rejectZoneZValue = GlobalMetods.findZNormalValue(alphaValue);
      if(typeInequality=="Diferente que:"){
        //notify(SetCriticsValues(-rejectZoneZValue, rejectZoneZValue));
      }else if(typeInequality=="Mayor que:"){
        //notify(SetRightCriticValue( rejectZoneZValue));
      }else{
        //notify(SetLeftCriticValue( - rejectZoneZValue));
      }
      double zToInference = calcTrialValue(
        mean: mean,
        M: M,
        sigmaOrStandardDeviation: sigma,
        n: n
      );
      print(zToInference);
    }else if(typeCalc == 2){

    }else {
      //calc proportion formulate
    }

  }
}