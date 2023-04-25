import 'package:qazaqsoft_test/data/services/auth/auth_exceptions.dart';

import '../../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth_provider.dart';

class SimpleAuthProvider implements AuthProvider {
  final _httpSource = "https://jsonplaceholder.typicode.com/users";

  static final SimpleAuthProvider _instance = SimpleAuthProvider._internal();
  List<User> _userList = [];

  factory SimpleAuthProvider() {
    return _instance;
  }

  SimpleAuthProvider._internal() {
    getUsers();
  }

  @override
  User? currentUser;

  @override
  Future<List<User>> getUsers() async {
    final response =
        await http.get(Uri.parse(_httpSource));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      _userList = list.map((model) => User.fromJson(model)).toList();
      return _userList;
    } else {
      throw DataLoadError();
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    if (email.isEmpty && password.isEmpty) throw WrongEmailOrPasswordAuthException();

    //Add user logging logic
    currentUser = User(0, "", "", "");
  }
}