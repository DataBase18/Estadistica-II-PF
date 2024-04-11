
import 'package:fisicapf/mvvm/observer.dart';

class ChangeKnowAlphaEvent extends ViewEvent {
  bool newValue;
  ChangeKnowAlphaEvent(this.newValue):super("ChangeKnowAlphaEvent");
}

class ChangeCurrentTypeInequalityH2 extends ViewEvent {
  String newValue;
  ChangeCurrentTypeInequalityH2(this.newValue):super("ChangeCurrentTypeInequalityH2");

}