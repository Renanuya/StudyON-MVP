import 'package:flutter/material.dart';
import 'package:thinktank/pages/login/view/login_page.dart';
import 'package:thinktank/pages/register/view/register_page.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
      isLogin ? const LoginPage() : const RegisterPage();

  void toggle() => setState(() => isLogin = !isLogin);
}
