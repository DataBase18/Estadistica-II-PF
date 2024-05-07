
import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/mvvm/observer.dart';

class ShowSimpleAlert extends ViewEvent{
  String message;
  ShowSimpleAlert(this.message):super("ShowSimpleAlert");
}

class SetHistory extends ViewEvent {
  List<HistoryModel> history;
  SetHistory(this.history):super("SetHistory");
}

class SetLoadingScreen extends ViewEvent {
  bool newState;
  SetLoadingScreen(this.newState):super("SetLoadingScreen");
}