import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project/src/model/model.dart';

Future<List<User>> fetchUsers(int page, int per_page) async {
  final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=$page&per_page=$per_page'));

  //await http.get(Uri.parse('https://reqres.in/api/users'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    List<dynamic> usersJson = data['data'];
    return usersJson.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}
