
import 'package:fisicapf/mvvm/observer.dart';

class SetCurrentZIndex extends ViewEvent {
  int newIndex;
  SetCurrentZIndex(this.newIndex):super("SetCurrentZIndex");
}

class SetSample extends ViewEvent {
  num sample;
  SetSample(this.sample):super("SetSample");
}

class ShowSimpleAlert extends ViewEvent {
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}