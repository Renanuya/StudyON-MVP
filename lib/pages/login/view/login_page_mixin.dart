part of 'login_page.dart';

mixin LoginPageMixin on State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // void _changeLoading() {
  //   setState(() {
  //     _isSecure = !_isSecure;
  //   });
  // }
  // void checkLogin() {
  //   if (mounted) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomePage(),
  //         ),
  //         (route) => false);
  //   }
  // }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
}
