import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thinktank/pages/rankPages/view/rank_page.dart';
import '../../calendar/calendar_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference timerDataCollection =
      FirebaseFirestore.instance.collection('timerdata');
  String greeting = '';

  @override
  void initState() {
    super.initState();
    greeting = getGreetingMessage();
  }

  String getGreetingMessage() {
    var now = DateTime.now();
    var turkeyTime =
        now.toUtc().add(Duration(hours: 3)); // Türkiye saatine göre ayarla

    var hour = turkeyTime.hour;
    String greetingMessage;

    if (hour >= 6 && hour < 12) {
      greetingMessage = 'Günaydın';
    } else if (hour >= 12 && hour < 18) {
      greetingMessage = 'İyi günler';
    } else if (hour >= 18 && hour < 24) {
      greetingMessage = 'İyi akşamlar';
    } else {
      greetingMessage = 'İyi geceler';
    }

    return greetingMessage;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 348,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 59, 0),
                          child: Text(
                            user != null
                                ? '$greeting, ${user.displayName}'
                                : 'Aramıza Hoş geldin',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF37352F),
                              fontSize: 26,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 348,
              height: 244,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffa4a4a3)),
                color: const Color(0xffe7e7e6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Ders çalışmaya başlayın',
                    style: TextStyle(
                      color: Color(0xFF37352F),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 5),
                        child: Icon(
                          Icons.edit_note,
                        ),
                      ),
                      TimerDataScreen(),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 5),
                        child: Icon(
                          Icons.edit_note,
                        ),
                      ),
                      TimerDataScreen(),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 5),
                        child: Icon(
                          Icons.edit_note,
                        ),
                      ),
                      TimerDataScreen(),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffff534c)),
                      color: const Color(0xfffac6c4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Center(
                        child: Text(
                          'Zamanlayıcı Aç',
                          style: TextStyle(
                            color: Color(0xFFF13131),
                            fontSize: 24,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 31.7),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: const Color(0xffE5E5E3),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xffA5A5A3),
                                )),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Takvim',
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                color: const Color(0xffE5E5E3),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xffA5A5A3),
                                )),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Takvim',
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: const Color(0xffE5E5E3),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xffA5A5A3),
                                  )),
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Takvim',
                                  )),
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: const Color(0xffE5E5E3),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xffA5A5A3),
                                  )),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Takvim',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            /*Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 30),
              width: double.infinity,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CalendarMainPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 36, 17, 34),
                        margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa4a4a3)),
                          color: const Color(0xffe7e7e6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              width: 30,
                              height: 30,
                              child: const Icon(
                                Icons.calendar_month_outlined,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                              child: const Text(
                                'Takvim',
                                style: TextStyle(
                                  color: Color(0xFF37352F),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RankPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 36, 17, 34),
                        margin: const EdgeInsets.fromLTRB(
                            0, 0, 30, 0), // Add right margin
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa4a4a3)),
                          color: const Color(0xffe7e7e6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              width: 15,
                              height: 30,
                              child: const Icon(
                                Icons.format_list_numbered,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                              child: const Text(
                                'Sıralama',
                                style: TextStyle(
                                  color: Color(0xFF37352F),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
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
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 3, 0),
              width: double.infinity,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 36, 17, 34),
                        margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa4a4a3)),
                          color: const Color(0xffe7e7e6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              width: 15,
                              height: 30,
                              child: const Icon(
                                Icons.group_rounded,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                              child: const Text(
                                'boş',
                                style: TextStyle(
                                  color: Color(0xFF37352F),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Buraya işlemlerini ekleyebilirsiniz
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 36, 17, 34),
                        margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffa4a4a3)),
                          color: const Color(0xffe7e7e6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                              width: 15,
                              height: 30,
                              child: const Icon(
                                Icons.format_list_numbered,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                              child: const Text(
                                'boş',
                                style: TextStyle(
                                  color: Color(0xFF37352F),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
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
            ),*/
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('çıkış'))
          ],
        ),
      ),
    );
  }
}

class TimerDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference timerDataCollection =
        FirebaseFirestore.instance.collection('timerdata');

    return FutureBuilder<DocumentSnapshot>(
      future: timerDataCollection.doc('daily').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String dailyData = data['daily'];

        return Text("Daily Data: $dailyData");
      },
    );
  }
}


//ALKAN ABİYE SORULACAK

