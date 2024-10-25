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
}
