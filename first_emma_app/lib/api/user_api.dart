
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> createUser(String email, String name) async {
  final url = Uri.parse('http://192.168.228.165:5000/api/users');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'name': name}),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Erreur lors de la création de l\'utilisateur : ${response.body}');
  }
}

Future<Map<String, dynamic>> fetchUserData(String userId) async {
  final url = Uri.parse('http://192.168.228.165:5000/api/users/$userId');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erreur lors de la récupération des données utilisateur');
  }
}
