

import 'dart:math';

import 'package:fisicapf/GlobalConstants.dart';
import 'package:fisicapf/GlobalMetods.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/data/IntervalEstimationConstants.dart';
import 'package:flutter/cupertino.dart';

import 'IntervalEstimationEvent.dart';

class IntervalEstimationViewModel extends EventViewModel{





  void calculate({
    required TextEditingController nController,
    required TextEditingController populationController,
    required TextEditingController xController,
    required TextEditingController sOrSigmaController,
    required TextEditingController icController,
    required bool isSampleCalcType,
  }){
    if(xController.text.isEmpty||nController.text.isEmpty||icController.text.isEmpty||sOrSigmaController.text.isEmpty){
      notify(ShowSimpleAlert(IntervalEstimationConstants.insufficientDataToCalcMessage));
      return;
    }
    if(double.tryParse(xController.text)==null){
      notify(ShowSimpleAlert(IntervalEstimationConstants.invalidMeanValue));
      return;
    }
    if(double.tryParse(nController.text)==null){
      notify(ShowSimpleAlert(IntervalEstimationConstants.invalidSampleValue));
      return;
    }
    if(double.tryParse(icController.text)==null){
      notify(ShowSimpleAlert(IntervalEstimationConstants.invalidIcValue));
      return;
    }

    double n = double.parse(nController.text);
    double ic = 0;
    if(double.parse(icController.text)<1){
      ic= 1-double.parse(icController.text);
    }else{
      ic=(100-double.parse(icController.text))/100;
    }
    double mean = double.parse(xController.text);
    double alpha = ic/2;

    //if i know sigma then 1.1
    if(!isSampleCalcType){
      if(double.tryParse(sOrSigmaController.text) == null){
        notify(ShowSimpleAlert(IntervalEstimationConstants.invalidSigmaValueMessage));
        return;
      }
      double sigma = double.parse(sOrSigmaController.text);
      double Z = GlobalMetods.findZNormalValue(alpha);
      double leftInterval = (mean - Z*(sigma/sqrt(n)) );
      double rightInterval = (mean + Z*(sigma/sqrt(n)) );
      double leftIntervalMinDecimals = double.parse(leftInterval.toStringAsFixed(5));
      double rightIntervalMinDecimals = double.parse(rightInterval.toStringAsFixed(5));
      notify(SetResponseResult("$leftIntervalMinDecimals  <=  M  <=  $rightIntervalMinDecimals", IntervalEstimationConstants.knowSigmaExplication));
    }else { //else, if i don't know sigma
      //validation to standard deviation
      if(sOrSigmaController.text.isEmpty){
        notify(ShowSimpleAlert(IntervalEstimationConstants.notStandardDeviationWriteMessage));
        return;
      }
      //if i know population size and n/N > 5%, then : 1.3
      if(populationController.text.isNotEmpty){
        if(double.tryParse(populationController.text)==null){
          notify(ShowSimpleAlert(IntervalEstimationConstants.invalidPopulationValue));
          return;
        }
        double N = double.parse(populationController.text) ;
        double nPercentage = n/N;
        if(nPercentage > 0.05){
          double tn_1 = GlobalMetods.findTdStudentValueTn(n, alpha);
          double S = double.parse(sOrSigmaController.text);
          double leftInterval = mean - (tn_1 * (S/sqrt(n)) * sqrt((N-n)/(N-1)));
          double rightInterval = mean + (tn_1 * (S/sqrt(n)) * sqrt((N-n)/(N-1)));
          double leftIntervalMinDecimals = double.parse(leftInterval.toStringAsFixed(5));
          double rightIntervalMinDecimals = double.parse(rightInterval.toStringAsFixed(5));
          notify(SetResponseResult("$leftIntervalMinDecimals  <=  M  <=  $rightIntervalMinDecimals", IntervalEstimationConstants.notKnowSigmaAndKnowPopulationExplication));
          return ; //after, calc value to 1.3 formula
        }
      }else{
        double tn_1 = GlobalMetods.findTdStudentValueTn(n, alpha);
        double S = double.parse(sOrSigmaController.text);
        double leftInterval = mean - (tn_1 * (S/sqrt(n)) );
        double rightInterval = mean + (tn_1 * (S/sqrt(n)) );
        double leftIntervalMinDecimals = double.parse(leftInterval.toStringAsFixed(5));
        double rightIntervalMinDecimals = double.parse(rightInterval.toStringAsFixed(5));
        notify(SetResponseResult("$leftIntervalMinDecimals  <=  M  <=  $rightIntervalMinDecimals", IntervalEstimationConstants.notKnowSigmaAndPopulationExplication));
        return; //else 1.2
      }

    }
  }
}