import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/core/constants/enums/provider_enums.dart';
import 'package:thinktank/core/utils/show_snackbar.dart';

import 'package:thinktank/pages/login/model/login_request_model.dart';
import 'package:thinktank/pages/login/viewmodel/view_model.dart';

import 'package:thinktank/services/auth.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/utils/navigation/navigation_service.dart';

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
    /* if (context.watch<UserLoginProvider>().getLoginIsSucces ==
        Status.wrongPassword) {
      ShowSnackbar.instance.errorSnackBar('Şifre Hatalı');
    } else if (context.watch<UserLoginProvider>().getLoginIsSucces ==
        Status.userNotFound) {
      ShowSnackbar.instance.errorSnackBar('Kullanıcı Bulunamadı');
    } else if (context.watch<UserLoginProvider>().getLoginIsSucces ==
        Status.manyTried) {
      ShowSnackbar.instance.errorSnackBar(
          'Çok fazla deneme yaptınız. Lütfen daha sonra tekrar deneyiniz.');
    }*/
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Study',
                    style: GoogleFonts.pacifico(
                      fontSize: mHeight * 0.04,
                      //  color: const Color(0xFF37352f),
                    ),
                    children: const [
                      TextSpan(
                        text: 'On',
                        style: TextStyle(
                          color: Color.fromARGB(255, 101, 191, 107),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Theme.of(context).brightness == Brightness.dark
                    ? Image.asset('assets/images/loginpage.png',
                        height: mHeight * 0.2, width: mWidth * 0.7)
                    : Image.asset('assets/images/loginpage.png',
                        height: mHeight * 0.2, width: mWidth * 0.7),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilder(
                      autoFocusOnValidationFailure: true,
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          LoginUserTextFormField(
                              emailController: emailController),
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
                                  firstChild:
                                      const Icon(Icons.visibility_off_outlined),
                                  secondChild:
                                      const Icon(Icons.visibility_outlined),
                                  crossFadeState: context
                                          .watch<
                                              LoginPasswordVisibilityProvider>()
                                          .isPasswordVisible
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: 'Zorunlu Alan'),
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
                                          builder: (context) =>
                                              const ResetPassword()));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Consumer<UserLoginProvider>(
                                builder: (context, value, child) {
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
                                  child: const CircularProgressIndicator
                                      .adaptive(),
                                );
                              } else {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size(mWidth, mHeight * 0.06),
                                  ),
                                  onPressed: () {
                                    // _key.currentState!.validate()
                                    if (formkey.currentState?.validate() ??
                                        false) {
                                      try {
                                        context
                                            .read<UserLoginProvider>()
                                            .userLoginWithEmailPassword(
                                              LoginRequestModel(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                      } finally {
                                        NavigationService.instance
                                            .navigateToPageRemoveAll(
                                                path: NavigationConstants
                                                    .authPage);
                                      }
                                    } else {
                                      ShowSnackbar.instance.errorSnackBar(
                                          'Lütfen gerekli alanları doldurunuz.');
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
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Ya da ?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await _authService.signInWithGoogle();
                                NavigationService.instance
                                    .navigateToPageRemoveAll(
                                  path: NavigationConstants.homePage,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                minimumSize: Size(mWidth, mHeight * 0.06),
                              ),
                              icon: const Icon(
                                FontAwesomeIcons.google,
                                // color: Colors.black,
                              ),
                              label: const Text(
                                'Google ile Giriş Yap',
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              NavigationService.instance
                                  .navigateToPageRemoveAll(
                                path: NavigationConstants.registerPage,
                              );
                            },
                            child: const Text(
                              'Bir hesabın yok mu? Kayıt ol',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: emailController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'E-Posta',
        hintText: 'E-Posta Adresinizi Giriniz',
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

//TODO: LoginUserTextFormField "validator" çalışmıyor.