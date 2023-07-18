import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinktank/profilePage/view/password_renovation.dart';
import 'package:thinktank/profilePage/view/pick_profile_photo_sheet.dart';

import '../../providers/theme.dart';
import '../../theme/dark_theme.dart';
import '../../theme/light_theme.dart';
import '../../theme/theme_service.dart';
import 'help_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late double mHeight;
  late double mWidth;

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 36.0),
                child: Text(
                  'Ayarlar',
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
              child: Container(
                height: mHeight * 0.0696574074074074,
                width: mWidth * 0.805555556,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 48, 48, 48)
                        : const Color(0xFFE7E7E6),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 83, 82, 82)
                      : const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordRenoPage()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Şifreni değiştir',
                        style: TextStyle(
                          //   color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        //  color: Color(0xFF37352F),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mHeight * 0.0115740740740741,
                left: mWidth * 0.0347222222222222,
                right: mWidth * 0.0347222222222222,
              ),
              child: Container(
                height: mHeight * 0.0696574074074074,
                width: mWidth * 0.805555556,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 48, 48, 48)
                        : const Color(0xFFE7E7E6),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 83, 82, 82)
                      : const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    // Kodu buraya ekleyin
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Temayı değiştir',
                        style: TextStyle(
                          //  color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Theme.of(context).brightness == Brightness.dark
                          ? IconButton(
                              onPressed: () {
                                context.read<ThemeChange>().changeTheme =
                                    lightTheme;
                                ThemeService().saveTheme('lightTheme');
                                ThemeService().getThemeFromSave();
                              },
                              icon: const Icon(Icons.sunny),
                            )
                          : IconButton(
                              onPressed: () {
                                context.read<ThemeChange>().changeTheme =
                                    darkTheme;
                                ThemeService().saveTheme('darkTheme');
                                ThemeService().getThemeFromSave();
                              },
                              icon: const Icon(Icons.dark_mode),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mHeight * 0.0115740740740741,
                left: mWidth * 0.0347222222222222,
                right: mWidth * 0.0347222222222222,
              ),
              child: Container(
                height: mHeight * 0.0696574074074074,
                width: mWidth * 0.805555556,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color.fromARGB(255, 48, 48, 48)
                        : const Color(0xFFE7E7E6),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(255, 83, 82, 82)
                      : const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpPage()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Yardım',
                        style: TextStyle(
                          //    color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        //  color: Color(0xFF37352F),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: mHeight * 0.0115740740740741,
                left: mWidth * 0.0347222222222222,
                right: mWidth * 0.0347222222222222,
              ),
              child: Container(
                height: mHeight * 0.0696574074074074,
                width: mWidth * 0.805555556,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffff534c)),
                  color: const Color(0xfffac6c4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    //çıkış işlemi yapılacak
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Çıkış Yap',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF13131),
                            fontSize: 22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
