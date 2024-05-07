
import 'dart:math';

import 'package:fisicapf/models/HistoryModel.dart';
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/mvvm/viewModel.dart';
import 'package:fisicapf/screens/statistics/sizeSampleCalc/data/SizeSampleConstants.dart';
import 'package:fisicapf/screens/statistics/sizeSampleCalc/ui/SizeSampleCalcEvent.dart';

import '../domain/SizeSampleCalcRepository.dart';

class SizeSampleCalcViewModel extends EventViewModel {

  SizeSampleCalcViewModel(this.repository);

  SizeSampleCalcRepository repository;

  double getZValue (int trust){
    switch (trust){
      case 90:
        return 1.64;
      case 91:
        return 1.70;
      case 92:
        return 1.75;
      case 93:
        return 1.81;
      case 94:
        return 1.88;
      case 96:
        return 2.05;
      case 97:
        return 2.17;
      case 98:
        return 2.33;
      case 99:
        return 2.58;
      default:
        return 1.96;
    }
  }

  void changeCurrentZ (int newIndex ){
    notify(SetCurrentZIndex(newIndex));
  }

  void calcSample ({
    int? N,
    int? zTempValue,
    int? PTemp,
    int? QTemp,
    int? ETemp,
  }){
    double z = getZValue(zTempValue ?? 0);
    double p = SizeSampleConstants.defaultP;
    double q = SizeSampleConstants.defaultQ;
    double e = SizeSampleConstants.defaultE;

    if(PTemp!=null) {
      p = PTemp.toDouble()/100;
    }
    if(QTemp!=null) {
      q = QTemp.toDouble()/100;
    }
    if(ETemp!=null) {
      e = ETemp.toDouble()/100;
    }

    num sample = 0 ;
    sample = ( pow(z, 2) * p * q ) / (pow(e,2));
    if(N != null){
      sample = (N*pow(z,2)*p*q) / (((N-1) * pow(e,2)) + (pow(z,2) *p *q));
    }

    notify(SetSample(sample));

  }

  void insertHistory({
    required double p,
    required double q,
    required double e,
    required int sizePopulation,
    required int trustPercentage,
    required double sizeSampleResult
  }){
    String valueHistory = "Calculo de muestra con $p "
        "probabilidad de exito, $q probabilidad de rechazo, $e porcentaje de error,"
        " y una poblacion de $sizePopulation. Se debe elegir una muestra de $sizeSampleResult";
    HistoryModel history = HistoryModel(
      typeDesc: SizeSampleConstants.titleHistory,
      value: valueHistory,
      date: DateTime.now(),
    );
    repository.insertHistory(history).then((value) {
      if(value is ErrorModel){
        notify(ShowSimpleAlert("${value.message} ${value.exception}"));
      }
    });
  }
}