
import 'package:fisicapf/mvvm/observer.dart';

class ChangeKnowAlphaEvent extends ViewEvent {
  bool newValue;
  ChangeKnowAlphaEvent(this.newValue):super("ChangeKnowAlphaEvent");
}

class ChangeCurrentTypeInequalityH2 extends ViewEvent {
  String newValue;
  ChangeCurrentTypeInequalityH2(this.newValue):super("ChangeCurrentTypeInequalityH2");

}

class ChangeCurrentTypeCalc extends ViewEvent {
  int newType;
  ChangeCurrentTypeCalc(this.newType):super("ChangeCurrentTypeCalc");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}