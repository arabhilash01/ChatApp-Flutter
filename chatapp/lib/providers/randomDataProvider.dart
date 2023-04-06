import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final dataProvider = FutureProvider((ref) async {
  var response = await http.get(Uri.parse('https://random-data-api.com/api/v2/users?size=2'));
  var jsonData = json.decode(response.body);
  return jsonData;
});
