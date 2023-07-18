import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late double mHeight;
  late double mWidth;
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();
  String? selectedBlok;

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 36.0),
                  child: Text(
                    'Geri Bildirim Formu',
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
                  height: mHeight * 0.1096574074074074,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Geri Bildirim Türü :",
                            style: TextStyle(
                              // color: Color(0xFF37352F),
                              fontSize: 16,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Radio<String>(
                              value: "Öneri",
                              groupValue: selectedBlok,
                              onChanged: (value) {
                                setState(() {
                                  selectedBlok = value;
                                });
                              },
                            ),
                          ),
                          const Text("Öneri"),
                          Radio<String>(
                            value: "Şikayet",
                            groupValue: selectedBlok,
                            onChanged: (value) {
                              setState(() {
                                selectedBlok = value;
                              });
                            },
                          ),
                          const Text("Şikayet"),
                          Center(
                            child: Radio<String>(
                              value: "Soru",
                              groupValue: selectedBlok,
                              onChanged: (value) {
                                setState(() {
                                  selectedBlok = value;
                                });
                              },
                            ),
                          ),
                          const Text("Soru"),
                        ],
                      ),
                    ],
                  ),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZğüşıöçĞÜŞİÖÇ ]')),
                  ],
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Adınız',
                    hintText: 'Lütfen Adınızı Giriniz...',
                  ),
                  controller: adSoyadController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'E-posta',
                    hintText: 'Lütfen E-posta Adresinizi Giriniz...',
                  ),
                  controller: emailController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mWidth * 0.0937222222222222,
                  vertical: mHeight * 0.0115740740740741,
                ),
                child: TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Açıklayınız',
                    hintText: 'Lütfen Açıklamanızı Giriniz...',
                  ),
                  controller: aciklamaController,
                ),
              ),
              const SizedBox(height: 10.0),
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
                    String adSoyad = adSoyadController.text;
                    String email = emailController.text;
                    String aciklama = aciklamaController.text;

                    if (adSoyad.isNotEmpty &&
                        email.isNotEmpty &&
                        selectedBlok != null &&
                        aciklama.isNotEmpty) {
                      CollectionReference feedbackKayitlarRef =
                          FirebaseFirestore.instance
                              .collection('feedbackKayitlar');

                      feedbackKayitlarRef
                          .doc(selectedBlok)
                          .collection('kayitlar')
                          .add({
                        'adSoyad': adSoyad,
                        'email': email,
                        'aciklama': aciklama,
                        'timestamp': FieldValue.serverTimestamp(),
                      }).then((value) {
                        adSoyadController.clear();
                        emailController.clear();
                        aciklamaController.clear();
                        selectedBlok = null;

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Teşekkür Ederiz'),
                              content: const Text(
                                  'Geri bildirim formu başarıyla gönderildi.'),
                              actions: [
                                TextButton(
                                  child: const Text('Tamam'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }).catchError((error) {
                        // ignore: avoid_print
                        print('Veri kaydedilirken bir hata oluştu: $error');
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Hata'),
                            content:
                                const Text('Lütfen tüm alanları doldurun.'),
                            actions: [
                              TextButton(
                                child: const Text('Tamam'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Gönder',
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
    );
  }
}
