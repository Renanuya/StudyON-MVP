import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/core/constants/enums/provider_enums.dart';
import 'package:thinktank/pages/home_page.dart';
import 'package:thinktank/pages/login/model/login_request_model.dart';
import 'package:thinktank/pages/login/viewmodel/view_model.dart';
import 'package:thinktank/services/auth.dart';

import '../../register/view/register_page.dart';
import '../../register/view/reset_password.dart';
part 'login_page_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final AuthService _authService = AuthService();

class _LoginPageState extends State<LoginPage> with LoginPageMixin {
  @override
  Widget build(BuildContext context) {
    // if (context.watch<UserLoginProvider>().getLoginIsSucces == Status.success) {
    //   checkLogin();
    // }
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ThinkTank',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: mHeight * 0.044,
            color: const Color(0xFF37352f),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  LoginUserTextFormField(emailController: emailController),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: context
                        .watch<LoginPasswordVisibilityProvider>()
                        .isPasswordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: 'Şifre',
                      hintText: 'Lütfen Şifrenizi Giriniz...',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => context
                            .read<LoginPasswordVisibilityProvider>()
                            .changePasswordVisibility(),
                        icon: AnimatedCrossFade(
                          firstChild: const Icon(Icons.visibility_off_outlined),
                          secondChild: const Icon(Icons.visibility_outlined),
                          crossFadeState: context
                                  .watch<LoginPasswordVisibilityProvider>()
                                  .isPasswordVisible
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Zorunlu Alan'),
                      FormBuilderValidators.minLength(6,
                          errorText: 'En az 6 karakter olmalıdır.'),
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          'Şifrenizi mi unuttunuz?',
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResetPassword()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<UserLoginProvider>(
                        builder: (context, value, child) {
                      if (value.getLoginIsSucces == Status.wrongPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Şifreniz yanlış'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      if (value.getLoginIsSucces == Status.loading) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(),
                            ),
                            elevation: 0,
                            minimumSize: Size(mWidth, mHeight * 0.06),
                          ),
                          onPressed: null,
                          child: const CircularProgressIndicator.adaptive(),
                        );
                      } else {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(),
                            ),
                            elevation: 0,
                            minimumSize: Size(mWidth, mHeight * 0.06),
                          ),
                          onPressed: () {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty &&
                                _key.currentState!.validate()) {
                              context
                                  .read<UserLoginProvider>()
                                  .userLoginWithEmailPassword(
                                    LoginRequestModel(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                          child: const Text(
                            'Giriş',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Ya da ?',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _authService.signInWithGoogle();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(),
                        ),
                        elevation: 0,
                        minimumSize: Size(mWidth, mHeight * 0.06),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Google ile Giriş Yap',
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Bir hesabın yok mu ? ',
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginUserTextFormField extends StatelessWidget {
  const LoginUserTextFormField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Kullanıcı Adı veya E-Posta',
        hintText: 'Kullanıcı Adı veya E-Posta Adresinizi Giriniz',
        hintStyle: const TextStyle(fontSize: 11),
        prefixIcon: const Icon(Icons.mail_outline_rounded),
        suffixIcon: emailController.text.isEmpty
            ? const SizedBox(width: 0.0, height: 0.0)
            : IconButton(
                onPressed: () {
                  emailController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: 'Zorunlu Alan'),
        FormBuilderValidators.email(errorText: 'Geçerli Bir E-Posta Giriniz'),
      ]),
    );
  }
}
//TODO ya da