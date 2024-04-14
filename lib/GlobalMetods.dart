
import 'package:fisicapf/GlobalConstants.dart';

class GlobalMetods {

  static String? validatorIsNumber (String? value) {
    if(int.tryParse(value ?? "") == null){
      return GlobalConstants.inputValidatorNumberError;
    }
    return null;
  }

  static String? validatorIsDouble (String? value) {
    if(double.tryParse(value ?? "") == null){
      return GlobalConstants.inputValidatorNumberError;
    }
    return null;
  }

  static String? validatorEmpty (String? value){
    if(value == null || value.isEmpty){
      return GlobalConstants.invalidValueError;
    }
    return null;
  }

  static double findZNormalValue(double valueToFind){
    List<List<double>> normalTable = GlobalConstants.normalTable;
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

  static double findTdStudentValueTn(double n, double alphaValue ){
    if(n==0){
      return 0;
    }
    List<List<double>> tdStudentTable = GlobalConstants.tdStudentTable;

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
}