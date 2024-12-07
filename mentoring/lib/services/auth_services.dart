import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  String _name = '';
  String _email = '';
  bool _isLoggedIn = false;

  String get name => _name;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.234.211:5000/api/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': _name, 'email': _email}),
      );

      if (response.statusCode == 201) {
        _isLoggedIn = true;
      } else {
        throw Exception('Erreur lors de la connexion');
      }
    } catch (error) {
      throw Exception('Erreur réseau: $error');
    }
    notifyListeners();
  }

  Future<Map<String, String>> fetchUserData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.234.211:5000/api/users'));
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        if (users.isNotEmpty) {
          return {
            "name": users.last['name'],
            "email": users.last['email'],
          };
        } else {
          throw Exception('Aucun utilisateur trouvé');
        }
      } else {
        throw Exception('Erreur lors de la récupération des données');
      }
    } catch (error) {
      throw Exception('Erreur réseau: $error');
    }
  }
}
