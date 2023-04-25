import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/data/services/auth/auth_service.dart';
import 'package:qazaqsoft_test/ui/views/login/login_view.dart';
import 'package:qazaqsoft_test/ui/views/user_list_view.dart';
import 'package:qazaqsoft_test/utils/colors.dart';
import 'package:qazaqsoft_test/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      theme: ThemeData(
          primarySwatch: Colors.purple, primaryColor: AppColors.primary),
      home: const LoginView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        usersRoute: (context) => UserListView()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = AuthService.simple().currentUser != null;
    if (isLoggedIn) {
      return UserListView();
    } else {
      return const LoginView();
    }
  }
}
