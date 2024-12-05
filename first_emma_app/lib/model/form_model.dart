
import 'package:flutter/material.dart';

class FormModel with ChangeNotifier{
  String _email = '';
  String _name = '';

  String get email => _email;
  String get name => _name;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  bool get isValid {
    return _email.isNotEmpty && _email.contains('@') && _name.isNotEmpty;
  }
}