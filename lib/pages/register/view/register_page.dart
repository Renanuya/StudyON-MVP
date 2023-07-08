import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/pages/register/model/request_model.dart';
import 'package:thinktank/services/auth.dart';

import '../../../core/constants/enums/provider_enums.dart';
import '../viewmodel/view_model.dart';
import '../../login/view/login_page.dart';
part 'register_page_mixin.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RegisterPageMixin {
  @override
  Widget build(BuildContext context) {
    if (context.watch<RegisterUserProvider>().getIsSucces != null) {
      registerIsSucces();
    }
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'ThinkTank',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: mHeight * 0.044,
            //color: const Color(0xFF37352f),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: mHeight * 0.05),
                EmailTextField(firstNameController: firstNameController),
                SizedBox(height: mHeight * 0.03),
                LastNameTextField(lastNameController: lastNameController),
                SizedBox(height: mHeight * 0.03),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    //  fillColor: Color.fromARGB(255, 238, 238, 238),
                    labelText: 'E-Posta',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    hintText: 'Lütfen e-postanızı girin...',
                    hintStyle: TextStyle(
                      color: Color(0xFFAFAFAC),
                    ),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: mHeight * 0.03),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: context
                      .watch<RegisterPasswordVisibilityProvider>()
                      .getPasswordVisibility,
                  validator: _validatePassword, // Add validation function
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    // fillColor: const Color.fromARGB(255, 238, 238, 238),
                    labelText: 'Şifre',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: 'Lütfen bir şifre girin...',
                    hintStyle: const TextStyle(
                        //  color: Color(0xFFAFAFAC),
                        ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<RegisterPasswordVisibilityProvider>()
                            .setPasswordVisibility();
                      },
                      icon: AnimatedCrossFade(
                        firstChild: const Icon(Icons.visibility_off_outlined),
                        secondChild: const Icon(Icons.visibility_outlined),
                        crossFadeState: context
                                .watch<RegisterPasswordVisibilityProvider>()
                                .getPasswordVisibility
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mHeight * 0.03),
                TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.visiblePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  obscureText: context
                      .watch<RegisterPasswordVisibilityProvider>()
                      .getConfirmPasswordVisibility,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    //fillColor: const Color.fromARGB(255, 238, 238, 238),
                    labelText: 'Şifreyi Onayla',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: 'Lütfen şifrenizi onaylayın...',
                    hintStyle: const TextStyle(
                      color: Color(0xFFAFAFAC),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => context
                          .read<RegisterPasswordVisibilityProvider>()
                          .setConfirmPasswordVisibility(),
                      icon: AnimatedCrossFade(
                        firstChild: const Icon(Icons.visibility_off_outlined),
                        secondChild: const Icon(Icons.visibility_outlined),
                        crossFadeState: context
                                .watch<RegisterPasswordVisibilityProvider>()
                                .getConfirmPasswordVisibility
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<RegisterUserProvider>(
                      builder: (context, value, child) {
                    if (value.getIsSucces == Status.loading) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              //color: Color(0xffFAC6C4),
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(mWidth, mHeight * 0.06),
                          // backgroundColor: const Color(0xffFEF5F2),
                          //foregroundColor: const Color(0xffEB5757),
                          padding: EdgeInsets
                              .zero, // To achieve box-sizing: border-box
                        ),
                        onPressed: null,
                        child: Container(
                          width: 348,
                          height: 72,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator.adaptive(),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              //color: Color(0xffFAC6C4),
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(mWidth, mHeight * 0.06),
                          // backgroundColor: const Color(0xffFEF5F2),
                          //foregroundColor: const Color(0xffEB5757),
                          padding: EdgeInsets
                              .zero, // To achieve box-sizing: border-box
                        ),
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            context
                                .read<RegisterUserProvider>()
                                .setUserRequestModel(
                                  RegisterRequestModel(
                                    name: firstNameController.text,
                                    surname: lastNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          }
                        },
                        child: Container(
                          width: 348,
                          height: 72,
                          alignment: Alignment.center,
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Zaten hesabınız var mı?',
                      style: TextStyle(
                        // color: Color(0xFF4B4B4B),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Giriş yapın',
                        style: TextStyle(
                          //  color: Color(0xFFEB5757),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LastNameTextField extends StatelessWidget {
  const LastNameTextField({
    super.key,
    required this.lastNameController,
  });

  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: lastNameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        // fillColor: Color.fromARGB(255, 238, 238, 238),
        labelText: 'Soyisim',
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: 'Lütfen bir soyisim girin...',
        hintStyle: TextStyle(
          color: Color(0xFFAFAFAC),
        ),
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required this.firstNameController,
  });

  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: firstNameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        //fillColor: Color.fromARGB(255, 238, 238, 238),
        labelText: 'İsim',
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: 'Lütfen bir isim girin...',
        hintStyle: TextStyle(
          color: Color(0xFFAFAFAC),
        ),
        prefixIcon: Icon(Icons.person),
      ),
    );
  }
}
