import 'package:qazaqsoft_test/data/model/user.dart';
import 'package:qazaqsoft_test/data/services/auth/simple_auth_provider.dart';

import 'auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;

  AuthService(this.provider);

  factory AuthService.simple() => AuthService(SimpleAuthProvider());

  @override
  User? get currentUser => provider.currentUser;

  @override
  Future<void> login({required String email, required String password}) =>
      provider.login(email: email, password: password);

  @override
  Future<List<User>> getUsers() => provider.getUsers();

}
