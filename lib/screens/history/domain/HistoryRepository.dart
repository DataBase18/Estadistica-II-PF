

import 'package:fisicapf/services/services.dart';

class HistoryRepository {
  SQLLiteService service = SQLLiteService();

  Future<dynamic> getAllHistory() async {
    final response = await service.getHistory();
    return response;
  }
}