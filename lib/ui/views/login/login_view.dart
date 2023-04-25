import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:qazaqsoft_test/data/services/auth/auth_service.dart';
import 'package:qazaqsoft_test/ui/views/login/custom_text_field.dart';
import 'package:qazaqsoft_test/utils/colors.dart';
import 'package:qazaqsoft_test/utils/routes.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipPath(
          clipper: DiagonalPathClipperTwo(),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Вход",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: AppColors.textLight)),
              SizedBox(
                height: 30,
              ),
              LoginForm()
            ],
          ),
        )
      ],
    ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.backgroundLight,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  label: "Email",
                  onTextChanged: (value) {
                    _email.text = value;
                  }),
              const SizedBox(height: 30),
              CustomTextField(
                  label: "Password",
                  obscureText: true,
                  onTextChanged: (value) {
                    _password.text = value;
                  }),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text.trim();
                  final password = _password.text.trim();
                  try {
                    await AuthService.simple().login(email: email, password: password);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(usersRoute, (route) => false);
                  } on Exception catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ));
  }
}
