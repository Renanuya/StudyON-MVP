import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PomodoroPage extends StatelessWidget {
  const PomodoroPage({super.key});

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
                    'Pomodoro Çalışma Tekniği',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Pomodoro Tekniği, zamanı verimli kullanmayı hedefleyen bir çalışma yöntemidir. Francesco Cirillo tarafından geliştirilen bu teknik, çalışma süresini kısa dilimlere bölmeyi ve düzenli aralıklarla mola vererek çalışma döngüleri oluşturmayı vurgular. Adını, kullanılan mutfak kronometresi olan bir domates şeklindeki zamanlayıcıdan almıştır. Pomodoro, İtalyanca\'da domates anlamına gelir.\n\nPomodoro Tekniği aşağıdaki adımlardan oluşur:\n\n1- Hedef Belirleme: İlk adım, çalışmak istediğiniz hedefi belirlemektir. Bu hedef, bir ders çalışma süreci, bir proje veya başka bir görev olabilir. Hedefinizi net ve ölçülebilir bir şekilde belirlemek önemlidir.\n\n2- Zaman Dilimlerini Belirleme: Çalışma sürenizi kısa dilimlere böleceğiniz zaman dilimlerini belirleyin. Pomodoro Tekniği genellikle 25 dakikalık çalışma süresine 5 dakikalık mola vererek çalışma döngüleriyle uygulanır. Bu döngüyü bir pomodoro olarak adlandırabilirsiniz.\n\n3- Çalışma Döngüsü: Belirlediğiniz çalışma süresi boyunca odaklanarak çalışmaya başlayın. Distractions olabilecek faktörlerden uzaklaşın ve tamamen hedefe odaklanın. 25 dakikalık çalışma süresi boyunca kesintisiz bir şekilde çalışın.\n\n4- Mola Verme: Bir pomodoro çalışma döngüsü tamamlandıktan sonra, 5 dakikalık bir mola verin. Bu molada kısa bir yürüyüş yapabilir, biraz esneme hareketleri yapabilir veya bir şeyler atıştırabilirsiniz. Mola süresinde beyninizin dinlenmesine ve enerji toplamasına izin verin.\n\n5- omodoro Sayısını İzleme: Her dört pomodoro çalışma döngüsünden sonra, daha uzun bir mola verin. Genellikle 15-30 dakikalık bir mola önerilir. Bu molada tamamen dinlenmeye çalışın ve beyninizi rahatlatın.\n\n6- Devam Etme: Pomodoro süreçlerini belirlediğiniz hedefe ulaşana kadar tekrarlayın. Sürekli olarak çalışma döngülerini tamamlayarak ilerlemeye devam edin.\n\nPomodoro Tekniği, zamanı daha verimli kullanmayı sağlar. Düzenli çalışma süreleri ve mola verme periyotları, konsantrasyonu artırır ve işlerinizi daha iyi yönetmenizi sağlar. Ayrıca, sık sık mola vermek, motivasyonu yüksek tutar ve tükenmeyi engeller. Ancak, her bireyin çalışma süresi ve mola periyotlarına farklı bir yanıt verdiğini unutmayın. Pomodoro Tekniği, bazı kişilere uyarken diğerleri için uygun olmayabilir. Kendi çalışma alışkanlıklarınızı ve tercihlerinizi göz önünde bulundurarak, en etkili çalışma yöntemini bulmanız önemlidir.',
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
