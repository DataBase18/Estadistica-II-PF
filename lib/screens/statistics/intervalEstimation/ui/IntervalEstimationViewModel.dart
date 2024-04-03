

import 'dart:math';

import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/intervalEstimation/data/IntervalEstimationConstants.dart';
import 'package:flutter/cupertino.dart';

import 'IntervalEstimationEvent.dart';

class IntervalEstimationViewModel extends EventViewModel{

  double findZNormalValue(double valueToFind){
    List<List<double>> normalTable = IntervalEstimationConstants.normalTable;
    double differenceAcceptation = (normalTable[1][1] - valueToFind).abs();
    double zFind = normalTable[0][1]+normalTable[1][0];

    for(int r=1; r<normalTable.length; r++){
      for(int c=1; c<normalTable[r].length; c++){
        double currentValueToTable = normalTable[r][c];
        double currentDifference= (currentValueToTable-valueToFind).abs();
        if(currentDifference<differenceAcceptation){
          differenceAcceptation = currentDifference;
          zFind = normalTable[r][0]+normalTable[0][c];
        }
        if(differenceAcceptation==0){
          break;
        }
      }
      if(differenceAcceptation==0){
        break;
      }
    }
    return zFind;
  }

  double findTdStudentValueTn(double n, double alphaValue ){
    if(n==0){
      return 0;
    }
    List<List<double>> tdStudentTable = IntervalEstimationConstants.tdStudentTable;

    double nMinusOneAcceptationDiff = (tdStudentTable[1][0] - (n-1) ).abs();
    int indexRowSampleMinusOneFind = 1;

    //find index to pater list to row (n-1)
    for(int row = 1; row<tdStudentTable.length ; row ++){
      double currentTValue = tdStudentTable[row][0];
      double actualDiff = (currentTValue-(n-1)).abs();
      if(actualDiff == 0){
        indexRowSampleMinusOneFind = row;
        break;
      }
      if(actualDiff < nMinusOneAcceptationDiff){
        indexRowSampleMinusOneFind=row;
      }
    }

    double headAcceptationDiff = (tdStudentTable[0][1] - alphaValue).abs();
    int indexColAlphaValueFind = 1;

    //find index to header list (alpha)
    for(int col = 1; col < tdStudentTable[0].length; col++){
      double currentHeadValue = tdStudentTable[0][col];
      double currentDiff = (currentHeadValue - alphaValue).abs();
      if(currentDiff == 0){
        indexColAlphaValueFind = col;
        break;
      }
      if(currentDiff < headAcceptationDiff){
        headAcceptationDiff = currentDiff;
      }
    }

    double tnValue = tdStudentTable[indexRowSampleMinusOneFind][indexColAlphaValueFind];
    return tnValue;
  }

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
      double Z = findZNormalValue(alpha);
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
          double tn_1 = findTdStudentValueTn(n, alpha);
          double S = double.parse(sOrSigmaController.text);
          double leftInterval = mean - (tn_1 * (S/sqrt(n)) * sqrt((N-n)/(N-1)));
          double rightInterval = mean + (tn_1 * (S/sqrt(n)) * sqrt((N-n)/(N-1)));
          double leftIntervalMinDecimals = double.parse(leftInterval.toStringAsFixed(5));
          double rightIntervalMinDecimals = double.parse(rightInterval.toStringAsFixed(5));
          notify(SetResponseResult("$leftIntervalMinDecimals  <=  M  <=  $rightIntervalMinDecimals", "IntervalEstimationConstants.knowSigmaExplication"));
          return ; //after, calc value to 1.3 formula
        }
      }else{
        return; //else 1.2
      }

    }
  }
}