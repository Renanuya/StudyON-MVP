import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordRenoPage extends StatefulWidget {
  const PasswordRenoPage({Key? key}) : super(key: key);

  @override
  State<PasswordRenoPage> createState() => _PasswordRenoPageState();
}

class _PasswordRenoPageState extends State<PasswordRenoPage> {
  late double mHeight;
  late double mWidth;

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Şifreniz başarıyla güncellendi!'),
        backgroundColor: Colors.green, // İstediğiniz bir renk seçebilirsiniz.
      ),
    );
  }

  void sifreyiDegistir() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('Kullanıcı oturumu açmamış');
      return;
    }

    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      print('Yeni şifreler uyuşmuyor');
      return;
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      print('Şifre güncellendi');
      _showSuccessMessage();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Eski şifre yanlış');
      } else {
        print('Şifre güncelleme hatası: ${e.message}');
      }
    } catch (e) {
      print('Şifre güncelleme hatası: $e');
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Eski şifrenizi girin';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Yeni şifrenizi girin';
    }
    if (value.length < 6) {
      return 'Yeni şifre en az 6 karakter olmalıdır';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Yeni şifrenizi tekrar girin';
    }
    if (value != _newPasswordController.text) {
      return 'Yeni şifreler uyuşmuyor';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 36.0),
                  child: Text(
                    'Şifreni Değiştir',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: mHeight * 0.0115740740740741,
                  left: mWidth * 0.0347222222222222,
                  right: mWidth * 0.0347222222222222,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: TextFormField(
                  controller: _oldPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Eski Şifreniz',
                    hintText: 'Lütfen Eski Şifrenizi Giriniz...',
                  ),
                  obscureText: true,
                  validator: _validateOldPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Yeni Şifreniz',
                    hintText: 'Lütfen Yeni Şifrenizi Giriniz',
                  ),
                  obscureText: true,
                  validator: _validateNewPassword,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Yeni Şifreniz Tekrar',
                    hintText: 'Lütfen Yeni Şifrenizi Tekrar Giriniz',
                  ),
                  obscureText: true,
                  validator: _validateConfirmPassword,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                          color: Color(0xffEB5757),
                          width: 0.4,
                        )),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(mWidth, mHeight * 0.06),
                    backgroundColor: const Color(0xffFEF5F2),
                    foregroundColor: const Color(0xffEB5757),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sifreyiDegistir();
                    }
                  },
                  child: const Text('Şifreyi Değiştir',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffEB5757),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
