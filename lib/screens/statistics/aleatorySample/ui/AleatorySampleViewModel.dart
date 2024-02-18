
import 'dart:math';

import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/data/AleatorySampleConstants.dart';
import 'package:fisicapf/screens/statistics/aleatorySample/ui/AleatorySampleEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AleatorySampleViewModel extends EventViewModel{

  void setInterval(TextEditingController a, TextEditingController b){
    String aValueS = a.text;
    String bValueS = b.text;
    
    int? aValue = int.tryParse(aValueS);
    int? bValue = int.tryParse(bValueS);
    
    if(aValue == null || bValue == null){
      notify(ShowSimpleDialog(AleatorySampleConstants.invalidValuesInterval));
    }else if(aValue >= bValue){
      notify(ShowSimpleDialog(AleatorySampleConstants.firstValueLongError));
    }else{
      notify(SetInterval(aValue, bValue));
    }
    
  }

  String getAleatorySelection () {
    int randomNumber = Random().nextInt(101);
    if(randomNumber>50){
      return AleatorySampleConstants.selectedText;
    }
    return AleatorySampleConstants.notSelectedText;
  }
}