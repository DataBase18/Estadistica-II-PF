

import 'dart:math';

import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/models/HistoryModel.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/data/InferenceAboutSampleConstants.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/repository/InferenceAboutSampleRepository.dart';
import 'package:fisicapf/screens/statistics/inferenceAboutSample/ui/InferenceAboutSampleEvent.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class InferenceAboutSampleViewModel extends EventViewModel {

  InferenceAboutSampleRepository repository;
  InferenceAboutSampleViewModel(this.repository);


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

  double calcProportionValue ({
    required double p,
    required double p0,
    required double n
  }){
    double numerator = p-p0;
    double q0 = 1-p0;
    double denominator = sqrt( (p0*q0)/n );

    return numerator/denominator;
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
    required TextEditingController controllerP,
    required TextEditingController controllerP0
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
    }else if(double.tryParse(controllerP.text) == null && typeCalc ==3){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidPValueMessage));
      return;
    }else if(double.tryParse(controllerP0.text) == null && typeCalc ==3){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidP0ValueMessage));
      return;
    }else if(double.tryParse(meanController.text) == null && typeCalc==1||typeCalc==2 ){
      notify(ShowSimpleAlert(InferenceAboutSampleConstants.noValidMeanValueMessage));
      return;
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
      double p = double.parse(controllerP.text);
      double p0 = double.parse(controllerP0.text);
      zToInference = calcProportionValue(p: p, p0: p0, n: n);
      rejectZoneZValue = GlobalMetods.findTdStudentValueTn(n, alphaValue);
    }

    //clear old data
    notify(SetFunctionRightInterval([]));
    notify(SetFunctionLeftInterval([]));

    //Inference setter data
    String inference = _replaceInferenceValuesFromString(
        InferenceAboutSampleConstants.acceptH1Text,
        interestParameterController: interestParameterController,
        typeInequality: typeInequality,
        h2: h2
    );

    //graph to bell gauss
    graphGaussBellFunction(-5, 5);

    //graph rect to z result
    FlSpot aPoint = FlSpot(zToInference, 0);
    FlSpot bPoint = FlSpot(zToInference, gaussFx(zToInference));
    notify(SetRectPointsToZResult([aPoint, bPoint]));

    if(typeInequality=="Diferente que:"){
      graphRightInterval(rejectZoneZValue,5 );
      graphLeftInterval(-5,-rejectZoneZValue );
      notify(SetRightCriticValue( rejectZoneZValue));
      notify(SetLeftCriticValue( - rejectZoneZValue));
      if(!(zToInference>= -rejectZoneZValue && zToInference <= rejectZoneZValue)){
        inference = _replaceInferenceValuesFromString(
            InferenceAboutSampleConstants.rejectH1Text,
            interestParameterController: interestParameterController,
            typeInequality: typeInequality,
            h2: h2
        );
      }
    }else if(typeInequality=="Mayor que:"){
      graphLeftInterval(rejectZoneZValue,5 );
      if(zToInference>rejectZoneZValue){
        inference = _replaceInferenceValuesFromString(
            InferenceAboutSampleConstants.rejectH1Text,
            interestParameterController: interestParameterController,
            typeInequality: typeInequality,
            h2: h2
        );
      }
      notify(SetRightCriticValue( rejectZoneZValue));
    }else{
      if(zToInference<-rejectZoneZValue){
        inference = _replaceInferenceValuesFromString(
          InferenceAboutSampleConstants.rejectH1Text,
          interestParameterController: interestParameterController,
          typeInequality: typeInequality,
          h2: h2
        );
      }
      graphLeftInterval(-5,-rejectZoneZValue );
      notify(SetLeftCriticValue( - rejectZoneZValue));
    }
    HistoryModel history =  HistoryModel(
      date: DateTime.now(),
      typeDesc: InferenceAboutSampleConstants.historyText,
      value: inference
    );
    repository.insertHistory(history).then((value) {return null;});
    notify(SetInferenceText(inference));
    notify(SetZValue(zToInference));

  }

  String _replaceInferenceValuesFromString(String str, {
    required TextEditingController interestParameterController,
    required String typeInequality,
    required double h2
  }){
    return str.replaceAll("_PARAMETER_", interestParameterController.text.toLowerCase())
        .replaceAll("_INEQUALITY_", typeInequality.toLowerCase())
        .replaceAll("_H2_", h2.toStringAsFixed(4).toString());
  }

  double gaussFx (double x){
    num function = ((-pow(x,2))/2);
    num base =1.5;
    return pow(base, function).toDouble();
  }

  void graphGaussBellFunction (double leftInterval, double rightInterval){
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