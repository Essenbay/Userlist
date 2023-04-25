import 'package:flutter/material.dart';
import 'package:qazaqsoft_test/data/model/user.dart';
import 'package:logging/logging.dart';
import 'package:qazaqsoft_test/data/services/auth/auth_service.dart';
import 'package:qazaqsoft_test/utils/colors.dart';


//TODO: centralize header when list is focused.
class UserListView extends StatefulWidget {
  UserListView({Key key = const ValueKey('user_list')}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  List<User> userList = <User>[];
  final logger = Logger('MyLogger');


  @override
  void initState() {
    super.initState();
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
            future: AuthService.simple().getUsers(),
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
                        const Text(
                          "Не удалось загрузить информацию",
                          style: TextStyle(
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
