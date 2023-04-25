import 'package:qazaqsoft_test/data/services/auth/auth_exceptions.dart';
import 'package:qazaqsoft_test/data/services/users/users_exceptions.dart';

import '../../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserRepository {
  final _httpSource = "https://jsonplaceholder.typicode.com/users";
  static final UserRepository _instance = UserRepository._internal();
  List<User> _userList = [];

  factory UserRepository() {
    return _instance;
  }

  UserRepository._internal();

  List<User> get userList => _userList;

  bool throwError = true;

  Future<List<User>> fetchUsers() async {
    if (_userList.isNotEmpty) {
      return _userList;
    }
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

  Future<User> getUserByEmail(String email) async{
    for(final user in _userList){
      if(user.email == email) return user;
    }
    throw UserNotFoundAuthException();
  }
}