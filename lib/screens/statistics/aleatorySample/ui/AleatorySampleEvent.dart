
import 'package:fisicapf/mvvm/observer.dart';

class SetInterval extends ViewEvent {
  int a;
  int b;
  SetInterval(this.a, this.b):super("SetInterval");
}

class ShowSimpleDialog extends ViewEvent {
  String message;
  ShowSimpleDialog(this.message):super("ShowSimpleDialog");
}

class AddValueManuallyToList extends ViewEvent {
  String value;
  AddValueManuallyToList(this.value):super("AddValueManuallyToList");
}