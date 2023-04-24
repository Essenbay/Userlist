import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/data/model/user.dart';
import 'package:qazaqsoft_test/data/services/api/users_api.dart';
import 'package:logging/logging.dart';


class UserList extends StatefulWidget {
  UserList({Key key = const ValueKey('user_list')}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> userList = <User>[];
  final logger = Logger('MyLogger');

  void getUsers() async {
    UserApi.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        logger.info(list);
        userList = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index].username),
                  subtitle: Text(userList[index].phone),
                  leading:
                      Image.asset('assets/user_icon.png', width: 50, height: 50),
                );
              }),
        ));
  }
}
