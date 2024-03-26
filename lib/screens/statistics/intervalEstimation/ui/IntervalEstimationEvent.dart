
import 'package:fisicapf/mvvm/observer.dart';

class ChangeTypeCalcSample extends ViewEvent {
  bool newStatus;
  ChangeTypeCalcSample(this.newStatus):super("ChangeTypeCalcSample");
}