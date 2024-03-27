
import 'package:fisicapf/mvvm/observer.dart';

class ChangeTypeCalcSample extends ViewEvent {
  bool newStatus;
  ChangeTypeCalcSample(this.newStatus):super("ChangeTypeCalcSample");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}

class SetResponseResult extends ViewEvent{
  String result;
  String infoResult;
  SetResponseResult(this.result,this.infoResult):super("SetResponseResult");
}