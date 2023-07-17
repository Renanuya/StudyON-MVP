import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondBrainPage extends StatelessWidget {
  const SecondBrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Study',
            style: GoogleFonts.pacifico(
              fontSize: mHeight * 0.04,
              color: const Color(0xFF37352f),
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
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Second Brain Çalışma Tekniği',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Ders çalışma süreci, öğrenme sürecinin önemli bir parçasıdır. Öğrencilerin bilgiyi daha etkili bir şekilde öğrenmelerini ve anlamalarını sağlamak için farklı çalışma teknikleri kullanılır. Bu tekniklerden biri de "SecondBrain" olarak adlandırılan bir yaklaşımdır. SecondBrain, bilgileri daha iyi organize etmek, hatırlamak ve sentezlemek için dijital araçları kullanmayı vurgulayan bir ders çalışma yaklaşımıdır. \n\nSecondBrain, aslında bir dizi adımla gerçekleştirilen bir süreçtir. İşte SecondBrain ders çalışma tekniğinin adımları:  \n\n1- Bilgi Toplama: İlk adım, öğrenmek istediğiniz konuyla ilgili bilgi toplamaktır. Bu adımda kitapları, makaleleri, ders notlarını, videoları ve diğer kaynakları kullanarak konuyla ilgili bilgi edinmelisiniz. Bu kaynakları inceleyerek önemli noktaları belirleyin ve notlar alın.\n\n2- Dijital Araçlar Kullanma: SecondBrain yaklaşımı, dijital araçların kullanımını vurgular. Bilgiyi daha iyi organize etmek ve hatırlamak için not alma, not düzenleme ve bilgi paylaşımı gibi dijital araçları kullanabilirsiniz. Örneğin, notlarınızı Evernote veya OneNote gibi uygulamalarda tutabilirsiniz. Böylece notlarınıza istediğiniz zaman erişebilir ve düzenleyebilirsiniz.\n\n3- Aktif Öğrenme: SecondBrain tekniği, sadece bilgiyi pasif olarak tüketmek yerine, aktif olarak öğrenmeyi vurgular. Bu nedenle, bilgileri okumak yerine, öğrendiklerinizi tekrar etmek, sorular sormak, özetler yazmak ve kendi sözcüklerinizle anlatmak gibi aktif öğrenme yöntemlerini kullanmalısınız. Bu, bilgileri daha iyi anlamanıza ve hafızada kalıcı hale getirmenize yardımcı olur. \n\n4- Bağlantılar Kurma: SecondBrain tekniği, bilgiler arasında bağlantılar kurmayı önemser. Öğrendiğiniz konuları ilişkilendirerek, bilgileri daha bütünsel bir şekilde anlamanızı ve hatırlamanızı sağlar. Bunun için, farklı konular arasında ortak noktaları bulmaya çalışabilir, kavram haritaları veya bağlantı diyagramları oluşturabilirsiniz. Böylece, bilgileri daha iyi bir bağlam içinde değerlendirebilirsiniz. \n\n5- krar: SecondBrain tekniği, bilgileri düzenli olarak tekrar etmeyi vurgular. Bilgileri tekrarlamak, bilgilerin uzun vadeli bellekte yerleşmesini sağlar. Bu nedenle, düzenli aralıklarla öğrendiğiniz konuları gözden geçirin ve tekrarlayın. Öğrendiklerinizi bir süre sonra tekrar ele almak, bilgilerinizi güçlendirir.\n\nSecondBrain ders çalışma tekniği, bilgileri daha etkili bir şekilde öğrenmek ve hatırlamak için dijital araçları etkin bir şekilde kullanmayı vurgular. Bu teknik, bilgilerinizi daha iyi organize etmenizi, aktif öğrenme yöntemlerini kullanmanızı ve bilgiler arasında bağlantılar kurmanızı sağlar. Unutmayın, herkesin öğrenme tarzı farklı olduğu için, bu teknik size uygun olmayabilir. Kendi öğrenme tarzınıza uygun yöntemleri deneyerek, en etkili çalışma yöntemini bulmanız önemlidir. ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
