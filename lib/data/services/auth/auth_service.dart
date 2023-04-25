import 'package:flutter/cupertino.dart';
import 'package:qazaqsoft_test/data/services/auth/auth_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../users/UsersRepository.dart';

class AuthProvider with ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    _checkCredentials(email, password);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> _checkCredentials(String email, String password) async {
    if (email.isEmpty && password.isEmpty) throw WrongEmailOrPasswordAuthException();
    await userRepository.getUserByEmail(email);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      _isLoggedIn = true;
    }
    notifyListeners();
  }
}
