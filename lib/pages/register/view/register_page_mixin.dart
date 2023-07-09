part of 'register_page.dart';

mixin RegisterPageMixin on State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _authService = AuthService();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta alanı boş olamaz.';
    }

    // Use a regular expression to validate the email format
    final emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin.';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı boş olamaz.';
    }

    if (value.length < 8) {
      return 'Şifre en az 8 karakter uzunluğunda olmalıdır.';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifre en az bir büyük harf içermelidir.';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Şifre en az bir küçük harf içermelidir.';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifre en az bir sayı içermelidir.';
    }

    return null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void registerIsSucces() {
    final isSuccess = context.watch<RegisterUserProvider>().getIsSucces;
    if (isSuccess == Status.success) {
      print('Kayıt olma işlemi başarılı, giriş yapabilirsiniz');
    } else if (isSuccess == Status.failed) {
      print('Kayıt işlemi başarısız oldu, lütfen tekrar deneyiniz');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
