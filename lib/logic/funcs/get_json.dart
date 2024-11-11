// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GetJson {
  Future<List<Map<String, dynamic>>> getCollectedData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonDataList = prefs.getStringList('collectedDataList');

    if (jsonDataList != null) {
      return jsonDataList.map((jsonData) {
        return json.decode(jsonData) as Map<String, dynamic>;
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> printCollectedData() async {
    List<Map<String, dynamic>> data = await getCollectedData();

    if (data.isEmpty) {
      print('Нет данных для вывода.');
    } else {
      print('Список данных:');
      for (var item in data) {
        print(item);
      }
    }
  }
}
