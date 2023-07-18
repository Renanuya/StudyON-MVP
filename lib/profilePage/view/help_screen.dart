import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late double mHeight;
  late double mWidth;
  TextEditingController adSoyadController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController konuController = TextEditingController();
  TextEditingController aciklamaController = TextEditingController();
  
  

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
                    'Yardım ',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
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
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-ZğüşıöçĞÜŞİÖÇ ]')),
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
                  
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Konu',
                    hintText: 'Lütfen Yardım almak istediğiniz konuyu yazınız...',
                  ),
                  controller: konuController,
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
                    labelText: 'Açıklama',
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
                    String konu = konuController.text;

                    if (adSoyad.isNotEmpty && aciklama
                  .isNotEmpty && konu
                  .isNotEmpty) {
                            CollectionReference feedbackKayitlarRef =
                            FirebaseFirestore.instance.collection('helpPage');

                            feedbackKayitlarRef.doc().collection('helpkayitlar').add({
                                'adSoyad': adSoyad,
                                'email': email,
                                'konu': konu,
                                'timestamp': FieldValue.serverTimestamp(),
                            })
                            .then((value){
                              adSoyadController.clear();
                              emailController.clear();
                              konuController.clear();
                              aciklamaController.clear();
                           
                            })
                                .catchError((error) {
                              // ignore: avoid_print
                              print('Veri kaydedilirken bir hata oluştu: $error');
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Hata'),
                                  content: const Text('Lütfen tüm alanları doldurun.'),
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
