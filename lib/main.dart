import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/ui/views/user_list_page.dart';
import 'package:qazaqsoft_test/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      theme: ThemeData(
          primarySwatch: Colors.purple, primaryColor: AppColors.primary),
      home: UserListPage(),
    );
  }
}
