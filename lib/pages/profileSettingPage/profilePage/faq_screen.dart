import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';


class FAQPage extends StatefulWidget {
  const FAQPage({Key? key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 36.0),
                child: Text(
                  'Sıkça Sorulan Sorular',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: ExpansionTileCard(
                      baseColor: const Color(0xfffac6c4),
                      expandedColor: const Color(0xffe7e7e6),
                      key: cardA,
                      leading: CircleAvatar(
                        child: Image.asset("assets/images/image_1.png"),
                      ),
                      title: const Text(
                        "StudyOn",
                        style: TextStyle(
                          color: const Color(0xFF37352F),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text("StudyOn uygulaması nedir?"),
                      children: <Widget>[
                        const Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "StudyOn, kullanıcıların yalnız çalıştıklarında motivasyon eksikliği yaşamalarını gidermeyi hedefleyen bir mobil uygulamadır. Uygulama çalışma sürelerinizi ölçebileceğiniz ve rekabet edebileceğiniz bir platform sağlar.",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                          children: <Widget>[
                           
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              onPressed: () {
                                cardA.currentState?.collapse();
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Text('Kapat'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: ExpansionTileCard(
                      baseColor: Color(0xfffac6c4),
                      expandedColor: const Color(0xffe7e7e6),
                      key: cardB,
                      leading: CircleAvatar(
                        child: Image.asset("assets/images/image_1.png"),
                      ),
                      title: const Text(
                        "StudyOn",
                        style: TextStyle(
                          color: const Color(0xFF37352F),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text("Kronometre özelliği nasıl çalışır?"),
                      children: <Widget>[
                        const Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "StudyOn, çalışma sürelerinizi ölçmek ve takip etmek için bir kronometre sağlar. Kronometrenin bulunduğu kısımdaki hedefinizi belirleyin butonuna basarak Hedefinizi belileyip kronometreyi başlatarak çalışma sürenizi kaydedebilir, duraklatabilir ve sonlandırabilirsiniz. Bu sayede verimli çalışma alışkanlıklarınızı izleyebilir ve geliştirebilirsiniz.",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                          children: <Widget>[
                            
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              onPressed: () {
                                cardB.currentState?.collapse();
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Text('Kapat'),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: ExpansionTileCard(
                      baseColor: const Color(0xfffac6c4),
                      expandedColor: const Color(0xffe7e7e6),
                      key: cardC,
                      leading: CircleAvatar(
                        child: Image.asset("assets/images/image_1.png"),
                      ),
                      title: const Text(
                        "StudyOn",
                        style: TextStyle(
                          color: Color(0xFF37352F),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: const Text("Destek ekibiyle nasıl iletişime geçebilirim?"),
                      children: <Widget>[
                        const Divider(
                          thickness: 1.0,
                          height: 1.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Text(
                              "StudyOn uygulamasıyla ilgili herhangi bir sorunuz, öneriniz veya sorun yaşadığınızda destek ekibiyle iletişime geçmek için Ayarlar sayfasında bulunan Yardım  veya Profil sayfasında bulunan Geri bildirim gönder kısmından destek ekibiyle iletişime geçebilirsiniz.",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          buttonHeight: 52.0,
                          buttonMinWidth: 90.0,
                          children: <Widget>[
                            
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              onPressed: () {
                                cardB.currentState?.collapse();
                              },
                              child: const Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                  ),
                                  Text('Kapat'),
                                ],
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
          ],
        ),
      ),
    );
  }
}
