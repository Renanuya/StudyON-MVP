import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thinktank/profilePage/view/settings_screen.dart';

import '../../pages/rankPages/veiwmodel/rank_view_model.dart';
import '../viewModel/view_model_profile.dart';
import 'faq_screen.dart';
import 'feedback_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void davetiyeGonder() {
    String mesaj =
        "Merhaba, uygulama henüz hazır değil, yayınlandığında sizi tekrar bilgilendireceğiz.";

    Share.share(mesaj);
  }

  @override
  void initState() {
    context.read<PickProfilePhoto>().fetchProfileInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<RankUserListDataProviderAllTime>(context, listen: true);

    double mHeight = MediaQuery.of(context).size.height;
    double mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Profil',
                style: TextStyle(
                  fontSize: 36.0,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 150,
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
                            builder: (context) => const SettingsPage()),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Ayarlar',
                        style: TextStyle(
                          //  color: const Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                        MaterialPageRoute(
                            builder: (context) => const FAQPage()),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Sıkça sorulan sorular',
                        style: TextStyle(
                          //  color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                        MaterialPageRoute(
                            builder: (context) => const FeedbackPage()),
                      );
                    },
                    child: const Center(
                      child: Text(
                        'Geri bildirim gönder',
                        style: TextStyle(
                          //  color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
                    onPressed: davetiyeGonder,
                    child: const Center(
                      child: Text(
                        'Arkadaşını davet et',
                        style: TextStyle(
                          //  color: Color(0xFF37352F),
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
