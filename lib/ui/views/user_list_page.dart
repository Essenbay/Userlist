import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/data/model/user.dart';
import 'package:logging/logging.dart';
import 'package:qazaqsoft_test/utils/colors.dart';

import '../../data/services/users/UsersRepository.dart';

//TODO: centralize header when list is focused.
class UserListPage extends StatefulWidget {
  UserListPage({Key key = const ValueKey('user_list')}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<User> userList = <User>[];
  final logger = Logger('MyLogger');
  final UserRepository userRepository = UserRepository();

  void getUsers() async {
    try {
      List<User> userList = await userRepository.fetchUsers();
      setState(() {
        this.userList = userList;
      });
    } catch (e) {
      logger.info('Error fetching users: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 80,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                'Пользователи',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          FutureBuilder<List<User>>(
            future: userRepository.fetchUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/error_icon.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          snapshot.error.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: const Size(200, 50),
                          ),
                          child: const Text(
                            'Обновить',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                List<User> userList = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          userList[index].username,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userList[index].email),
                            Text(
                              userList[index].phone,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        leading: Image.asset(
                          'assets/user_icon.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    childCount: userList.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
