import 'package:qazaqsoft_test/data/model/user.dart';

abstract class AuthProvider {
  User? get currentUser;

  Future<void> login({required String email, required String password});

  Future<List<User>> getUsers();
}
