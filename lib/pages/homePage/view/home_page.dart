import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/utils/navigation/navigation_service.dart';
import '../viewmodel/home_page_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      context
          .read<TimerDataProiver>()
          .getAllTime(FirebaseAuth.instance.currentUser!.uid);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final currentTime = DateTime.now();
    final currentTimeInTurkey =
        currentTime.toUtc().add(const Duration(hours: 3));

    String greeting;

    if (currentTimeInTurkey.hour >= 3 && currentTimeInTurkey.hour < 12) {
      greeting = 'Günaydın';
    } else if (currentTimeInTurkey.hour >= 12 &&
        currentTimeInTurkey.hour < 18) {
      greeting = 'İyi günler';
    } else if (currentTimeInTurkey.hour >= 18 &&
        currentTimeInTurkey.hour < 22) {
      greeting = 'İyi akşamlar';
    } else {
      greeting = 'İyi geceler';
    }

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Center(
            child: SizedBox(
              width: 348,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      user != null
                          ? '$greeting, ${user.displayName}'
                          : greeting,
                      style: const TextStyle(
                        // color: Color(0xFF37352F),
                        fontSize: 26,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Diğer yatayda yer almasını istediğiniz widget'ları buraya ekleyebilirsiniz.
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 348,
            height: 244,
            child: Card(
              child: Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Çalışmaya başlayın!',
                        style: TextStyle(
                          //   color: Color(0xFF37352F),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              //color: Color(0xFF37352F),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Bu gün ${context.watch<TimerDataProiver>().getModel.daily ?? '0'} puan kazandınız.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              // color: Color(0xFF37352F),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Bu hafta ${context.watch<TimerDataProiver>().getModel.weekly ?? '0'} puan kazandınız.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              // color: Color(0xFF37352F),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Bu ay ${context.watch<TimerDataProiver>().getModel.monthly ?? '0'} puan kazandınız.',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 285,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationService.instance.navigateToPage(
                          path: NavigationConstants.timerPage,
                          //! timer sayfasına atacak ama hata vardı timer sayfasında o yüzden böyle tıklamayın.
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                //     color: Color(0xFFFF534D),
                                ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Zamanlayıcı Aç',
                        style: TextStyle(
                          fontSize: 22,
                          //  color: Color(0xffF13131),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Card(
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.calendar_month,
                        size: 40,
                      ),
                      label: const Text(
                        'Takvim',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
                          NavigationService.instance.navigateToPage(
                              path: NavigationConstants.calendarPage);
                        } else {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Önce hesap açmalısınız'),
                                  content: const SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Bu özelliği kullanabilmeniz için önce hesap açmalısınız.'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Devam et')),
                                    TextButton(
                                      child: const Text('Hesap aç'),
                                      onPressed: () {
                                        NavigationService.instance
                                            .navigateToPageRemoveAll(
                                                path: NavigationConstants
                                                    .loginPage);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Card(
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.leaderboard,
                        size: 40,
                      ),
                      label: const Text(
                        'Sıralama',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        NavigationService.instance.navigateToPage(
                            path: NavigationConstants.rankingPage);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Card(
                    child: TextButton.icon(
                      icon: const Icon(
                        Icons.menu_book,
                        size: 40,
                      ),
                      label: const Text(
                        'Blog',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        NavigationService.instance
                            .navigateToPage(path: NavigationConstants.blogPage);
                      },
                    ),
                  ),
                ),
                Card(
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.person,
                      size: 40,
                    ),
                    label: const Text(
                      'profil',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      NavigationService.instance.navigateToPage(
                          path: NavigationConstants.profilePage);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}// '${context.watch<TimerDataProiver>().getModel.allTime ?? '0'}'
