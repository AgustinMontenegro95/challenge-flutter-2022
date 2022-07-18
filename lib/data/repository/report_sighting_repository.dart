import 'dart:math';

import 'package:http/http.dart' as http;

class ReportSightingRepository {
  Future<http.Response?> reportSighting({
    required String characterName,
  }) async {
    try {
      DateTime dateTime = DateTime.now();
      var userId = Random();
      http.Response response = await http
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        'userId': userId.nextInt(1000).toString(),
        'dateTime': dateTime.toString(),
        'character_name': characterName,
      });
      return response;
    } catch (e) {
      return null;
    }
  }
}
