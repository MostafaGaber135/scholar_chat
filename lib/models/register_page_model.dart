import 'package:flutter/material.dart';

class RegisterPageModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  String? _email;
  String? get email => _email;

  String? _password;
  String? get password => _password;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void toggleObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void setEmail(String? value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String? value) {
    _password = value;
    notifyListeners();
  }
}
