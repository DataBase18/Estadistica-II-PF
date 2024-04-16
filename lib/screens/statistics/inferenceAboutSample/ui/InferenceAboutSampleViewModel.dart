

import 'dart:math';

import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';
import 'package:fl_chart/fl_chart.dart';
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

    double rejectZoneZValue =0;
    double zToInference = 0;
    double sigmaOrS = 0;
    double mean = 0;


    //calc
    if(typeCalc == 1 || typeCalc == 2){
      mean = double.parse(meanController.text);
      double M = h1;
      if(typeCalc == 1){
        sigmaOrS = double.parse(sigmaController.text);
        rejectZoneZValue = GlobalMetods.findZNormalValue(alphaValue);
      }else{
        rejectZoneZValue = GlobalMetods.findTdStudentValueTn(n, alphaValue);
        sigmaOrS = double.parse(deviationSController.text);
      }

      zToInference = calcTrialValue(
        mean: mean,
        M: M,
        sigmaOrStandardDeviation: sigmaOrS,
        n: n
      );
    } else {
      //calc proportion formulate
    }

    //clear old data
    notify(SetFunctionRightInterval([]));
    notify(SetFunctionLeftInterval([]));

    //Inference setter data
    String inference = "${InferenceAboutSampleConstants.acceptH1Text.replaceAll("_PARAMETER_", interestParameterController.text)}"
        "Extremo izquierdo: -$rejectZoneZValue\nExtremo derecho: $rejectZoneZValue\nZ: $zToInference";

    graph(-5, 5);

    if(typeInequality=="Diferente que:"){
      graphRightInterval(rejectZoneZValue,5 );
      graphLeftInterval(-5,-rejectZoneZValue );
      notify(SetRightCriticValue( rejectZoneZValue));
      notify(SetLeftCriticValue( - rejectZoneZValue));
      if(!(zToInference>= -rejectZoneZValue && zToInference <= rejectZoneZValue)){
        inference = "${InferenceAboutSampleConstants.rejectH1Text.replaceAll("_PARAMETER_", interestParameterController.text)} es"
            "Extremo izquierdo: -$rejectZoneZValue\nExtremo derecho: $rejectZoneZValue\nZ: $zToInference";
      }
    }else if(typeInequality=="Mayor que:"){
      graphLeftInterval(rejectZoneZValue,5 );
      if(zToInference>rejectZoneZValue){
        inference = "${InferenceAboutSampleConstants.rejectH1Text.replaceAll("_PARAMETER_", interestParameterController.text)}"
            "Extremo derecho: $rejectZoneZValue\nZ: $zToInference";
      }
      notify(SetRightCriticValue( rejectZoneZValue));
    }else{
      if(zToInference<-rejectZoneZValue){
        inference = "${InferenceAboutSampleConstants.rejectH1Text.replaceAll("_PARAMETER_", interestParameterController.text)}"
            "Extremo izquierdo: -$rejectZoneZValue\nZ: $zToInference";
      }
      graphLeftInterval(-5,-rejectZoneZValue );
      notify(SetLeftCriticValue( - rejectZoneZValue));
    }
    notify(SetInferenceText(inference));
    notify(SetZValue(zToInference));

  }
  double gaussFx (double x){
    num function = ((-pow(x,2))/2);
    num base =1.5;
    return pow(base, function).toDouble();
  }

  void graph (double leftInterval, double rightInterval){
    List<FlSpot> points = [];
    for(double i = leftInterval; i<rightInterval; i += 0.1 ){
      points.add(
        FlSpot(i, gaussFx(i))
      );
    }
    notify(SetGaussBellPoints(points));
  }

  void graphLeftInterval (  double initialX, double limitX, ){
    List<FlSpot> points = [];
    for(double i = initialX; i<limitX; i += 0.01 ){
      points.add(
        FlSpot(i, gaussFx(i))
      );
    }
    notify(SetFunctionLeftInterval(points));
  }
  void graphRightInterval (  double initialX, double limitX, ){
    List<FlSpot> points = [];
    for(double i = initialX; i<limitX; i += 0.01 ){
      points.add(
          FlSpot(i, gaussFx(i))
      );
    }
    notify(SetFunctionRightInterval(points));
  }
}