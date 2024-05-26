

import 'package:fisicapf/models/models.dart';
import 'package:fisicapf/services/services.dart';

class InferenceAboutSampleRepository {
  SQLLiteService service = SQLLiteService();

  Future<dynamic> insertHistory(HistoryModel history) async {
    final response = await service.insertHistory(history);
    return response;
  }
}
