import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinktank/pages/profileSettingPage/profilePage/faq_screen.dart';
import 'package:thinktank/pages/profileSettingPage/settingPage/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../login/view/login_page.dart';
import 'feedback_screen.dart';

void shareAppLinkOnWhatsApp() async {
  String downloadLink = 'https://example.com/app-release.apk'; 
  String message = 'Uygulamayı indirin: $downloadLink';
  String url = 'https://wa.me/?text=${Uri.encodeFull(message)}';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'WhatsApp uygulaması bulunamadı';
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.0810185185),
                    child: Container(
                      width: mWidth * 0.805555556,
                      height: mHeight * 0.25462963,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFE7E7E6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: mWidth * 0.0462962962962963,
                          left: mWidth * 0.0462962962962963,
                          top: mHeight * 0.0462962962962963,
                          bottom: mHeight * 0.0231481481481481,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (user == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                user?.displayName ?? 'Önce hesap açmalısınız',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: mWidth * 0.0555555555555556,
                                  //  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: mHeight * 0.01,
                              ),
                              Container(
                                width: mWidth * 0.6481481481481481,
                                height: mHeight * 0.1157407407407407,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFC9C7C7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star_border_outlined,
                                          size: mWidth * 0.0694444444444444,
                                        ),
                                        Text(
                                          'Puan',
                                          style: TextStyle(
                                            color: const Color(0xFF37352F),
                                            fontSize:
                                                mWidth * 0.037037037037037,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '590',
                                          style: TextStyle(
                                            color: const Color(0xFF37352F),
                                            fontSize:
                                                mWidth * 0.037037037037037,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(
                                      color: Color(0xFFffffff),
                                      thickness: 2,
                                      indent: 20,
                                      endIndent: 20,
                                      width: 0,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.public_outlined,
                                          size: mWidth * 0.0694444444444444,
                                        ),
                                        Text(
                                          'Sıralama',
                                          style: TextStyle(
                                            color: const Color(0xFF37352F),
                                            fontSize:
                                                mWidth * 0.037037037037037,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          '#1',
                                          style: TextStyle(
                                            color: const Color(0xFF37352F),
                                            fontSize:
                                                mWidth * 0.037037037037037,
                                            fontFamily: 'Nunito',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),  
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: mWidth * 0.287037037037037,
                    top: 0,
                    child: Container(
                      width: mHeight * 0.1157407407407407,
                      height: mHeight * 0.1157407407407407,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://via.placeholder.com/100x100"),
                          fit: BoxFit.fill,
                        ),
                        shape: OvalBorder(
                          side: BorderSide(
                              width: mWidth * 0.0011574074074074,
                              color: const Color(0xFF37352F)),
                        ),
                        shadows: const [
                          BoxShadow(
                            //  color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                  border: Border.all(color: const Color(0xffa4a4a3)),
                  color: const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Ayarlar',
                          style: TextStyle(
                            color: const Color(0xFF37352F),
                            fontSize:22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        )
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
                  border: Border.all(color: const Color(0xffa4a4a3)),
                  color: const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FAQPage()),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'Sıkça sorulan sorular',
                          style: TextStyle(
                            color: Color(0xFF37352F),
                            fontSize:22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        )
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
                  border: Border.all(color: const Color(0xffa4a4a3)),
                  color: const Color(0xffe7e7e6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()),
                        );

                      },
                      child: const Center(
                        child: Text(
                          'Geri bildirim gönder',
                          style: TextStyle(
                            color: Color(0xFF37352F),
                            fontSize:22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        )
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
                  border: Border.all(color: const Color(0xffa4a4a3)),
                  color: const Color(0xffe7e7e6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                child: const TextButton(
                      onPressed: shareAppLinkOnWhatsApp,
                      child: Center(
                        child: Text(
                          'Arkadaşını davet et',
                          style: TextStyle(
                            color: Color(0xFF37352F),
                            fontSize:22,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        )
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
