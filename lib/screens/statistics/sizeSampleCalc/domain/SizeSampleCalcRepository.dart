

import 'package:fisicapf/models/HistoryModel.dart';
import 'package:fisicapf/services/services.dart';

class SizeSampleCalcRepository {
  SQLLiteService service = SQLLiteService();
  Future<dynamic> insertHistory(HistoryModel history) async {
    final response = await service.insertHistory(history);
    return response;
  }
}