

import 'package:fisicapf/models/models.dart';
import 'package:intl/intl.dart';

class HistoryState {
  bool loadingScreen = true;
  List<HistoryModel> history = [];
  DateFormat dateFormate = DateFormat('dd-MM-yyyy HH:mm');
}