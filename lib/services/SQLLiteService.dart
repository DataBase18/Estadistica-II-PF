
 

import 'package:fisicapf/models/ErrorModel.dart';
import 'package:fisicapf/models/HistoryModel.dart';
import 'package:sqflite/sqflite.dart';

class SQLLiteService {

  static Future<void> initDataBase() async {
    try{
      final databasePath = await getDatabasesPath();
      final path = '$databasePath/umgPF.db';
      final db = await openDatabase(
        path,
        version: 1,
      );

      db.execute('''
        CREATE TABLE IF NOT EXISTS statics_history (  
          type_desc TEXT,
          value TEXT,
          date TEXT
        );
      ''');
      db.close();
    }catch(e){
      print("ABNER DEBUG $e");
    }
  }

  Future<dynamic> getHistory () async {
    try{
      final databasePath = await getDatabasesPath();
      final path = '$databasePath/umgPF.db';
      final db = await openDatabase(
        path,
        version: 1 ,
      );
      final List<Map<String, dynamic>> rows = await db.query('statics_history');
      List<HistoryModel> history = [];
      for(var row in rows){
        HistoryModel finalRow = HistoryModel.fromJson(row);
        history.add(finalRow);
      }
      return history;
    }catch(e){
      return ErrorModel(message: "No se pudo recuperar el historial de operaciones", exception: e.toString());
    }
  }

  Future<dynamic> insertHistory(HistoryModel historyRow) async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/umgPF.db';
    final db = await openDatabase(
      path,
      version: 1,
    );
    try{
      final response = await db.insert("statics_history", historyRow.toJson());
      return response;
    }catch(e){
      return ErrorModel(message: "No se pudo insertar el historial", exception: e.toString());
    }
  }

}